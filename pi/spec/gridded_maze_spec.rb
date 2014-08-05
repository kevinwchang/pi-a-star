require 'spec_helper'

describe "GriddedMaze" do
  describe "#add_intersection" do
    let(:maze) { GriddedMaze.new }
    before do
      maze.add_node [0,0]
    end

    it "represents nodes as Point objects" do
      maze.nodes.to_a[0].is_a? Point
    end

    it "does nothing when adding an empty intersection" do
      maze.add_intersection(Point(0,0),[])
      expect(maze.connections[Point(0,0)]).to eq [].to_set
    end

    it "adds a connection when given some exits" do
      maze.add_intersection(Point(0,0),[Vector(1,0),Vector(0,1)])
      expect(maze.connections[Point(0,0)]).to eq [Point(1,0),Point(0,1)].to_set

      maze.add_intersection(Point(1,0),[Vector(1,0),Vector(0,1)])
      expect(maze.connections[Point(1,0)]).to eq [Point(0,0),Point(2,0),Point(1,1)].to_set

      expect(maze.nodes).to eq [[0,0],[1,0],[0,1],[1,1],[2,0]].map { |x| Point.new x }.to_set
    end

    it "adds multiple nodes when given a long vector" do
      maze.add_intersection(Point(0,0),[Vector(2,0)])
      expect(maze.nodes).to eq [[0,0],[1,0],[2,0]].map { |x| Point.new x }.to_set
    end

    it "does not duplicate nodes" do
      maze.add_intersection(Point(0,0),[Vector(0,2)])
      maze.add_intersection(Point(0,0),[Vector(0,1)])
      expect(maze.nodes).to eq [[0,0],[0,1],[0,2]].map { |x| Point.new x }.to_set
    end
  end

  context "simple gridded maze" do

    let(:maze) {
      GriddedMaze.from_s <<END
#-#-#
|   |
#-#-#
|
#-#
END
    }
    specify do
      expect(maze.get_path Point(0,0), Point(1,2)).to eq [[0,0],[0,1],[0,2],[1,2]].map { |x| Point.new x }
    end

    specify do
      turning_path = maze.get_turning_path Vector(-1,0), Point(1,0), Point(2,1)
      expect(turning_path[:turns]).to eq [:right, :right]
      expect(turning_path[:initial_turn]).to eq :straight
    end

    specify do
      turning_path = maze.get_turning_path Vector(0,1), Point(0,0), Point(1,2)
      expect(turning_path[:turns]).to eq [:straight, :right]
      expect(turning_path[:initial_turn]).to eq :straight
    end

    specify do
      turning_path = maze.get_turning_path Vector(0,-1), Point(0,0), Point(1,2)
      expect(turning_path[:turns]).to eq [:straight, :right]
      expect(turning_path[:initial_turn]).to eq :back
    end
  end

  context "more complicated maze" do
    let(:maze) {
      GriddedMaze.from_s <<END
#-#-#-#-# #
|   | |   |
#-# # #-# #
| | |   | |
# #-# #-#-#
END
    }

    specify do
      turning_path = maze.get_turning_path Vector(0,1), Point(0,0), Point(5,2)
      expect(turning_path[:turns]).to eq [:straight, :right, :straight, :right, :left, :right, :left, :left]
    end
  end
end