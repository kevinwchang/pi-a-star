class Motors
{
  static unsigned char left_dir_pin;
  static unsigned char right_dir_pin;
  static void setServo(int left, int right);
  
  public:
  static void set(int left, int right);
  static void setup(unsigned char  motor_a_dir_pin, unsigned char motor_b_dir_pin, unsigned char servo_pin);
};
