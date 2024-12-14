
_cmd:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char* argv[]) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  int parent_pid = getpid();
   9:	e8 05 03 00 00       	call   313 <getpid>
  int returned_pid = fork();
   e:	e8 78 02 00 00       	call   28b <fork>

  if (returned_pid < 0) {
  13:	85 c0                	test   %eax,%eax
  15:	78 0e                	js     25 <main+0x25>
    // program failed, handle it later
  } else if (returned_pid > 0) {
  17:	74 11                	je     2a <main+0x2a>
    // parent process
    int child_pid = wait();
  19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  20:	e8 76 02 00 00       	call   29b <wait>
  } else {
    // child process
    char* command = argv[1];
    exec(command, argv+1);
  }
  exit();
  25:	e8 69 02 00 00       	call   293 <exit>
    exec(command, argv+1);
  2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  2d:	83 c0 04             	add    $0x4,%eax
  30:	89 44 24 04          	mov    %eax,0x4(%esp)
  34:	8b 45 0c             	mov    0xc(%ebp),%eax
  37:	8b 40 04             	mov    0x4(%eax),%eax
  3a:	89 04 24             	mov    %eax,(%esp)
  3d:	e8 89 02 00 00       	call   2cb <exec>
  42:	eb e1                	jmp    25 <main+0x25>
  44:	66 90                	xchg   %ax,%ax
  46:	66 90                	xchg   %ax,%ax
  48:	66 90                	xchg   %ax,%ax
  4a:	66 90                	xchg   %ax,%ax
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  50:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  51:	31 c0                	xor    %eax,%eax
{
  53:	89 e5                	mov    %esp,%ebp
  55:	53                   	push   %ebx
  56:	8b 4d 08             	mov    0x8(%ebp),%ecx
  59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  60:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  64:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  67:	40                   	inc    %eax
  68:	84 d2                	test   %dl,%dl
  6a:	75 f4                	jne    60 <strcpy+0x10>
    ;
  return os;
}
  6c:	5b                   	pop    %ebx
  6d:	89 c8                	mov    %ecx,%eax
  6f:	5d                   	pop    %ebp
  70:	c3                   	ret
  71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  78:	00 
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	53                   	push   %ebx
  84:	8b 55 08             	mov    0x8(%ebp),%edx
  87:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  8a:	0f b6 02             	movzbl (%edx),%eax
  8d:	84 c0                	test   %al,%al
  8f:	75 15                	jne    a6 <strcmp+0x26>
  91:	eb 30                	jmp    c3 <strcmp+0x43>
  93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  98:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  9c:	8d 4b 01             	lea    0x1(%ebx),%ecx
  9f:	42                   	inc    %edx
  while(*p && *p == *q)
  a0:	84 c0                	test   %al,%al
  a2:	74 14                	je     b8 <strcmp+0x38>
  a4:	89 cb                	mov    %ecx,%ebx
  a6:	0f b6 0b             	movzbl (%ebx),%ecx
  a9:	38 c1                	cmp    %al,%cl
  ab:	74 eb                	je     98 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  ad:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  ae:	29 c8                	sub    %ecx,%eax
}
  b0:	5d                   	pop    %ebp
  b1:	c3                   	ret
  b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  b8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  bc:	31 c0                	xor    %eax,%eax
}
  be:	5b                   	pop    %ebx
  bf:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  c0:	29 c8                	sub    %ecx,%eax
}
  c2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  c3:	0f b6 0b             	movzbl (%ebx),%ecx
  c6:	31 c0                	xor    %eax,%eax
  c8:	eb e3                	jmp    ad <strcmp+0x2d>
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000d0 <strlen>:

uint
strlen(const char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  d6:	80 3a 00             	cmpb   $0x0,(%edx)
  d9:	74 15                	je     f0 <strlen+0x20>
  db:	31 c0                	xor    %eax,%eax
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	40                   	inc    %eax
  e1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  e5:	89 c1                	mov    %eax,%ecx
  e7:	75 f7                	jne    e0 <strlen+0x10>
    ;
  return n;
}
  e9:	5d                   	pop    %ebp
  ea:	89 c8                	mov    %ecx,%eax
  ec:	c3                   	ret
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
  f1:	31 c9                	xor    %ecx,%ecx
}
  f3:	89 c8                	mov    %ecx,%eax
  f5:	c3                   	ret
  f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fd:	00 
  fe:	66 90                	xchg   %ax,%ax

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
 106:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 107:	8b 4d 10             	mov    0x10(%ebp),%ecx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	89 d7                	mov    %edx,%edi
 10f:	fc                   	cld
 110:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 112:	5f                   	pop    %edi
 113:	89 d0                	mov    %edx,%eax
 115:	5d                   	pop    %ebp
 116:	c3                   	ret
 117:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11e:	00 
 11f:	90                   	nop

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 12a:	0f b6 10             	movzbl (%eax),%edx
 12d:	84 d2                	test   %dl,%dl
 12f:	75 10                	jne    141 <strchr+0x21>
 131:	eb 1d                	jmp    150 <strchr+0x30>
 133:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 138:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 13c:	40                   	inc    %eax
 13d:	84 d2                	test   %dl,%dl
 13f:	74 0f                	je     150 <strchr+0x30>
    if(*s == c)
 141:	38 d1                	cmp    %dl,%cl
 143:	75 f3                	jne    138 <strchr+0x18>
      return (char*)s;
  return 0;
}
 145:	5d                   	pop    %ebp
 146:	c3                   	ret
 147:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14e:	00 
 14f:	90                   	nop
 150:	5d                   	pop    %ebp
  return 0;
 151:	31 c0                	xor    %eax,%eax
}
 153:	c3                   	ret
 154:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15b:	00 
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	57                   	push   %edi
 164:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 165:	31 f6                	xor    %esi,%esi
{
 167:	53                   	push   %ebx
    cc = read(0, &c, 1);
 168:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 16b:	83 ec 3c             	sub    $0x3c,%esp
 16e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 171:	eb 32                	jmp    1a5 <gets+0x45>
 173:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 178:	89 7c 24 04          	mov    %edi,0x4(%esp)
 17c:	b8 01 00 00 00       	mov    $0x1,%eax
 181:	89 44 24 08          	mov    %eax,0x8(%esp)
 185:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 18c:	e8 1a 01 00 00       	call   2ab <read>
    if(cc < 1)
 191:	85 c0                	test   %eax,%eax
 193:	7e 19                	jle    1ae <gets+0x4e>
      break;
    buf[i++] = c;
 195:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 199:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 19d:	3c 0a                	cmp    $0xa,%al
 19f:	74 10                	je     1b1 <gets+0x51>
 1a1:	3c 0d                	cmp    $0xd,%al
 1a3:	74 0c                	je     1b1 <gets+0x51>
  for(i=0; i+1 < max; ){
 1a5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1a8:	46                   	inc    %esi
 1a9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1ac:	7c ca                	jl     178 <gets+0x18>
 1ae:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 1b1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 1b5:	83 c4 3c             	add    $0x3c,%esp
 1b8:	89 d8                	mov    %ebx,%eax
 1ba:	5b                   	pop    %ebx
 1bb:	5e                   	pop    %esi
 1bc:	5f                   	pop    %edi
 1bd:	5d                   	pop    %ebp
 1be:	c3                   	ret
 1bf:	90                   	nop

000001c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c1:	31 c0                	xor    %eax,%eax
{
 1c3:	89 e5                	mov    %esp,%ebp
 1c5:	83 ec 18             	sub    $0x18,%esp
 1c8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1cb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1ce:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d2:	8b 45 08             	mov    0x8(%ebp),%eax
 1d5:	89 04 24             	mov    %eax,(%esp)
 1d8:	e8 f6 00 00 00       	call   2d3 <open>
  if(fd < 0)
 1dd:	85 c0                	test   %eax,%eax
 1df:	78 2f                	js     210 <stat+0x50>
 1e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e6:	89 1c 24             	mov    %ebx,(%esp)
 1e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ed:	e8 f9 00 00 00       	call   2eb <fstat>
  close(fd);
 1f2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1f5:	89 c6                	mov    %eax,%esi
  close(fd);
 1f7:	e8 bf 00 00 00       	call   2bb <close>
  return r;
}
 1fc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1ff:	89 f0                	mov    %esi,%eax
 201:	8b 75 fc             	mov    -0x4(%ebp),%esi
 204:	89 ec                	mov    %ebp,%esp
 206:	5d                   	pop    %ebp
 207:	c3                   	ret
 208:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20f:	00 
    return -1;
 210:	be ff ff ff ff       	mov    $0xffffffff,%esi
 215:	eb e5                	jmp    1fc <stat+0x3c>
 217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21e:	00 
 21f:	90                   	nop

00000220 <atoi>:

int
atoi(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 227:	0f be 02             	movsbl (%edx),%eax
 22a:	88 c1                	mov    %al,%cl
 22c:	80 e9 30             	sub    $0x30,%cl
 22f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 232:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 237:	77 1c                	ja     255 <atoi+0x35>
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 240:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 243:	42                   	inc    %edx
 244:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 248:	0f be 02             	movsbl (%edx),%eax
 24b:	88 c3                	mov    %al,%bl
 24d:	80 eb 30             	sub    $0x30,%bl
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
  return n;
}
 255:	5b                   	pop    %ebx
 256:	89 c8                	mov    %ecx,%eax
 258:	5d                   	pop    %ebp
 259:	c3                   	ret
 25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	8b 45 10             	mov    0x10(%ebp),%eax
 267:	56                   	push   %esi
 268:	8b 55 08             	mov    0x8(%ebp),%edx
 26b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26e:	85 c0                	test   %eax,%eax
 270:	7e 13                	jle    285 <memmove+0x25>
 272:	01 d0                	add    %edx,%eax
  dst = vdst;
 274:	89 d7                	mov    %edx,%edi
 276:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27d:	00 
 27e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 280:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 281:	39 f8                	cmp    %edi,%eax
 283:	75 fb                	jne    280 <memmove+0x20>
  return vdst;
}
 285:	5e                   	pop    %esi
 286:	89 d0                	mov    %edx,%eax
 288:	5f                   	pop    %edi
 289:	5d                   	pop    %ebp
 28a:	c3                   	ret

0000028b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28b:	b8 01 00 00 00       	mov    $0x1,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret

00000293 <exit>:
SYSCALL(exit)
 293:	b8 02 00 00 00       	mov    $0x2,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret

0000029b <wait>:
SYSCALL(wait)
 29b:	b8 03 00 00 00       	mov    $0x3,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <pipe>:
SYSCALL(pipe)
 2a3:	b8 04 00 00 00       	mov    $0x4,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <read>:
SYSCALL(read)
 2ab:	b8 05 00 00 00       	mov    $0x5,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <write>:
SYSCALL(write)
 2b3:	b8 10 00 00 00       	mov    $0x10,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <close>:
SYSCALL(close)
 2bb:	b8 15 00 00 00       	mov    $0x15,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <kill>:
SYSCALL(kill)
 2c3:	b8 06 00 00 00       	mov    $0x6,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <exec>:
SYSCALL(exec)
 2cb:	b8 07 00 00 00       	mov    $0x7,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <open>:
SYSCALL(open)
 2d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <mknod>:
SYSCALL(mknod)
 2db:	b8 11 00 00 00       	mov    $0x11,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <unlink>:
SYSCALL(unlink)
 2e3:	b8 12 00 00 00       	mov    $0x12,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <fstat>:
SYSCALL(fstat)
 2eb:	b8 08 00 00 00       	mov    $0x8,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <link>:
SYSCALL(link)
 2f3:	b8 13 00 00 00       	mov    $0x13,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <mkdir>:
SYSCALL(mkdir)
 2fb:	b8 14 00 00 00       	mov    $0x14,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <chdir>:
SYSCALL(chdir)
 303:	b8 09 00 00 00       	mov    $0x9,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <dup>:
SYSCALL(dup)
 30b:	b8 0a 00 00 00       	mov    $0xa,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <getpid>:
SYSCALL(getpid)
 313:	b8 0b 00 00 00       	mov    $0xb,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <sbrk>:
SYSCALL(sbrk)
 31b:	b8 0c 00 00 00       	mov    $0xc,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <sleep>:
SYSCALL(sleep)
 323:	b8 0d 00 00 00       	mov    $0xd,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <uptime>:
SYSCALL(uptime)
 32b:	b8 0e 00 00 00       	mov    $0xe,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <worldpeace>:
SYSCALL(worldpeace)
 333:	b8 16 00 00 00       	mov    $0x16,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <numberofprocesses>:
SYSCALL(numberofprocesses)
 33b:	b8 17 00 00 00       	mov    $0x17,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <whatsthestatus>:
SYSCALL(whatsthestatus)
 343:	b8 18 00 00 00       	mov    $0x18,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <get_sibling>:
SYSCALL(get_sibling)
 34b:	b8 19 00 00 00       	mov    $0x19,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <spawn>:
SYSCALL(spawn)
 353:	b8 1a 00 00 00       	mov    $0x1a,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <getvasize>:
SYSCALL(getvasize)
 35b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <va2pa>:
SYSCALL(va2pa)
 363:	b8 1c 00 00 00       	mov    $0x1c,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 36b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 373:	b8 1e 00 00 00       	mov    $0x1e,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 37b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <getpasize>:
SYSCALL(getpasize)
 383:	b8 20 00 00 00       	mov    $0x20,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret
 38b:	66 90                	xchg   %ax,%ax
 38d:	66 90                	xchg   %ax,%ax
 38f:	90                   	nop

00000390 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	89 cb                	mov    %ecx,%ebx
 398:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 39b:	89 d1                	mov    %edx,%ecx
{
 39d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 3a0:	89 d0                	mov    %edx,%eax
 3a2:	c1 e8 1f             	shr    $0x1f,%eax
 3a5:	84 c0                	test   %al,%al
 3a7:	0f 84 93 00 00 00    	je     440 <printint+0xb0>
 3ad:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3b1:	0f 84 89 00 00 00    	je     440 <printint+0xb0>
    x = -xx;
 3b7:	f7 d9                	neg    %ecx
    neg = 1;
 3b9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 3be:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3c5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3c8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 3cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3d0:	89 c8                	mov    %ecx,%eax
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3d7:	f7 f3                	div    %ebx
 3d9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3dc:	0f b6 92 58 08 00 00 	movzbl 0x858(%edx),%edx
 3e3:	8d 47 01             	lea    0x1(%edi),%eax
 3e6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3e9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 3ed:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 3ef:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 3f2:	39 da                	cmp    %ebx,%edx
 3f4:	73 da                	jae    3d0 <printint+0x40>
  if(neg)
 3f6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 3f9:	85 c0                	test   %eax,%eax
 3fb:	74 0a                	je     407 <printint+0x77>
    buf[i++] = '-';
 3fd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 400:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 405:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 407:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 40a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 40e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 410:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 413:	89 74 24 04          	mov    %esi,0x4(%esp)
 417:	88 45 d7             	mov    %al,-0x29(%ebp)
 41a:	b8 01 00 00 00       	mov    $0x1,%eax
 41f:	89 44 24 08          	mov    %eax,0x8(%esp)
 423:	8b 45 bc             	mov    -0x44(%ebp),%eax
 426:	89 04 24             	mov    %eax,(%esp)
 429:	e8 85 fe ff ff       	call   2b3 <write>
  while(--i >= 0)
 42e:	89 f8                	mov    %edi,%eax
 430:	4f                   	dec    %edi
 431:	39 d8                	cmp    %ebx,%eax
 433:	75 db                	jne    410 <printint+0x80>
}
 435:	83 c4 4c             	add    $0x4c,%esp
 438:	5b                   	pop    %ebx
 439:	5e                   	pop    %esi
 43a:	5f                   	pop    %edi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret
 43d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 440:	31 c0                	xor    %eax,%eax
 442:	e9 77 ff ff ff       	jmp    3be <printint+0x2e>
 447:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 44e:	00 
 44f:	90                   	nop

00000450 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 459:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 45c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 45f:	0f b6 13             	movzbl (%ebx),%edx
 462:	43                   	inc    %ebx
 463:	84 d2                	test   %dl,%dl
 465:	74 35                	je     49c <printf+0x4c>
 467:	8d 45 10             	lea    0x10(%ebp),%eax
 46a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 46d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 470:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 473:	83 f8 25             	cmp    $0x25,%eax
 476:	74 30                	je     4a8 <printf+0x58>
  write(fd, &c, 1);
 478:	89 34 24             	mov    %esi,(%esp)
 47b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 480:	43                   	inc    %ebx
  write(fd, &c, 1);
 481:	89 44 24 08          	mov    %eax,0x8(%esp)
 485:	8d 45 e7             	lea    -0x19(%ebp),%eax
 488:	89 44 24 04          	mov    %eax,0x4(%esp)
 48c:	88 55 e7             	mov    %dl,-0x19(%ebp)
 48f:	e8 1f fe ff ff       	call   2b3 <write>
  for(i = 0; fmt[i]; i++){
 494:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 498:	84 d2                	test   %dl,%dl
 49a:	75 d4                	jne    470 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 49c:	83 c4 3c             	add    $0x3c,%esp
 49f:	5b                   	pop    %ebx
 4a0:	5e                   	pop    %esi
 4a1:	5f                   	pop    %edi
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 4a8:	0f b6 13             	movzbl (%ebx),%edx
 4ab:	84 d2                	test   %dl,%dl
 4ad:	74 ed                	je     49c <printf+0x4c>
    c = fmt[i] & 0xff;
 4af:	80 fa 25             	cmp    $0x25,%dl
 4b2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 4b5:	0f 84 75 01 00 00    	je     630 <printf+0x1e0>
 4bb:	83 e8 63             	sub    $0x63,%eax
 4be:	83 f8 15             	cmp    $0x15,%eax
 4c1:	77 0d                	ja     4d0 <printf+0x80>
 4c3:	ff 24 85 00 08 00 00 	jmp    *0x800(,%eax,4)
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4d0:	89 34 24             	mov    %esi,(%esp)
 4d3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4d6:	b8 01 00 00 00       	mov    $0x1,%eax
 4db:	89 44 24 08          	mov    %eax,0x8(%esp)
 4df:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4e3:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 4e6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4ea:	e8 c4 fd ff ff       	call   2b3 <write>
        putc(fd, c);
 4ef:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 4f3:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4f6:	ba 01 00 00 00       	mov    $0x1,%edx
 4fb:	89 54 24 08          	mov    %edx,0x8(%esp)
 4ff:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 503:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 506:	89 34 24             	mov    %esi,(%esp)
 509:	e8 a5 fd ff ff       	call   2b3 <write>
  for(i = 0; fmt[i]; i++){
 50e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 512:	84 d2                	test   %dl,%dl
 514:	0f 85 56 ff ff ff    	jne    470 <printf+0x20>
}
 51a:	83 c4 3c             	add    $0x3c,%esp
 51d:	5b                   	pop    %ebx
 51e:	5e                   	pop    %esi
 51f:	5f                   	pop    %edi
 520:	5d                   	pop    %ebp
 521:	c3                   	ret
 522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 528:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 52b:	b9 10 00 00 00       	mov    $0x10,%ecx
 530:	8b 17                	mov    (%edi),%edx
 532:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 539:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 53c:	89 f0                	mov    %esi,%eax
 53e:	e8 4d fe ff ff       	call   390 <printint>
  for(i = 0; fmt[i]; i++){
 543:	83 c3 02             	add    $0x2,%ebx
        ap++;
 546:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 549:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 54d:	84 d2                	test   %dl,%dl
 54f:	0f 85 1b ff ff ff    	jne    470 <printf+0x20>
}
 555:	83 c4 3c             	add    $0x3c,%esp
 558:	5b                   	pop    %ebx
 559:	5e                   	pop    %esi
 55a:	5f                   	pop    %edi
 55b:	5d                   	pop    %ebp
 55c:	c3                   	ret
 55d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 560:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 563:	8b 01                	mov    (%ecx),%eax
        ap++;
 565:	83 c1 04             	add    $0x4,%ecx
 568:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 56b:	85 c0                	test   %eax,%eax
 56d:	0f 84 d5 00 00 00    	je     648 <printf+0x1f8>
        while(*s != 0){
 573:	0f b6 10             	movzbl (%eax),%edx
 576:	84 d2                	test   %dl,%dl
 578:	74 39                	je     5b3 <printf+0x163>
 57a:	89 c7                	mov    %eax,%edi
 57c:	88 d0                	mov    %dl,%al
 57e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 581:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 584:	89 fb                	mov    %edi,%ebx
 586:	89 cf                	mov    %ecx,%edi
 588:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 58f:	00 
          putc(fd, *s);
 590:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 593:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 598:	43                   	inc    %ebx
  write(fd, &c, 1);
 599:	89 44 24 08          	mov    %eax,0x8(%esp)
 59d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5a1:	89 34 24             	mov    %esi,(%esp)
 5a4:	e8 0a fd ff ff       	call   2b3 <write>
        while(*s != 0){
 5a9:	0f b6 03             	movzbl (%ebx),%eax
 5ac:	84 c0                	test   %al,%al
 5ae:	75 e0                	jne    590 <printf+0x140>
 5b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5b3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5b7:	83 c3 02             	add    $0x2,%ebx
 5ba:	84 d2                	test   %dl,%dl
 5bc:	0f 85 ae fe ff ff    	jne    470 <printf+0x20>
 5c2:	e9 d5 fe ff ff       	jmp    49c <printf+0x4c>
 5c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ce:	00 
 5cf:	90                   	nop
        printint(fd, *ap, 10, 1);
 5d0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d8:	8b 17                	mov    (%edi),%edx
 5da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5e1:	e9 53 ff ff ff       	jmp    539 <printf+0xe9>
 5e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ed:	00 
 5ee:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 5f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 5f3:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 5f8:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 5fb:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 5fd:	89 7c 24 08          	mov    %edi,0x8(%esp)
 601:	8d 7d e7             	lea    -0x19(%ebp),%edi
 604:	89 7c 24 04          	mov    %edi,0x4(%esp)
 608:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 60b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 60e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 612:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 615:	e8 99 fc ff ff       	call   2b3 <write>
        ap++;
 61a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 61e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 622:	84 d2                	test   %dl,%dl
 624:	0f 85 46 fe ff ff    	jne    470 <printf+0x20>
 62a:	e9 6d fe ff ff       	jmp    49c <printf+0x4c>
 62f:	90                   	nop
        putc(fd, c);
 630:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 633:	8d 7d e7             	lea    -0x19(%ebp),%edi
 636:	b9 01 00 00 00       	mov    $0x1,%ecx
 63b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 63f:	e9 bb fe ff ff       	jmp    4ff <printf+0xaf>
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 648:	bf f8 07 00 00       	mov    $0x7f8,%edi
 64d:	b0 28                	mov    $0x28,%al
 64f:	e9 2a ff ff ff       	jmp    57e <printf+0x12e>
 654:	66 90                	xchg   %ax,%ax
 656:	66 90                	xchg   %ax,%ax
 658:	66 90                	xchg   %ax,%ax
 65a:	66 90                	xchg   %ax,%ax
 65c:	66 90                	xchg   %ax,%ax
 65e:	66 90                	xchg   %ax,%ax

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	a1 6c 08 00 00       	mov    0x86c,%eax
{
 666:	89 e5                	mov    %esp,%ebp
 668:	57                   	push   %edi
 669:	56                   	push   %esi
 66a:	53                   	push   %ebx
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 66e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 671:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 678:	00 
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 680:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 682:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 684:	39 ca                	cmp    %ecx,%edx
 686:	73 30                	jae    6b8 <free+0x58>
 688:	39 c1                	cmp    %eax,%ecx
 68a:	72 04                	jb     690 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68c:	39 c2                	cmp    %eax,%edx
 68e:	72 f0                	jb     680 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 690:	8b 73 fc             	mov    -0x4(%ebx),%esi
 693:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 696:	39 f8                	cmp    %edi,%eax
 698:	74 36                	je     6d0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 69a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 69d:	8b 42 04             	mov    0x4(%edx),%eax
 6a0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6a3:	39 f1                	cmp    %esi,%ecx
 6a5:	74 42                	je     6e9 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6a7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6a9:	5b                   	pop    %ebx
  freep = p;
 6aa:	89 15 6c 08 00 00    	mov    %edx,0x86c
}
 6b0:	5e                   	pop    %esi
 6b1:	5f                   	pop    %edi
 6b2:	5d                   	pop    %ebp
 6b3:	c3                   	ret
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b8:	39 c2                	cmp    %eax,%edx
 6ba:	72 c4                	jb     680 <free+0x20>
 6bc:	39 c1                	cmp    %eax,%ecx
 6be:	73 c0                	jae    680 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 6c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6c6:	39 f8                	cmp    %edi,%eax
 6c8:	75 d0                	jne    69a <free+0x3a>
 6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 6d0:	8b 78 04             	mov    0x4(%eax),%edi
 6d3:	01 fe                	add    %edi,%esi
 6d5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d8:	8b 02                	mov    (%edx),%eax
 6da:	8b 00                	mov    (%eax),%eax
 6dc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6df:	8b 42 04             	mov    0x4(%edx),%eax
 6e2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6e5:	39 f1                	cmp    %esi,%ecx
 6e7:	75 be                	jne    6a7 <free+0x47>
  freep = p;
 6e9:	89 15 6c 08 00 00    	mov    %edx,0x86c
    p->s.size += bp->s.size;
 6ef:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 6f2:	01 c8                	add    %ecx,%eax
 6f4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6f7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6fa:	89 0a                	mov    %ecx,(%edx)
}
 6fc:	5b                   	pop    %ebx
 6fd:	5e                   	pop    %esi
 6fe:	5f                   	pop    %edi
 6ff:	5d                   	pop    %ebp
 700:	c3                   	ret
 701:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 708:	00 
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 719:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 71c:	8b 15 6c 08 00 00    	mov    0x86c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 722:	8d 78 07             	lea    0x7(%eax),%edi
 725:	c1 ef 03             	shr    $0x3,%edi
 728:	47                   	inc    %edi
  if((prevp = freep) == 0){
 729:	85 d2                	test   %edx,%edx
 72b:	0f 84 8f 00 00 00    	je     7c0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 731:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 733:	8b 48 04             	mov    0x4(%eax),%ecx
 736:	39 f9                	cmp    %edi,%ecx
 738:	73 5e                	jae    798 <malloc+0x88>
  if(nu < 4096)
 73a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 73f:	39 df                	cmp    %ebx,%edi
 741:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 744:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 74b:	eb 0c                	jmp    759 <malloc+0x49>
 74d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 750:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 752:	8b 48 04             	mov    0x4(%eax),%ecx
 755:	39 f9                	cmp    %edi,%ecx
 757:	73 3f                	jae    798 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 759:	39 05 6c 08 00 00    	cmp    %eax,0x86c
 75f:	89 c2                	mov    %eax,%edx
 761:	75 ed                	jne    750 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 763:	89 34 24             	mov    %esi,(%esp)
 766:	e8 b0 fb ff ff       	call   31b <sbrk>
  if(p == (char*)-1)
 76b:	83 f8 ff             	cmp    $0xffffffff,%eax
 76e:	74 18                	je     788 <malloc+0x78>
  hp->s.size = nu;
 770:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 773:	83 c0 08             	add    $0x8,%eax
 776:	89 04 24             	mov    %eax,(%esp)
 779:	e8 e2 fe ff ff       	call   660 <free>
  return freep;
 77e:	8b 15 6c 08 00 00    	mov    0x86c,%edx
      if((p = morecore(nunits)) == 0)
 784:	85 d2                	test   %edx,%edx
 786:	75 c8                	jne    750 <malloc+0x40>
        return 0;
  }
}
 788:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 78b:	31 c0                	xor    %eax,%eax
}
 78d:	5b                   	pop    %ebx
 78e:	5e                   	pop    %esi
 78f:	5f                   	pop    %edi
 790:	5d                   	pop    %ebp
 791:	c3                   	ret
 792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 798:	39 cf                	cmp    %ecx,%edi
 79a:	74 54                	je     7f0 <malloc+0xe0>
        p->s.size -= nunits;
 79c:	29 f9                	sub    %edi,%ecx
 79e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7a4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7a7:	89 15 6c 08 00 00    	mov    %edx,0x86c
}
 7ad:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 7b0:	83 c0 08             	add    $0x8,%eax
}
 7b3:	5b                   	pop    %ebx
 7b4:	5e                   	pop    %esi
 7b5:	5f                   	pop    %edi
 7b6:	5d                   	pop    %ebp
 7b7:	c3                   	ret
 7b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7bf:	00 
    base.s.ptr = freep = prevp = &base;
 7c0:	b8 70 08 00 00       	mov    $0x870,%eax
 7c5:	ba 70 08 00 00       	mov    $0x870,%edx
 7ca:	a3 6c 08 00 00       	mov    %eax,0x86c
    base.s.size = 0;
 7cf:	31 c9                	xor    %ecx,%ecx
 7d1:	b8 70 08 00 00       	mov    $0x870,%eax
    base.s.ptr = freep = prevp = &base;
 7d6:	89 15 70 08 00 00    	mov    %edx,0x870
    base.s.size = 0;
 7dc:	89 0d 74 08 00 00    	mov    %ecx,0x874
    if(p->s.size >= nunits){
 7e2:	e9 53 ff ff ff       	jmp    73a <malloc+0x2a>
 7e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ee:	00 
 7ef:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 7f0:	8b 08                	mov    (%eax),%ecx
 7f2:	89 0a                	mov    %ecx,(%edx)
 7f4:	eb b1                	jmp    7a7 <malloc+0x97>
