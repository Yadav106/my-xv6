#include "types.h"
#include "user.h"

int main() {
  int parent_pid = getpid();
  int returned_pid = fork();

  if (returned_pid < 0) {
    // program failed, handle it later
    exit();
  } else if (returned_pid > 0) {
    // parent process
    printf(1, "[P] Parent Process %d\n", parent_pid);
    printf(1, "[P] Waiting for child process : %d\n", returned_pid);
    int exited_process = wait();
    printf(1, "[P] Child process with PID %d exited\n", exited_process);
    exit();
  } else {
    // child process
    int child_pid = getpid();
    printf(1, "[C] Child Process %d\n", child_pid);
    exit();
  }
  exit();
}
