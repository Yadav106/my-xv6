
_myshell:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main() {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 10             	sub    $0x10,%esp
  int parent_pid = getpid();
   b:	e8 53 03 00 00       	call   363 <getpid>
  10:	89 c6                	mov    %eax,%esi
  int returned_pid = fork();
  12:	e8 c4 02 00 00       	call   2db <fork>

  if (returned_pid < 0) {
  17:	85 c0                	test   %eax,%eax
  19:	78 51                	js     6c <main+0x6c>
    // program failed, handle it later
    exit();
  } else if (returned_pid > 0) {
  1b:	74 54                	je     71 <main+0x71>
    // parent process
    printf(1, "[P] Parent Process %d\n", parent_pid);
  1d:	89 74 24 08          	mov    %esi,0x8(%esp)
  21:	89 c3                	mov    %eax,%ebx
  23:	c7 44 24 04 48 08 00 	movl   $0x848,0x4(%esp)
  2a:	00 
  2b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  32:	e8 69 04 00 00       	call   4a0 <printf>
    printf(1, "[P] Waiting for child process : %d\n", returned_pid);
  37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  3b:	c7 44 24 04 7c 08 00 	movl   $0x87c,0x4(%esp)
  42:	00 
  43:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4a:	e8 51 04 00 00       	call   4a0 <printf>
    int exited_process = wait();
  4f:	e8 97 02 00 00       	call   2eb <wait>
    printf(1, "[P] Child process with PID %d exited\n", exited_process);
  54:	c7 44 24 04 a0 08 00 	movl   $0x8a0,0x4(%esp)
  5b:	00 
  5c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  63:	89 44 24 08          	mov    %eax,0x8(%esp)
  67:	e8 34 04 00 00       	call   4a0 <printf>
    exit();
  6c:	e8 72 02 00 00       	call   2e3 <exit>
  } else {
    // child process
    int child_pid = getpid();
  71:	e8 ed 02 00 00       	call   363 <getpid>
    printf(1, "[C] Child Process %d\n", child_pid);
  76:	c7 44 24 04 5f 08 00 	movl   $0x85f,0x4(%esp)
  7d:	00 
  7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  85:	89 44 24 08          	mov    %eax,0x8(%esp)
  89:	e8 12 04 00 00       	call   4a0 <printf>
    exit();
  8e:	e8 50 02 00 00       	call   2e3 <exit>
  93:	66 90                	xchg   %ax,%ax
  95:	66 90                	xchg   %ax,%ax
  97:	66 90                	xchg   %ax,%ax
  99:	66 90                	xchg   %ax,%ax
  9b:	66 90                	xchg   %ax,%ax
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a1:	31 c0                	xor    %eax,%eax
{
  a3:	89 e5                	mov    %esp,%ebp
  a5:	53                   	push   %ebx
  a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  b7:	40                   	inc    %eax
  b8:	84 d2                	test   %dl,%dl
  ba:	75 f4                	jne    b0 <strcpy+0x10>
    ;
  return os;
}
  bc:	5b                   	pop    %ebx
  bd:	89 c8                	mov    %ecx,%eax
  bf:	5d                   	pop    %ebp
  c0:	c3                   	ret
  c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  c8:	00 
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	53                   	push   %ebx
  d4:	8b 55 08             	mov    0x8(%ebp),%edx
  d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  da:	0f b6 02             	movzbl (%edx),%eax
  dd:	84 c0                	test   %al,%al
  df:	75 15                	jne    f6 <strcmp+0x26>
  e1:	eb 30                	jmp    113 <strcmp+0x43>
  e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  ec:	8d 4b 01             	lea    0x1(%ebx),%ecx
  ef:	42                   	inc    %edx
  while(*p && *p == *q)
  f0:	84 c0                	test   %al,%al
  f2:	74 14                	je     108 <strcmp+0x38>
  f4:	89 cb                	mov    %ecx,%ebx
  f6:	0f b6 0b             	movzbl (%ebx),%ecx
  f9:	38 c1                	cmp    %al,%cl
  fb:	74 eb                	je     e8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  fd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  fe:	29 c8                	sub    %ecx,%eax
}
 100:	5d                   	pop    %ebp
 101:	c3                   	ret
 102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 108:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 10c:	31 c0                	xor    %eax,%eax
}
 10e:	5b                   	pop    %ebx
 10f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 110:	29 c8                	sub    %ecx,%eax
}
 112:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 113:	0f b6 0b             	movzbl (%ebx),%ecx
 116:	31 c0                	xor    %eax,%eax
 118:	eb e3                	jmp    fd <strcmp+0x2d>
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000120 <strlen>:

uint
strlen(const char *s)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 126:	80 3a 00             	cmpb   $0x0,(%edx)
 129:	74 15                	je     140 <strlen+0x20>
 12b:	31 c0                	xor    %eax,%eax
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	40                   	inc    %eax
 131:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 135:	89 c1                	mov    %eax,%ecx
 137:	75 f7                	jne    130 <strlen+0x10>
    ;
  return n;
}
 139:	5d                   	pop    %ebp
 13a:	89 c8                	mov    %ecx,%eax
 13c:	c3                   	ret
 13d:	8d 76 00             	lea    0x0(%esi),%esi
 140:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 141:	31 c9                	xor    %ecx,%ecx
}
 143:	89 c8                	mov    %ecx,%eax
 145:	c3                   	ret
 146:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14d:	00 
 14e:	66 90                	xchg   %ax,%ax

00000150 <memset>:

void*
memset(void *dst, int c, uint n)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 55 08             	mov    0x8(%ebp),%edx
 156:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 157:	8b 4d 10             	mov    0x10(%ebp),%ecx
 15a:	8b 45 0c             	mov    0xc(%ebp),%eax
 15d:	89 d7                	mov    %edx,%edi
 15f:	fc                   	cld
 160:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 162:	5f                   	pop    %edi
 163:	89 d0                	mov    %edx,%eax
 165:	5d                   	pop    %ebp
 166:	c3                   	ret
 167:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16e:	00 
 16f:	90                   	nop

00000170 <strchr>:

char*
strchr(const char *s, char c)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 17a:	0f b6 10             	movzbl (%eax),%edx
 17d:	84 d2                	test   %dl,%dl
 17f:	75 10                	jne    191 <strchr+0x21>
 181:	eb 1d                	jmp    1a0 <strchr+0x30>
 183:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 188:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 18c:	40                   	inc    %eax
 18d:	84 d2                	test   %dl,%dl
 18f:	74 0f                	je     1a0 <strchr+0x30>
    if(*s == c)
 191:	38 d1                	cmp    %dl,%cl
 193:	75 f3                	jne    188 <strchr+0x18>
      return (char*)s;
  return 0;
}
 195:	5d                   	pop    %ebp
 196:	c3                   	ret
 197:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19e:	00 
 19f:	90                   	nop
 1a0:	5d                   	pop    %ebp
  return 0;
 1a1:	31 c0                	xor    %eax,%eax
}
 1a3:	c3                   	ret
 1a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ab:	00 
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b5:	31 f6                	xor    %esi,%esi
{
 1b7:	53                   	push   %ebx
    cc = read(0, &c, 1);
 1b8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1bb:	83 ec 3c             	sub    $0x3c,%esp
 1be:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 1c1:	eb 32                	jmp    1f5 <gets+0x45>
 1c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 1c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1cc:	b8 01 00 00 00       	mov    $0x1,%eax
 1d1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1dc:	e8 1a 01 00 00       	call   2fb <read>
    if(cc < 1)
 1e1:	85 c0                	test   %eax,%eax
 1e3:	7e 19                	jle    1fe <gets+0x4e>
      break;
    buf[i++] = c;
 1e5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1e9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 1ed:	3c 0a                	cmp    $0xa,%al
 1ef:	74 10                	je     201 <gets+0x51>
 1f1:	3c 0d                	cmp    $0xd,%al
 1f3:	74 0c                	je     201 <gets+0x51>
  for(i=0; i+1 < max; ){
 1f5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1f8:	46                   	inc    %esi
 1f9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1fc:	7c ca                	jl     1c8 <gets+0x18>
 1fe:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 201:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 205:	83 c4 3c             	add    $0x3c,%esp
 208:	89 d8                	mov    %ebx,%eax
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5f                   	pop    %edi
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret
 20f:	90                   	nop

00000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 211:	31 c0                	xor    %eax,%eax
{
 213:	89 e5                	mov    %esp,%ebp
 215:	83 ec 18             	sub    $0x18,%esp
 218:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 21b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 21e:	89 44 24 04          	mov    %eax,0x4(%esp)
 222:	8b 45 08             	mov    0x8(%ebp),%eax
 225:	89 04 24             	mov    %eax,(%esp)
 228:	e8 f6 00 00 00       	call   323 <open>
  if(fd < 0)
 22d:	85 c0                	test   %eax,%eax
 22f:	78 2f                	js     260 <stat+0x50>
 231:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 233:	8b 45 0c             	mov    0xc(%ebp),%eax
 236:	89 1c 24             	mov    %ebx,(%esp)
 239:	89 44 24 04          	mov    %eax,0x4(%esp)
 23d:	e8 f9 00 00 00       	call   33b <fstat>
  close(fd);
 242:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 245:	89 c6                	mov    %eax,%esi
  close(fd);
 247:	e8 bf 00 00 00       	call   30b <close>
  return r;
}
 24c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 24f:	89 f0                	mov    %esi,%eax
 251:	8b 75 fc             	mov    -0x4(%ebp),%esi
 254:	89 ec                	mov    %ebp,%esp
 256:	5d                   	pop    %ebp
 257:	c3                   	ret
 258:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25f:	00 
    return -1;
 260:	be ff ff ff ff       	mov    $0xffffffff,%esi
 265:	eb e5                	jmp    24c <stat+0x3c>
 267:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26e:	00 
 26f:	90                   	nop

00000270 <atoi>:

int
atoi(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 277:	0f be 02             	movsbl (%edx),%eax
 27a:	88 c1                	mov    %al,%cl
 27c:	80 e9 30             	sub    $0x30,%cl
 27f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 282:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 287:	77 1c                	ja     2a5 <atoi+0x35>
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 290:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 293:	42                   	inc    %edx
 294:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 298:	0f be 02             	movsbl (%edx),%eax
 29b:	88 c3                	mov    %al,%bl
 29d:	80 eb 30             	sub    $0x30,%bl
 2a0:	80 fb 09             	cmp    $0x9,%bl
 2a3:	76 eb                	jbe    290 <atoi+0x20>
  return n;
}
 2a5:	5b                   	pop    %ebx
 2a6:	89 c8                	mov    %ecx,%eax
 2a8:	5d                   	pop    %ebp
 2a9:	c3                   	ret
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	8b 45 10             	mov    0x10(%ebp),%eax
 2b7:	56                   	push   %esi
 2b8:	8b 55 08             	mov    0x8(%ebp),%edx
 2bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2be:	85 c0                	test   %eax,%eax
 2c0:	7e 13                	jle    2d5 <memmove+0x25>
 2c2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2c4:	89 d7                	mov    %edx,%edi
 2c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2cd:	00 
 2ce:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2d1:	39 f8                	cmp    %edi,%eax
 2d3:	75 fb                	jne    2d0 <memmove+0x20>
  return vdst;
}
 2d5:	5e                   	pop    %esi
 2d6:	89 d0                	mov    %edx,%eax
 2d8:	5f                   	pop    %edi
 2d9:	5d                   	pop    %ebp
 2da:	c3                   	ret

000002db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2db:	b8 01 00 00 00       	mov    $0x1,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <exit>:
SYSCALL(exit)
 2e3:	b8 02 00 00 00       	mov    $0x2,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <wait>:
SYSCALL(wait)
 2eb:	b8 03 00 00 00       	mov    $0x3,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <pipe>:
SYSCALL(pipe)
 2f3:	b8 04 00 00 00       	mov    $0x4,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <read>:
SYSCALL(read)
 2fb:	b8 05 00 00 00       	mov    $0x5,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <write>:
SYSCALL(write)
 303:	b8 10 00 00 00       	mov    $0x10,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <close>:
SYSCALL(close)
 30b:	b8 15 00 00 00       	mov    $0x15,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <kill>:
SYSCALL(kill)
 313:	b8 06 00 00 00       	mov    $0x6,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <exec>:
SYSCALL(exec)
 31b:	b8 07 00 00 00       	mov    $0x7,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <open>:
SYSCALL(open)
 323:	b8 0f 00 00 00       	mov    $0xf,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <mknod>:
SYSCALL(mknod)
 32b:	b8 11 00 00 00       	mov    $0x11,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <unlink>:
SYSCALL(unlink)
 333:	b8 12 00 00 00       	mov    $0x12,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <fstat>:
SYSCALL(fstat)
 33b:	b8 08 00 00 00       	mov    $0x8,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <link>:
SYSCALL(link)
 343:	b8 13 00 00 00       	mov    $0x13,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <mkdir>:
SYSCALL(mkdir)
 34b:	b8 14 00 00 00       	mov    $0x14,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <chdir>:
SYSCALL(chdir)
 353:	b8 09 00 00 00       	mov    $0x9,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <dup>:
SYSCALL(dup)
 35b:	b8 0a 00 00 00       	mov    $0xa,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <getpid>:
SYSCALL(getpid)
 363:	b8 0b 00 00 00       	mov    $0xb,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <sbrk>:
SYSCALL(sbrk)
 36b:	b8 0c 00 00 00       	mov    $0xc,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <sleep>:
SYSCALL(sleep)
 373:	b8 0d 00 00 00       	mov    $0xd,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <uptime>:
SYSCALL(uptime)
 37b:	b8 0e 00 00 00       	mov    $0xe,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <worldpeace>:
SYSCALL(worldpeace)
 383:	b8 16 00 00 00       	mov    $0x16,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <numberofprocesses>:
SYSCALL(numberofprocesses)
 38b:	b8 17 00 00 00       	mov    $0x17,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <whatsthestatus>:
SYSCALL(whatsthestatus)
 393:	b8 18 00 00 00       	mov    $0x18,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <get_sibling>:
SYSCALL(get_sibling)
 39b:	b8 19 00 00 00       	mov    $0x19,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <spawn>:
SYSCALL(spawn)
 3a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <getvasize>:
SYSCALL(getvasize)
 3ab:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <va2pa>:
SYSCALL(va2pa)
 3b3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 3bb:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 3c3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 3cb:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <getpasize>:
SYSCALL(getpasize)
 3d3:	b8 20 00 00 00       	mov    $0x20,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret
 3db:	66 90                	xchg   %ax,%ax
 3dd:	66 90                	xchg   %ax,%ax
 3df:	90                   	nop

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	89 cb                	mov    %ecx,%ebx
 3e8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3eb:	89 d1                	mov    %edx,%ecx
{
 3ed:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 3f0:	89 d0                	mov    %edx,%eax
 3f2:	c1 e8 1f             	shr    $0x1f,%eax
 3f5:	84 c0                	test   %al,%al
 3f7:	0f 84 93 00 00 00    	je     490 <printint+0xb0>
 3fd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 401:	0f 84 89 00 00 00    	je     490 <printint+0xb0>
    x = -xx;
 407:	f7 d9                	neg    %ecx
    neg = 1;
 409:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 40e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 415:	8d 75 d7             	lea    -0x29(%ebp),%esi
 418:	89 45 b8             	mov    %eax,-0x48(%ebp)
 41b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 420:	89 c8                	mov    %ecx,%eax
 422:	31 d2                	xor    %edx,%edx
 424:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 427:	f7 f3                	div    %ebx
 429:	89 45 c0             	mov    %eax,-0x40(%ebp)
 42c:	0f b6 92 20 09 00 00 	movzbl 0x920(%edx),%edx
 433:	8d 47 01             	lea    0x1(%edi),%eax
 436:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 439:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 43d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 43f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 442:	39 da                	cmp    %ebx,%edx
 444:	73 da                	jae    420 <printint+0x40>
  if(neg)
 446:	8b 45 b8             	mov    -0x48(%ebp),%eax
 449:	85 c0                	test   %eax,%eax
 44b:	74 0a                	je     457 <printint+0x77>
    buf[i++] = '-';
 44d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 450:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 455:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 457:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 45a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 45e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 460:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 463:	89 74 24 04          	mov    %esi,0x4(%esp)
 467:	88 45 d7             	mov    %al,-0x29(%ebp)
 46a:	b8 01 00 00 00       	mov    $0x1,%eax
 46f:	89 44 24 08          	mov    %eax,0x8(%esp)
 473:	8b 45 bc             	mov    -0x44(%ebp),%eax
 476:	89 04 24             	mov    %eax,(%esp)
 479:	e8 85 fe ff ff       	call   303 <write>
  while(--i >= 0)
 47e:	89 f8                	mov    %edi,%eax
 480:	4f                   	dec    %edi
 481:	39 d8                	cmp    %ebx,%eax
 483:	75 db                	jne    460 <printint+0x80>
}
 485:	83 c4 4c             	add    $0x4c,%esp
 488:	5b                   	pop    %ebx
 489:	5e                   	pop    %esi
 48a:	5f                   	pop    %edi
 48b:	5d                   	pop    %ebp
 48c:	c3                   	ret
 48d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 490:	31 c0                	xor    %eax,%eax
 492:	e9 77 ff ff ff       	jmp    40e <printint+0x2e>
 497:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49e:	00 
 49f:	90                   	nop

000004a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4af:	0f b6 13             	movzbl (%ebx),%edx
 4b2:	43                   	inc    %ebx
 4b3:	84 d2                	test   %dl,%dl
 4b5:	74 35                	je     4ec <printf+0x4c>
 4b7:	8d 45 10             	lea    0x10(%ebp),%eax
 4ba:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 4c0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 4c3:	83 f8 25             	cmp    $0x25,%eax
 4c6:	74 30                	je     4f8 <printf+0x58>
  write(fd, &c, 1);
 4c8:	89 34 24             	mov    %esi,(%esp)
 4cb:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 4d0:	43                   	inc    %ebx
  write(fd, &c, 1);
 4d1:	89 44 24 08          	mov    %eax,0x8(%esp)
 4d5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4dc:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4df:	e8 1f fe ff ff       	call   303 <write>
  for(i = 0; fmt[i]; i++){
 4e4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4e8:	84 d2                	test   %dl,%dl
 4ea:	75 d4                	jne    4c0 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4ec:	83 c4 3c             	add    $0x3c,%esp
 4ef:	5b                   	pop    %ebx
 4f0:	5e                   	pop    %esi
 4f1:	5f                   	pop    %edi
 4f2:	5d                   	pop    %ebp
 4f3:	c3                   	ret
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 4f8:	0f b6 13             	movzbl (%ebx),%edx
 4fb:	84 d2                	test   %dl,%dl
 4fd:	74 ed                	je     4ec <printf+0x4c>
    c = fmt[i] & 0xff;
 4ff:	80 fa 25             	cmp    $0x25,%dl
 502:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 505:	0f 84 75 01 00 00    	je     680 <printf+0x1e0>
 50b:	83 e8 63             	sub    $0x63,%eax
 50e:	83 f8 15             	cmp    $0x15,%eax
 511:	77 0d                	ja     520 <printf+0x80>
 513:	ff 24 85 c8 08 00 00 	jmp    *0x8c8(,%eax,4)
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 520:	89 34 24             	mov    %esi,(%esp)
 523:	8d 7d e7             	lea    -0x19(%ebp),%edi
 526:	b8 01 00 00 00       	mov    $0x1,%eax
 52b:	89 44 24 08          	mov    %eax,0x8(%esp)
 52f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 533:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 536:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 53a:	e8 c4 fd ff ff       	call   303 <write>
        putc(fd, c);
 53f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 543:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 546:	ba 01 00 00 00       	mov    $0x1,%edx
 54b:	89 54 24 08          	mov    %edx,0x8(%esp)
 54f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 553:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 556:	89 34 24             	mov    %esi,(%esp)
 559:	e8 a5 fd ff ff       	call   303 <write>
  for(i = 0; fmt[i]; i++){
 55e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 562:	84 d2                	test   %dl,%dl
 564:	0f 85 56 ff ff ff    	jne    4c0 <printf+0x20>
}
 56a:	83 c4 3c             	add    $0x3c,%esp
 56d:	5b                   	pop    %ebx
 56e:	5e                   	pop    %esi
 56f:	5f                   	pop    %edi
 570:	5d                   	pop    %ebp
 571:	c3                   	ret
 572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 578:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 57b:	b9 10 00 00 00       	mov    $0x10,%ecx
 580:	8b 17                	mov    (%edi),%edx
 582:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 589:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 58c:	89 f0                	mov    %esi,%eax
 58e:	e8 4d fe ff ff       	call   3e0 <printint>
  for(i = 0; fmt[i]; i++){
 593:	83 c3 02             	add    $0x2,%ebx
        ap++;
 596:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 599:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 59d:	84 d2                	test   %dl,%dl
 59f:	0f 85 1b ff ff ff    	jne    4c0 <printf+0x20>
}
 5a5:	83 c4 3c             	add    $0x3c,%esp
 5a8:	5b                   	pop    %ebx
 5a9:	5e                   	pop    %esi
 5aa:	5f                   	pop    %edi
 5ab:	5d                   	pop    %ebp
 5ac:	c3                   	ret
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 5b0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 5b3:	8b 01                	mov    (%ecx),%eax
        ap++;
 5b5:	83 c1 04             	add    $0x4,%ecx
 5b8:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 5bb:	85 c0                	test   %eax,%eax
 5bd:	0f 84 d5 00 00 00    	je     698 <printf+0x1f8>
        while(*s != 0){
 5c3:	0f b6 10             	movzbl (%eax),%edx
 5c6:	84 d2                	test   %dl,%dl
 5c8:	74 39                	je     603 <printf+0x163>
 5ca:	89 c7                	mov    %eax,%edi
 5cc:	88 d0                	mov    %dl,%al
 5ce:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5d1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5d4:	89 fb                	mov    %edi,%ebx
 5d6:	89 cf                	mov    %ecx,%edi
 5d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5df:	00 
          putc(fd, *s);
 5e0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5e3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5e8:	43                   	inc    %ebx
  write(fd, &c, 1);
 5e9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5ed:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5f1:	89 34 24             	mov    %esi,(%esp)
 5f4:	e8 0a fd ff ff       	call   303 <write>
        while(*s != 0){
 5f9:	0f b6 03             	movzbl (%ebx),%eax
 5fc:	84 c0                	test   %al,%al
 5fe:	75 e0                	jne    5e0 <printf+0x140>
 600:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 603:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 607:	83 c3 02             	add    $0x2,%ebx
 60a:	84 d2                	test   %dl,%dl
 60c:	0f 85 ae fe ff ff    	jne    4c0 <printf+0x20>
 612:	e9 d5 fe ff ff       	jmp    4ec <printf+0x4c>
 617:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 61e:	00 
 61f:	90                   	nop
        printint(fd, *ap, 10, 1);
 620:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 623:	b9 0a 00 00 00       	mov    $0xa,%ecx
 628:	8b 17                	mov    (%edi),%edx
 62a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 631:	e9 53 ff ff ff       	jmp    589 <printf+0xe9>
 636:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 63d:	00 
 63e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 640:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 643:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 648:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 64b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 64d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 651:	8d 7d e7             	lea    -0x19(%ebp),%edi
 654:	89 7c 24 04          	mov    %edi,0x4(%esp)
 658:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 65b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 65e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 662:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 665:	e8 99 fc ff ff       	call   303 <write>
        ap++;
 66a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 66e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 672:	84 d2                	test   %dl,%dl
 674:	0f 85 46 fe ff ff    	jne    4c0 <printf+0x20>
 67a:	e9 6d fe ff ff       	jmp    4ec <printf+0x4c>
 67f:	90                   	nop
        putc(fd, c);
 680:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 683:	8d 7d e7             	lea    -0x19(%ebp),%edi
 686:	b9 01 00 00 00       	mov    $0x1,%ecx
 68b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 68f:	e9 bb fe ff ff       	jmp    54f <printf+0xaf>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 698:	bf 75 08 00 00       	mov    $0x875,%edi
 69d:	b0 28                	mov    $0x28,%al
 69f:	e9 2a ff ff ff       	jmp    5ce <printf+0x12e>
 6a4:	66 90                	xchg   %ax,%ax
 6a6:	66 90                	xchg   %ax,%ax
 6a8:	66 90                	xchg   %ax,%ax
 6aa:	66 90                	xchg   %ax,%ax
 6ac:	66 90                	xchg   %ax,%ax
 6ae:	66 90                	xchg   %ax,%ax

000006b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	a1 34 09 00 00       	mov    0x934,%eax
{
 6b6:	89 e5                	mov    %esp,%ebp
 6b8:	57                   	push   %edi
 6b9:	56                   	push   %esi
 6ba:	53                   	push   %ebx
 6bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6c8:	00 
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6d0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d4:	39 ca                	cmp    %ecx,%edx
 6d6:	73 30                	jae    708 <free+0x58>
 6d8:	39 c1                	cmp    %eax,%ecx
 6da:	72 04                	jb     6e0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6dc:	39 c2                	cmp    %eax,%edx
 6de:	72 f0                	jb     6d0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6e6:	39 f8                	cmp    %edi,%eax
 6e8:	74 36                	je     720 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6ea:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6ed:	8b 42 04             	mov    0x4(%edx),%eax
 6f0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6f3:	39 f1                	cmp    %esi,%ecx
 6f5:	74 42                	je     739 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6f7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6f9:	5b                   	pop    %ebx
  freep = p;
 6fa:	89 15 34 09 00 00    	mov    %edx,0x934
}
 700:	5e                   	pop    %esi
 701:	5f                   	pop    %edi
 702:	5d                   	pop    %ebp
 703:	c3                   	ret
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 708:	39 c2                	cmp    %eax,%edx
 70a:	72 c4                	jb     6d0 <free+0x20>
 70c:	39 c1                	cmp    %eax,%ecx
 70e:	73 c0                	jae    6d0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 710:	8b 73 fc             	mov    -0x4(%ebx),%esi
 713:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 716:	39 f8                	cmp    %edi,%eax
 718:	75 d0                	jne    6ea <free+0x3a>
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 720:	8b 78 04             	mov    0x4(%eax),%edi
 723:	01 fe                	add    %edi,%esi
 725:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 728:	8b 02                	mov    (%edx),%eax
 72a:	8b 00                	mov    (%eax),%eax
 72c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 72f:	8b 42 04             	mov    0x4(%edx),%eax
 732:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 735:	39 f1                	cmp    %esi,%ecx
 737:	75 be                	jne    6f7 <free+0x47>
  freep = p;
 739:	89 15 34 09 00 00    	mov    %edx,0x934
    p->s.size += bp->s.size;
 73f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 742:	01 c8                	add    %ecx,%eax
 744:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 747:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 74a:	89 0a                	mov    %ecx,(%edx)
}
 74c:	5b                   	pop    %ebx
 74d:	5e                   	pop    %esi
 74e:	5f                   	pop    %edi
 74f:	5d                   	pop    %ebp
 750:	c3                   	ret
 751:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 758:	00 
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 34 09 00 00    	mov    0x934,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	47                   	inc    %edi
  if((prevp = freep) == 0){
 779:	85 d2                	test   %edx,%edx
 77b:	0f 84 8f 00 00 00    	je     810 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 781:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 783:	8b 48 04             	mov    0x4(%eax),%ecx
 786:	39 f9                	cmp    %edi,%ecx
 788:	73 5e                	jae    7e8 <malloc+0x88>
  if(nu < 4096)
 78a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 78f:	39 df                	cmp    %ebx,%edi
 791:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 794:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 79b:	eb 0c                	jmp    7a9 <malloc+0x49>
 79d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a2:	8b 48 04             	mov    0x4(%eax),%ecx
 7a5:	39 f9                	cmp    %edi,%ecx
 7a7:	73 3f                	jae    7e8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a9:	39 05 34 09 00 00    	cmp    %eax,0x934
 7af:	89 c2                	mov    %eax,%edx
 7b1:	75 ed                	jne    7a0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7b3:	89 34 24             	mov    %esi,(%esp)
 7b6:	e8 b0 fb ff ff       	call   36b <sbrk>
  if(p == (char*)-1)
 7bb:	83 f8 ff             	cmp    $0xffffffff,%eax
 7be:	74 18                	je     7d8 <malloc+0x78>
  hp->s.size = nu;
 7c0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7c3:	83 c0 08             	add    $0x8,%eax
 7c6:	89 04 24             	mov    %eax,(%esp)
 7c9:	e8 e2 fe ff ff       	call   6b0 <free>
  return freep;
 7ce:	8b 15 34 09 00 00    	mov    0x934,%edx
      if((p = morecore(nunits)) == 0)
 7d4:	85 d2                	test   %edx,%edx
 7d6:	75 c8                	jne    7a0 <malloc+0x40>
        return 0;
  }
}
 7d8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7db:	31 c0                	xor    %eax,%eax
}
 7dd:	5b                   	pop    %ebx
 7de:	5e                   	pop    %esi
 7df:	5f                   	pop    %edi
 7e0:	5d                   	pop    %ebp
 7e1:	c3                   	ret
 7e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7e8:	39 cf                	cmp    %ecx,%edi
 7ea:	74 54                	je     840 <malloc+0xe0>
        p->s.size -= nunits;
 7ec:	29 f9                	sub    %edi,%ecx
 7ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7f4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7f7:	89 15 34 09 00 00    	mov    %edx,0x934
}
 7fd:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 800:	83 c0 08             	add    $0x8,%eax
}
 803:	5b                   	pop    %ebx
 804:	5e                   	pop    %esi
 805:	5f                   	pop    %edi
 806:	5d                   	pop    %ebp
 807:	c3                   	ret
 808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 80f:	00 
    base.s.ptr = freep = prevp = &base;
 810:	b8 38 09 00 00       	mov    $0x938,%eax
 815:	ba 38 09 00 00       	mov    $0x938,%edx
 81a:	a3 34 09 00 00       	mov    %eax,0x934
    base.s.size = 0;
 81f:	31 c9                	xor    %ecx,%ecx
 821:	b8 38 09 00 00       	mov    $0x938,%eax
    base.s.ptr = freep = prevp = &base;
 826:	89 15 38 09 00 00    	mov    %edx,0x938
    base.s.size = 0;
 82c:	89 0d 3c 09 00 00    	mov    %ecx,0x93c
    if(p->s.size >= nunits){
 832:	e9 53 ff ff ff       	jmp    78a <malloc+0x2a>
 837:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 83e:	00 
 83f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 840:	8b 08                	mov    (%eax),%ecx
 842:	89 0a                	mov    %ecx,(%edx)
 844:	eb b1                	jmp    7f7 <malloc+0x97>
