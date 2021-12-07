{

  Project: EE-6 Motor
  Platform: Parallax Project USB Board
  Revision: 1.1
  Author: Zofia
  Date: 5th Nov 2021
  Log:
    Date: Desc
}

CON

  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

  ' Creating a Pause()
  _ConClickFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
  _MS_001 = _ConClickFreq / 1_000

  ' Pins for Motors
  motor1 = 10
  motor2 = 11
  motor3 = 12
  motor4 = 13

  ' Zero Speed
  motorZero = 1480

VAR ' Global Variable

  ' Declare CogID
  long motorCoreStack[64]
  long cog1ID

OBJ ' Objects

  Motors  : "Servo8Fast_vZ2.spin"
  Term    : "FullDuplexSerial.spin"  'UART communication

PUB Main | i   ' Core 0

  ' Declaration & Initialisation
  Init

  StopAllMotors
  Pause(1000)

  Assignment

  StopCore

PUB Init

  'cog1ID := cognew(motorCore, @motorCoreStack) + 1

  Motors.Init
  Motors.AddSlowPin(motor1)
  Motors.AddSlowPin(motor2)
  Motors.AddSlowPin(motor3)
  Motors.AddSlowPin(motor4)
  Motors.Start
  Pause(100)

PUB StopCore

  if CogID > -1
    cogstop(Cog1ID)

PUB Set(motor, speed)

  case motor
    motor1:
      speed += motorZero
      Motors.Set(motor1, speed)
    motor2:
      speed += motorZero
      Motors.Set(motor2, speed)
    motor3:
      speed += motorZero
      Motors.Set(motor3, speed)
    motor4:
      speed += motorZero
      Motors.Set(motor4, speed)

PUB StopAllMotors

  Set(motor1, 0)
  Set(motor2, 0)
  Set(motor3, 0)
  Set(motor4, 0)

PUB Forward(speed)

  Set(motor1, -speed)
  Set(motor2, -speed)
  Set(motor3, -speed)
  Set(motor4, -speed)

PUB Reverse(speed)

  Set(motor1, +speed)
  Set(motor2, +speed)
  Set(motor3, +speed)
  Set(motor4, +speed)

PUB TurnRight(speed)

  Set(motor1, +speed)
  Set(motor2, -speed)
  Set(motor3, +speed)
  Set(motor4, -speed)

PUB TurnLeft(speed)

  Set(motor1, -speed)
  Set(motor2, +speed)
  Set(motor3, -speed)
  Set(motor4, +speed)

PUB Assignment

  'Buffer time before start
  Pause(2000)

  ' Going Forward
  Forward(100)
  Pause(3000)

  StopAllMotors
  Pause(1000)

  TurnRight(100)
  Pause(2850)

  StopAllMotors
  Pause(1000)

  Forward(100)
  Pause(3000)

  StopAllMotors
  Pause(1000)

  TurnLeft(100)
  Pause(2900)

  StopAllMotors
  Pause(1000)

  Forward(100)
  Pause(3000)

  StopAllMotors
  Pause(1000)

  ' Reversing
  Reverse(100)
  Pause(3000)

  StopAllMotors
  Pause(1000)

  TurnRight(100)
  Pause(2950)

  StopAllMotors
  Pause(1000)

  Reverse(100)
  Pause(3000)

  StopAllMotors
  Pause(1000)

  TurnLeft(100)
  Pause(2900)

  StopAllMotors
  Pause(1000)

  Reverse(100)
  Pause(3000)

  StopAllMotors
  Pause(1000)


PRI Pause(ms) | t

  t := cnt - 1088
  repeat (ms #> 0)
    waitcnt(t += _MS_001)
  return