#include <iostream>
#include <pigpio.h>
#include <unistd.h>

// GPIO pin for servo control (https://projects.raspberrypi.org/en/projects/grandpa-scarer/3)
#define SERVO_PIN 17

void move_head_to_user() {
    if (gpioInitialise() < 0) {
        std::cerr << "Failed to initialize pigpio library." << std::endl;
        return;
    }

    // Move head to 45 degrees towards the user
    gpioServo(SERVO_PIN, 1500);  // 1500µs typically corresponds to 45 degrees (will adjust once I receive new hardware)
    usleep(2000000);             // Wait 2 seconds to let the fish "listen"

    // Move head back to neutral position (center)
    gpioServo(SERVO_PIN, 1000);  // 1000µs typically corresponds to neutral position (0 degrees)
    usleep(1000000);             // Wait 1 second for the servo to return

    gpioTerminate();
}

int main() {
    std::cout << "Fish turning head to the user..." << std::endl;
    move_head_to_user();  // Function to turn head towards user
    return 0;
}
