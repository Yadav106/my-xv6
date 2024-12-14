#include "types.h"
#include "user.h"

int main(int argc, char* argv[]) {
  int parent_pid = getpid();
  int returned_pid = fork();

  if (returned_pid < 0) {
    // program failed, handle it later
  } else if (returned_pid > 0) {
    // parent process
    int child_pid = wait();
  } else {
    // child process
    char* command = argv[1];
    exec(command, argv+1);
  }
  exit();
}
