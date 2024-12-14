
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 5d 02 00 00       	call   26b <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 e5 02 00 00       	call   303 <sleep>
  exit();
  1e:	e8 50 02 00 00       	call   273 <exit>
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	66 90                	xchg   %ax,%ax
  29:	66 90                	xchg   %ax,%ax
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  31:	31 c0                	xor    %eax,%eax
{
  33:	89 e5                	mov    %esp,%ebp
  35:	53                   	push   %ebx
  36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  47:	40                   	inc    %eax
  48:	84 d2                	test   %dl,%dl
  4a:	75 f4                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4c:	5b                   	pop    %ebx
  4d:	89 c8                	mov    %ecx,%eax
  4f:	5d                   	pop    %ebp
  50:	c3                   	ret
  51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  58:	00 
  59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	75 15                	jne    86 <strcmp+0x26>
  71:	eb 30                	jmp    a3 <strcmp+0x43>
  73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  78:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  7c:	8d 4b 01             	lea    0x1(%ebx),%ecx
  7f:	42                   	inc    %edx
  while(*p && *p == *q)
  80:	84 c0                	test   %al,%al
  82:	74 14                	je     98 <strcmp+0x38>
  84:	89 cb                	mov    %ecx,%ebx
  86:	0f b6 0b             	movzbl (%ebx),%ecx
  89:	38 c1                	cmp    %al,%cl
  8b:	74 eb                	je     78 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  8d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  8e:	29 c8                	sub    %ecx,%eax
}
  90:	5d                   	pop    %ebp
  91:	c3                   	ret
  92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  98:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  9c:	31 c0                	xor    %eax,%eax
}
  9e:	5b                   	pop    %ebx
  9f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  a0:	29 c8                	sub    %ecx,%eax
}
  a2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  a3:	0f b6 0b             	movzbl (%ebx),%ecx
  a6:	31 c0                	xor    %eax,%eax
  a8:	eb e3                	jmp    8d <strcmp+0x2d>
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 3a 00             	cmpb   $0x0,(%edx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 c0                	xor    %eax,%eax
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	40                   	inc    %eax
  c1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  c5:	89 c1                	mov    %eax,%ecx
  c7:	75 f7                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  c9:	5d                   	pop    %ebp
  ca:	89 c8                	mov    %ecx,%eax
  cc:	c3                   	ret
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
  d1:	31 c9                	xor    %ecx,%ecx
}
  d3:	89 c8                	mov    %ecx,%eax
  d5:	c3                   	ret
  d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  dd:	00 
  de:	66 90                	xchg   %ax,%ax

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	5f                   	pop    %edi
  f3:	89 d0                	mov    %edx,%eax
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret
  f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fe:	00 
  ff:	90                   	nop

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	75 10                	jne    121 <strchr+0x21>
 111:	eb 1d                	jmp    130 <strchr+0x30>
 113:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 118:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 11c:	40                   	inc    %eax
 11d:	84 d2                	test   %dl,%dl
 11f:	74 0f                	je     130 <strchr+0x30>
    if(*s == c)
 121:	38 d1                	cmp    %dl,%cl
 123:	75 f3                	jne    118 <strchr+0x18>
      return (char*)s;
  return 0;
}
 125:	5d                   	pop    %ebp
 126:	c3                   	ret
 127:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12e:	00 
 12f:	90                   	nop
 130:	5d                   	pop    %ebp
  return 0;
 131:	31 c0                	xor    %eax,%eax
}
 133:	c3                   	ret
 134:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13b:	00 
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 145:	31 f6                	xor    %esi,%esi
{
 147:	53                   	push   %ebx
    cc = read(0, &c, 1);
 148:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 14b:	83 ec 3c             	sub    $0x3c,%esp
 14e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 151:	eb 32                	jmp    185 <gets+0x45>
 153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 158:	89 7c 24 04          	mov    %edi,0x4(%esp)
 15c:	b8 01 00 00 00       	mov    $0x1,%eax
 161:	89 44 24 08          	mov    %eax,0x8(%esp)
 165:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 16c:	e8 1a 01 00 00       	call   28b <read>
    if(cc < 1)
 171:	85 c0                	test   %eax,%eax
 173:	7e 19                	jle    18e <gets+0x4e>
      break;
    buf[i++] = c;
 175:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 179:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 17d:	3c 0a                	cmp    $0xa,%al
 17f:	74 10                	je     191 <gets+0x51>
 181:	3c 0d                	cmp    $0xd,%al
 183:	74 0c                	je     191 <gets+0x51>
  for(i=0; i+1 < max; ){
 185:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 188:	46                   	inc    %esi
 189:	3b 75 0c             	cmp    0xc(%ebp),%esi
 18c:	7c ca                	jl     158 <gets+0x18>
 18e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 191:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 195:	83 c4 3c             	add    $0x3c,%esp
 198:	89 d8                	mov    %ebx,%eax
 19a:	5b                   	pop    %ebx
 19b:	5e                   	pop    %esi
 19c:	5f                   	pop    %edi
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret
 19f:	90                   	nop

000001a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a1:	31 c0                	xor    %eax,%eax
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	83 ec 18             	sub    $0x18,%esp
 1a8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1ab:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1ae:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b2:	8b 45 08             	mov    0x8(%ebp),%eax
 1b5:	89 04 24             	mov    %eax,(%esp)
 1b8:	e8 f6 00 00 00       	call   2b3 <open>
  if(fd < 0)
 1bd:	85 c0                	test   %eax,%eax
 1bf:	78 2f                	js     1f0 <stat+0x50>
 1c1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c6:	89 1c 24             	mov    %ebx,(%esp)
 1c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cd:	e8 f9 00 00 00       	call   2cb <fstat>
  close(fd);
 1d2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1d5:	89 c6                	mov    %eax,%esi
  close(fd);
 1d7:	e8 bf 00 00 00       	call   29b <close>
  return r;
}
 1dc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1df:	89 f0                	mov    %esi,%eax
 1e1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1e4:	89 ec                	mov    %ebp,%esp
 1e6:	5d                   	pop    %ebp
 1e7:	c3                   	ret
 1e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ef:	00 
    return -1;
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb e5                	jmp    1dc <stat+0x3c>
 1f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1fe:	00 
 1ff:	90                   	nop

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	0f be 02             	movsbl (%edx),%eax
 20a:	88 c1                	mov    %al,%cl
 20c:	80 e9 30             	sub    $0x30,%cl
 20f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 212:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 217:	77 1c                	ja     235 <atoi+0x35>
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 220:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 223:	42                   	inc    %edx
 224:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 228:	0f be 02             	movsbl (%edx),%eax
 22b:	88 c3                	mov    %al,%bl
 22d:	80 eb 30             	sub    $0x30,%bl
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
  return n;
}
 235:	5b                   	pop    %ebx
 236:	89 c8                	mov    %ecx,%eax
 238:	5d                   	pop    %ebp
 239:	c3                   	ret
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 45 10             	mov    0x10(%ebp),%eax
 247:	56                   	push   %esi
 248:	8b 55 08             	mov    0x8(%ebp),%edx
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 c0                	test   %eax,%eax
 250:	7e 13                	jle    265 <memmove+0x25>
 252:	01 d0                	add    %edx,%eax
  dst = vdst;
 254:	89 d7                	mov    %edx,%edi
 256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25d:	00 
 25e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 260:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 261:	39 f8                	cmp    %edi,%eax
 263:	75 fb                	jne    260 <memmove+0x20>
  return vdst;
}
 265:	5e                   	pop    %esi
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret

0000026b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret

00000273 <exit>:
SYSCALL(exit)
 273:	b8 02 00 00 00       	mov    $0x2,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret

0000027b <wait>:
SYSCALL(wait)
 27b:	b8 03 00 00 00       	mov    $0x3,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret

00000283 <pipe>:
SYSCALL(pipe)
 283:	b8 04 00 00 00       	mov    $0x4,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret

0000028b <read>:
SYSCALL(read)
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret

00000293 <write>:
SYSCALL(write)
 293:	b8 10 00 00 00       	mov    $0x10,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret

0000029b <close>:
SYSCALL(close)
 29b:	b8 15 00 00 00       	mov    $0x15,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <kill>:
SYSCALL(kill)
 2a3:	b8 06 00 00 00       	mov    $0x6,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <exec>:
SYSCALL(exec)
 2ab:	b8 07 00 00 00       	mov    $0x7,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <open>:
SYSCALL(open)
 2b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <mknod>:
SYSCALL(mknod)
 2bb:	b8 11 00 00 00       	mov    $0x11,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <unlink>:
SYSCALL(unlink)
 2c3:	b8 12 00 00 00       	mov    $0x12,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <fstat>:
SYSCALL(fstat)
 2cb:	b8 08 00 00 00       	mov    $0x8,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <link>:
SYSCALL(link)
 2d3:	b8 13 00 00 00       	mov    $0x13,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <mkdir>:
SYSCALL(mkdir)
 2db:	b8 14 00 00 00       	mov    $0x14,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <chdir>:
SYSCALL(chdir)
 2e3:	b8 09 00 00 00       	mov    $0x9,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <dup>:
SYSCALL(dup)
 2eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <getpid>:
SYSCALL(getpid)
 2f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <sbrk>:
SYSCALL(sbrk)
 2fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <sleep>:
SYSCALL(sleep)
 303:	b8 0d 00 00 00       	mov    $0xd,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <uptime>:
SYSCALL(uptime)
 30b:	b8 0e 00 00 00       	mov    $0xe,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <worldpeace>:
SYSCALL(worldpeace)
 313:	b8 16 00 00 00       	mov    $0x16,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <numberofprocesses>:
SYSCALL(numberofprocesses)
 31b:	b8 17 00 00 00       	mov    $0x17,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <whatsthestatus>:
SYSCALL(whatsthestatus)
 323:	b8 18 00 00 00       	mov    $0x18,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <get_sibling>:
SYSCALL(get_sibling)
 32b:	b8 19 00 00 00       	mov    $0x19,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <spawn>:
SYSCALL(spawn)
 333:	b8 1a 00 00 00       	mov    $0x1a,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <getvasize>:
SYSCALL(getvasize)
 33b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <va2pa>:
SYSCALL(va2pa)
 343:	b8 1c 00 00 00       	mov    $0x1c,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 34b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 353:	b8 1e 00 00 00       	mov    $0x1e,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 35b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <getpasize>:
SYSCALL(getpasize)
 363:	b8 20 00 00 00       	mov    $0x20,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret
 36b:	66 90                	xchg   %ax,%ax
 36d:	66 90                	xchg   %ax,%ax
 36f:	90                   	nop

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	89 cb                	mov    %ecx,%ebx
 378:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 37b:	89 d1                	mov    %edx,%ecx
{
 37d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 380:	89 d0                	mov    %edx,%eax
 382:	c1 e8 1f             	shr    $0x1f,%eax
 385:	84 c0                	test   %al,%al
 387:	0f 84 93 00 00 00    	je     420 <printint+0xb0>
 38d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 391:	0f 84 89 00 00 00    	je     420 <printint+0xb0>
    x = -xx;
 397:	f7 d9                	neg    %ecx
    neg = 1;
 399:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 39e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3a5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3a8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 3ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3b0:	89 c8                	mov    %ecx,%eax
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3b7:	f7 f3                	div    %ebx
 3b9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3bc:	0f b6 92 38 08 00 00 	movzbl 0x838(%edx),%edx
 3c3:	8d 47 01             	lea    0x1(%edi),%eax
 3c6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3c9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 3cd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 3cf:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 3d2:	39 da                	cmp    %ebx,%edx
 3d4:	73 da                	jae    3b0 <printint+0x40>
  if(neg)
 3d6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 3d9:	85 c0                	test   %eax,%eax
 3db:	74 0a                	je     3e7 <printint+0x77>
    buf[i++] = '-';
 3dd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3e0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 3e5:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 3e7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3ea:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 3ee:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 3f0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 3f3:	89 74 24 04          	mov    %esi,0x4(%esp)
 3f7:	88 45 d7             	mov    %al,-0x29(%ebp)
 3fa:	b8 01 00 00 00       	mov    $0x1,%eax
 3ff:	89 44 24 08          	mov    %eax,0x8(%esp)
 403:	8b 45 bc             	mov    -0x44(%ebp),%eax
 406:	89 04 24             	mov    %eax,(%esp)
 409:	e8 85 fe ff ff       	call   293 <write>
  while(--i >= 0)
 40e:	89 f8                	mov    %edi,%eax
 410:	4f                   	dec    %edi
 411:	39 d8                	cmp    %ebx,%eax
 413:	75 db                	jne    3f0 <printint+0x80>
}
 415:	83 c4 4c             	add    $0x4c,%esp
 418:	5b                   	pop    %ebx
 419:	5e                   	pop    %esi
 41a:	5f                   	pop    %edi
 41b:	5d                   	pop    %ebp
 41c:	c3                   	ret
 41d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 420:	31 c0                	xor    %eax,%eax
 422:	e9 77 ff ff ff       	jmp    39e <printint+0x2e>
 427:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 42e:	00 
 42f:	90                   	nop

00000430 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 439:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 43c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 43f:	0f b6 13             	movzbl (%ebx),%edx
 442:	43                   	inc    %ebx
 443:	84 d2                	test   %dl,%dl
 445:	74 35                	je     47c <printf+0x4c>
 447:	8d 45 10             	lea    0x10(%ebp),%eax
 44a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 44d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 450:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 453:	83 f8 25             	cmp    $0x25,%eax
 456:	74 30                	je     488 <printf+0x58>
  write(fd, &c, 1);
 458:	89 34 24             	mov    %esi,(%esp)
 45b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 460:	43                   	inc    %ebx
  write(fd, &c, 1);
 461:	89 44 24 08          	mov    %eax,0x8(%esp)
 465:	8d 45 e7             	lea    -0x19(%ebp),%eax
 468:	89 44 24 04          	mov    %eax,0x4(%esp)
 46c:	88 55 e7             	mov    %dl,-0x19(%ebp)
 46f:	e8 1f fe ff ff       	call   293 <write>
  for(i = 0; fmt[i]; i++){
 474:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 478:	84 d2                	test   %dl,%dl
 47a:	75 d4                	jne    450 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 47c:	83 c4 3c             	add    $0x3c,%esp
 47f:	5b                   	pop    %ebx
 480:	5e                   	pop    %esi
 481:	5f                   	pop    %edi
 482:	5d                   	pop    %ebp
 483:	c3                   	ret
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 488:	0f b6 13             	movzbl (%ebx),%edx
 48b:	84 d2                	test   %dl,%dl
 48d:	74 ed                	je     47c <printf+0x4c>
    c = fmt[i] & 0xff;
 48f:	80 fa 25             	cmp    $0x25,%dl
 492:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 495:	0f 84 75 01 00 00    	je     610 <printf+0x1e0>
 49b:	83 e8 63             	sub    $0x63,%eax
 49e:	83 f8 15             	cmp    $0x15,%eax
 4a1:	77 0d                	ja     4b0 <printf+0x80>
 4a3:	ff 24 85 e0 07 00 00 	jmp    *0x7e0(,%eax,4)
 4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4b0:	89 34 24             	mov    %esi,(%esp)
 4b3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4b6:	b8 01 00 00 00       	mov    $0x1,%eax
 4bb:	89 44 24 08          	mov    %eax,0x8(%esp)
 4bf:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4c3:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 4c6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4ca:	e8 c4 fd ff ff       	call   293 <write>
        putc(fd, c);
 4cf:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 4d3:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4d6:	ba 01 00 00 00       	mov    $0x1,%edx
 4db:	89 54 24 08          	mov    %edx,0x8(%esp)
 4df:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 4e3:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 4e6:	89 34 24             	mov    %esi,(%esp)
 4e9:	e8 a5 fd ff ff       	call   293 <write>
  for(i = 0; fmt[i]; i++){
 4ee:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4f2:	84 d2                	test   %dl,%dl
 4f4:	0f 85 56 ff ff ff    	jne    450 <printf+0x20>
}
 4fa:	83 c4 3c             	add    $0x3c,%esp
 4fd:	5b                   	pop    %ebx
 4fe:	5e                   	pop    %esi
 4ff:	5f                   	pop    %edi
 500:	5d                   	pop    %ebp
 501:	c3                   	ret
 502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 508:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 50b:	b9 10 00 00 00       	mov    $0x10,%ecx
 510:	8b 17                	mov    (%edi),%edx
 512:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 519:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 51c:	89 f0                	mov    %esi,%eax
 51e:	e8 4d fe ff ff       	call   370 <printint>
  for(i = 0; fmt[i]; i++){
 523:	83 c3 02             	add    $0x2,%ebx
        ap++;
 526:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 529:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 52d:	84 d2                	test   %dl,%dl
 52f:	0f 85 1b ff ff ff    	jne    450 <printf+0x20>
}
 535:	83 c4 3c             	add    $0x3c,%esp
 538:	5b                   	pop    %ebx
 539:	5e                   	pop    %esi
 53a:	5f                   	pop    %edi
 53b:	5d                   	pop    %ebp
 53c:	c3                   	ret
 53d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 540:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 543:	8b 01                	mov    (%ecx),%eax
        ap++;
 545:	83 c1 04             	add    $0x4,%ecx
 548:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 54b:	85 c0                	test   %eax,%eax
 54d:	0f 84 d5 00 00 00    	je     628 <printf+0x1f8>
        while(*s != 0){
 553:	0f b6 10             	movzbl (%eax),%edx
 556:	84 d2                	test   %dl,%dl
 558:	74 39                	je     593 <printf+0x163>
 55a:	89 c7                	mov    %eax,%edi
 55c:	88 d0                	mov    %dl,%al
 55e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 561:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 564:	89 fb                	mov    %edi,%ebx
 566:	89 cf                	mov    %ecx,%edi
 568:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 56f:	00 
          putc(fd, *s);
 570:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 573:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 578:	43                   	inc    %ebx
  write(fd, &c, 1);
 579:	89 44 24 08          	mov    %eax,0x8(%esp)
 57d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 581:	89 34 24             	mov    %esi,(%esp)
 584:	e8 0a fd ff ff       	call   293 <write>
        while(*s != 0){
 589:	0f b6 03             	movzbl (%ebx),%eax
 58c:	84 c0                	test   %al,%al
 58e:	75 e0                	jne    570 <printf+0x140>
 590:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 593:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 597:	83 c3 02             	add    $0x2,%ebx
 59a:	84 d2                	test   %dl,%dl
 59c:	0f 85 ae fe ff ff    	jne    450 <printf+0x20>
 5a2:	e9 d5 fe ff ff       	jmp    47c <printf+0x4c>
 5a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ae:	00 
 5af:	90                   	nop
        printint(fd, *ap, 10, 1);
 5b0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5b8:	8b 17                	mov    (%edi),%edx
 5ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5c1:	e9 53 ff ff ff       	jmp    519 <printf+0xe9>
 5c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5cd:	00 
 5ce:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 5d0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 5d3:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 5d8:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 5db:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 5dd:	89 7c 24 08          	mov    %edi,0x8(%esp)
 5e1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5e4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5e8:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 5eb:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 5ee:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 5f2:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5f5:	e8 99 fc ff ff       	call   293 <write>
        ap++;
 5fa:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5fe:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 602:	84 d2                	test   %dl,%dl
 604:	0f 85 46 fe ff ff    	jne    450 <printf+0x20>
 60a:	e9 6d fe ff ff       	jmp    47c <printf+0x4c>
 60f:	90                   	nop
        putc(fd, c);
 610:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 613:	8d 7d e7             	lea    -0x19(%ebp),%edi
 616:	b9 01 00 00 00       	mov    $0x1,%ecx
 61b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 61f:	e9 bb fe ff ff       	jmp    4df <printf+0xaf>
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 628:	bf d8 07 00 00       	mov    $0x7d8,%edi
 62d:	b0 28                	mov    $0x28,%al
 62f:	e9 2a ff ff ff       	jmp    55e <printf+0x12e>
 634:	66 90                	xchg   %ax,%ax
 636:	66 90                	xchg   %ax,%ax
 638:	66 90                	xchg   %ax,%ax
 63a:	66 90                	xchg   %ax,%ax
 63c:	66 90                	xchg   %ax,%ax
 63e:	66 90                	xchg   %ax,%ax

00000640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 640:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	a1 4c 08 00 00       	mov    0x84c,%eax
{
 646:	89 e5                	mov    %esp,%ebp
 648:	57                   	push   %edi
 649:	56                   	push   %esi
 64a:	53                   	push   %ebx
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 64e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 658:	00 
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 660:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 662:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 664:	39 ca                	cmp    %ecx,%edx
 666:	73 30                	jae    698 <free+0x58>
 668:	39 c1                	cmp    %eax,%ecx
 66a:	72 04                	jb     670 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66c:	39 c2                	cmp    %eax,%edx
 66e:	72 f0                	jb     660 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 670:	8b 73 fc             	mov    -0x4(%ebx),%esi
 673:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 676:	39 f8                	cmp    %edi,%eax
 678:	74 36                	je     6b0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 67a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 67d:	8b 42 04             	mov    0x4(%edx),%eax
 680:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 683:	39 f1                	cmp    %esi,%ecx
 685:	74 42                	je     6c9 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 687:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 689:	5b                   	pop    %ebx
  freep = p;
 68a:	89 15 4c 08 00 00    	mov    %edx,0x84c
}
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 698:	39 c2                	cmp    %eax,%edx
 69a:	72 c4                	jb     660 <free+0x20>
 69c:	39 c1                	cmp    %eax,%ecx
 69e:	73 c0                	jae    660 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 6a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6a3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6a6:	39 f8                	cmp    %edi,%eax
 6a8:	75 d0                	jne    67a <free+0x3a>
 6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 6b0:	8b 78 04             	mov    0x4(%eax),%edi
 6b3:	01 fe                	add    %edi,%esi
 6b5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b8:	8b 02                	mov    (%edx),%eax
 6ba:	8b 00                	mov    (%eax),%eax
 6bc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6bf:	8b 42 04             	mov    0x4(%edx),%eax
 6c2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6c5:	39 f1                	cmp    %esi,%ecx
 6c7:	75 be                	jne    687 <free+0x47>
  freep = p;
 6c9:	89 15 4c 08 00 00    	mov    %edx,0x84c
    p->s.size += bp->s.size;
 6cf:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 6d2:	01 c8                	add    %ecx,%eax
 6d4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6d7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6da:	89 0a                	mov    %ecx,(%edx)
}
 6dc:	5b                   	pop    %ebx
 6dd:	5e                   	pop    %esi
 6de:	5f                   	pop    %edi
 6df:	5d                   	pop    %ebp
 6e0:	c3                   	ret
 6e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6e8:	00 
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6fc:	8b 15 4c 08 00 00    	mov    0x84c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	8d 78 07             	lea    0x7(%eax),%edi
 705:	c1 ef 03             	shr    $0x3,%edi
 708:	47                   	inc    %edi
  if((prevp = freep) == 0){
 709:	85 d2                	test   %edx,%edx
 70b:	0f 84 8f 00 00 00    	je     7a0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 711:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 713:	8b 48 04             	mov    0x4(%eax),%ecx
 716:	39 f9                	cmp    %edi,%ecx
 718:	73 5e                	jae    778 <malloc+0x88>
  if(nu < 4096)
 71a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 71f:	39 df                	cmp    %ebx,%edi
 721:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 724:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 72b:	eb 0c                	jmp    739 <malloc+0x49>
 72d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 730:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 732:	8b 48 04             	mov    0x4(%eax),%ecx
 735:	39 f9                	cmp    %edi,%ecx
 737:	73 3f                	jae    778 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 739:	39 05 4c 08 00 00    	cmp    %eax,0x84c
 73f:	89 c2                	mov    %eax,%edx
 741:	75 ed                	jne    730 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 743:	89 34 24             	mov    %esi,(%esp)
 746:	e8 b0 fb ff ff       	call   2fb <sbrk>
  if(p == (char*)-1)
 74b:	83 f8 ff             	cmp    $0xffffffff,%eax
 74e:	74 18                	je     768 <malloc+0x78>
  hp->s.size = nu;
 750:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 753:	83 c0 08             	add    $0x8,%eax
 756:	89 04 24             	mov    %eax,(%esp)
 759:	e8 e2 fe ff ff       	call   640 <free>
  return freep;
 75e:	8b 15 4c 08 00 00    	mov    0x84c,%edx
      if((p = morecore(nunits)) == 0)
 764:	85 d2                	test   %edx,%edx
 766:	75 c8                	jne    730 <malloc+0x40>
        return 0;
  }
}
 768:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 76b:	31 c0                	xor    %eax,%eax
}
 76d:	5b                   	pop    %ebx
 76e:	5e                   	pop    %esi
 76f:	5f                   	pop    %edi
 770:	5d                   	pop    %ebp
 771:	c3                   	ret
 772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 778:	39 cf                	cmp    %ecx,%edi
 77a:	74 54                	je     7d0 <malloc+0xe0>
        p->s.size -= nunits;
 77c:	29 f9                	sub    %edi,%ecx
 77e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 781:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 784:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 787:	89 15 4c 08 00 00    	mov    %edx,0x84c
}
 78d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 790:	83 c0 08             	add    $0x8,%eax
}
 793:	5b                   	pop    %ebx
 794:	5e                   	pop    %esi
 795:	5f                   	pop    %edi
 796:	5d                   	pop    %ebp
 797:	c3                   	ret
 798:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 79f:	00 
    base.s.ptr = freep = prevp = &base;
 7a0:	b8 50 08 00 00       	mov    $0x850,%eax
 7a5:	ba 50 08 00 00       	mov    $0x850,%edx
 7aa:	a3 4c 08 00 00       	mov    %eax,0x84c
    base.s.size = 0;
 7af:	31 c9                	xor    %ecx,%ecx
 7b1:	b8 50 08 00 00       	mov    $0x850,%eax
    base.s.ptr = freep = prevp = &base;
 7b6:	89 15 50 08 00 00    	mov    %edx,0x850
    base.s.size = 0;
 7bc:	89 0d 54 08 00 00    	mov    %ecx,0x854
    if(p->s.size >= nunits){
 7c2:	e9 53 ff ff ff       	jmp    71a <malloc+0x2a>
 7c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ce:	00 
 7cf:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 7d0:	8b 08                	mov    (%eax),%ecx
 7d2:	89 0a                	mov    %ecx,(%edx)
 7d4:	eb b1                	jmp    787 <malloc+0x97>
