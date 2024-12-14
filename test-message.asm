
_test-message:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main() {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
  worldpeace();
   6:	e8 e8 02 00 00       	call   2f3 <worldpeace>
  exit();
   b:	e8 43 02 00 00       	call   253 <exit>

00000010 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  10:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  11:	31 c0                	xor    %eax,%eax
{
  13:	89 e5                	mov    %esp,%ebp
  15:	53                   	push   %ebx
  16:	8b 4d 08             	mov    0x8(%ebp),%ecx
  19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  20:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  24:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  27:	40                   	inc    %eax
  28:	84 d2                	test   %dl,%dl
  2a:	75 f4                	jne    20 <strcpy+0x10>
    ;
  return os;
}
  2c:	5b                   	pop    %ebx
  2d:	89 c8                	mov    %ecx,%eax
  2f:	5d                   	pop    %ebp
  30:	c3                   	ret
  31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  38:	00 
  39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	53                   	push   %ebx
  44:	8b 55 08             	mov    0x8(%ebp),%edx
  47:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  4a:	0f b6 02             	movzbl (%edx),%eax
  4d:	84 c0                	test   %al,%al
  4f:	75 15                	jne    66 <strcmp+0x26>
  51:	eb 30                	jmp    83 <strcmp+0x43>
  53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  58:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  5c:	8d 4b 01             	lea    0x1(%ebx),%ecx
  5f:	42                   	inc    %edx
  while(*p && *p == *q)
  60:	84 c0                	test   %al,%al
  62:	74 14                	je     78 <strcmp+0x38>
  64:	89 cb                	mov    %ecx,%ebx
  66:	0f b6 0b             	movzbl (%ebx),%ecx
  69:	38 c1                	cmp    %al,%cl
  6b:	74 eb                	je     58 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  6d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  6e:	29 c8                	sub    %ecx,%eax
}
  70:	5d                   	pop    %ebp
  71:	c3                   	ret
  72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  78:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  7c:	31 c0                	xor    %eax,%eax
}
  7e:	5b                   	pop    %ebx
  7f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  80:	29 c8                	sub    %ecx,%eax
}
  82:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  83:	0f b6 0b             	movzbl (%ebx),%ecx
  86:	31 c0                	xor    %eax,%eax
  88:	eb e3                	jmp    6d <strcmp+0x2d>
  8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000090 <strlen>:

uint
strlen(const char *s)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  96:	80 3a 00             	cmpb   $0x0,(%edx)
  99:	74 15                	je     b0 <strlen+0x20>
  9b:	31 c0                	xor    %eax,%eax
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	40                   	inc    %eax
  a1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  a5:	89 c1                	mov    %eax,%ecx
  a7:	75 f7                	jne    a0 <strlen+0x10>
    ;
  return n;
}
  a9:	5d                   	pop    %ebp
  aa:	89 c8                	mov    %ecx,%eax
  ac:	c3                   	ret
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  b0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
  b1:	31 c9                	xor    %ecx,%ecx
}
  b3:	89 c8                	mov    %ecx,%eax
  b5:	c3                   	ret
  b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  bd:	00 
  be:	66 90                	xchg   %ax,%ax

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	89 d7                	mov    %edx,%edi
  cf:	fc                   	cld
  d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d2:	5f                   	pop    %edi
  d3:	89 d0                	mov    %edx,%eax
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret
  d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  de:	00 
  df:	90                   	nop

000000e0 <strchr>:

char*
strchr(const char *s, char c)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  ea:	0f b6 10             	movzbl (%eax),%edx
  ed:	84 d2                	test   %dl,%dl
  ef:	75 10                	jne    101 <strchr+0x21>
  f1:	eb 1d                	jmp    110 <strchr+0x30>
  f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  f8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
  fc:	40                   	inc    %eax
  fd:	84 d2                	test   %dl,%dl
  ff:	74 0f                	je     110 <strchr+0x30>
    if(*s == c)
 101:	38 d1                	cmp    %dl,%cl
 103:	75 f3                	jne    f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 105:	5d                   	pop    %ebp
 106:	c3                   	ret
 107:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10e:	00 
 10f:	90                   	nop
 110:	5d                   	pop    %ebp
  return 0;
 111:	31 c0                	xor    %eax,%eax
}
 113:	c3                   	ret
 114:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11b:	00 
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000120 <gets>:

char*
gets(char *buf, int max)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 125:	31 f6                	xor    %esi,%esi
{
 127:	53                   	push   %ebx
    cc = read(0, &c, 1);
 128:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 12b:	83 ec 3c             	sub    $0x3c,%esp
 12e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 131:	eb 32                	jmp    165 <gets+0x45>
 133:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 138:	89 7c 24 04          	mov    %edi,0x4(%esp)
 13c:	b8 01 00 00 00       	mov    $0x1,%eax
 141:	89 44 24 08          	mov    %eax,0x8(%esp)
 145:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 14c:	e8 1a 01 00 00       	call   26b <read>
    if(cc < 1)
 151:	85 c0                	test   %eax,%eax
 153:	7e 19                	jle    16e <gets+0x4e>
      break;
    buf[i++] = c;
 155:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 159:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 15d:	3c 0a                	cmp    $0xa,%al
 15f:	74 10                	je     171 <gets+0x51>
 161:	3c 0d                	cmp    $0xd,%al
 163:	74 0c                	je     171 <gets+0x51>
  for(i=0; i+1 < max; ){
 165:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 168:	46                   	inc    %esi
 169:	3b 75 0c             	cmp    0xc(%ebp),%esi
 16c:	7c ca                	jl     138 <gets+0x18>
 16e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 171:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 175:	83 c4 3c             	add    $0x3c,%esp
 178:	89 d8                	mov    %ebx,%eax
 17a:	5b                   	pop    %ebx
 17b:	5e                   	pop    %esi
 17c:	5f                   	pop    %edi
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret
 17f:	90                   	nop

00000180 <stat>:

int
stat(const char *n, struct stat *st)
{
 180:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 181:	31 c0                	xor    %eax,%eax
{
 183:	89 e5                	mov    %esp,%ebp
 185:	83 ec 18             	sub    $0x18,%esp
 188:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 18b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 18e:	89 44 24 04          	mov    %eax,0x4(%esp)
 192:	8b 45 08             	mov    0x8(%ebp),%eax
 195:	89 04 24             	mov    %eax,(%esp)
 198:	e8 f6 00 00 00       	call   293 <open>
  if(fd < 0)
 19d:	85 c0                	test   %eax,%eax
 19f:	78 2f                	js     1d0 <stat+0x50>
 1a1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a6:	89 1c 24             	mov    %ebx,(%esp)
 1a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ad:	e8 f9 00 00 00       	call   2ab <fstat>
  close(fd);
 1b2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1b5:	89 c6                	mov    %eax,%esi
  close(fd);
 1b7:	e8 bf 00 00 00       	call   27b <close>
  return r;
}
 1bc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1bf:	89 f0                	mov    %esi,%eax
 1c1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1c4:	89 ec                	mov    %ebp,%esp
 1c6:	5d                   	pop    %ebp
 1c7:	c3                   	ret
 1c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cf:	00 
    return -1;
 1d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1d5:	eb e5                	jmp    1bc <stat+0x3c>
 1d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1de:	00 
 1df:	90                   	nop

000001e0 <atoi>:

int
atoi(const char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e7:	0f be 02             	movsbl (%edx),%eax
 1ea:	88 c1                	mov    %al,%cl
 1ec:	80 e9 30             	sub    $0x30,%cl
 1ef:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 1f2:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 1f7:	77 1c                	ja     215 <atoi+0x35>
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 200:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 203:	42                   	inc    %edx
 204:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 208:	0f be 02             	movsbl (%edx),%eax
 20b:	88 c3                	mov    %al,%bl
 20d:	80 eb 30             	sub    $0x30,%bl
 210:	80 fb 09             	cmp    $0x9,%bl
 213:	76 eb                	jbe    200 <atoi+0x20>
  return n;
}
 215:	5b                   	pop    %ebx
 216:	89 c8                	mov    %ecx,%eax
 218:	5d                   	pop    %ebp
 219:	c3                   	ret
 21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000220 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	8b 45 10             	mov    0x10(%ebp),%eax
 227:	56                   	push   %esi
 228:	8b 55 08             	mov    0x8(%ebp),%edx
 22b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 22e:	85 c0                	test   %eax,%eax
 230:	7e 13                	jle    245 <memmove+0x25>
 232:	01 d0                	add    %edx,%eax
  dst = vdst;
 234:	89 d7                	mov    %edx,%edi
 236:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23d:	00 
 23e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 240:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 241:	39 f8                	cmp    %edi,%eax
 243:	75 fb                	jne    240 <memmove+0x20>
  return vdst;
}
 245:	5e                   	pop    %esi
 246:	89 d0                	mov    %edx,%eax
 248:	5f                   	pop    %edi
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret

0000024b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 24b:	b8 01 00 00 00       	mov    $0x1,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret

00000253 <exit>:
SYSCALL(exit)
 253:	b8 02 00 00 00       	mov    $0x2,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret

0000025b <wait>:
SYSCALL(wait)
 25b:	b8 03 00 00 00       	mov    $0x3,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret

00000263 <pipe>:
SYSCALL(pipe)
 263:	b8 04 00 00 00       	mov    $0x4,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret

0000026b <read>:
SYSCALL(read)
 26b:	b8 05 00 00 00       	mov    $0x5,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret

00000273 <write>:
SYSCALL(write)
 273:	b8 10 00 00 00       	mov    $0x10,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret

0000027b <close>:
SYSCALL(close)
 27b:	b8 15 00 00 00       	mov    $0x15,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret

00000283 <kill>:
SYSCALL(kill)
 283:	b8 06 00 00 00       	mov    $0x6,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret

0000028b <exec>:
SYSCALL(exec)
 28b:	b8 07 00 00 00       	mov    $0x7,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret

00000293 <open>:
SYSCALL(open)
 293:	b8 0f 00 00 00       	mov    $0xf,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret

0000029b <mknod>:
SYSCALL(mknod)
 29b:	b8 11 00 00 00       	mov    $0x11,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <unlink>:
SYSCALL(unlink)
 2a3:	b8 12 00 00 00       	mov    $0x12,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <fstat>:
SYSCALL(fstat)
 2ab:	b8 08 00 00 00       	mov    $0x8,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <link>:
SYSCALL(link)
 2b3:	b8 13 00 00 00       	mov    $0x13,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <mkdir>:
SYSCALL(mkdir)
 2bb:	b8 14 00 00 00       	mov    $0x14,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <chdir>:
SYSCALL(chdir)
 2c3:	b8 09 00 00 00       	mov    $0x9,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <dup>:
SYSCALL(dup)
 2cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <getpid>:
SYSCALL(getpid)
 2d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <sbrk>:
SYSCALL(sbrk)
 2db:	b8 0c 00 00 00       	mov    $0xc,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <sleep>:
SYSCALL(sleep)
 2e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <uptime>:
SYSCALL(uptime)
 2eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <worldpeace>:
SYSCALL(worldpeace)
 2f3:	b8 16 00 00 00       	mov    $0x16,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <numberofprocesses>:
SYSCALL(numberofprocesses)
 2fb:	b8 17 00 00 00       	mov    $0x17,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <whatsthestatus>:
SYSCALL(whatsthestatus)
 303:	b8 18 00 00 00       	mov    $0x18,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <get_sibling>:
SYSCALL(get_sibling)
 30b:	b8 19 00 00 00       	mov    $0x19,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <spawn>:
SYSCALL(spawn)
 313:	b8 1a 00 00 00       	mov    $0x1a,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <getvasize>:
SYSCALL(getvasize)
 31b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <va2pa>:
SYSCALL(va2pa)
 323:	b8 1c 00 00 00       	mov    $0x1c,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 32b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 333:	b8 1e 00 00 00       	mov    $0x1e,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 33b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <getpasize>:
SYSCALL(getpasize)
 343:	b8 20 00 00 00       	mov    $0x20,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret
 34b:	66 90                	xchg   %ax,%ax
 34d:	66 90                	xchg   %ax,%ax
 34f:	90                   	nop

00000350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	89 cb                	mov    %ecx,%ebx
 358:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 35b:	89 d1                	mov    %edx,%ecx
{
 35d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 360:	89 d0                	mov    %edx,%eax
 362:	c1 e8 1f             	shr    $0x1f,%eax
 365:	84 c0                	test   %al,%al
 367:	0f 84 93 00 00 00    	je     400 <printint+0xb0>
 36d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 371:	0f 84 89 00 00 00    	je     400 <printint+0xb0>
    x = -xx;
 377:	f7 d9                	neg    %ecx
    neg = 1;
 379:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 37e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 385:	8d 75 d7             	lea    -0x29(%ebp),%esi
 388:	89 45 b8             	mov    %eax,-0x48(%ebp)
 38b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 390:	89 c8                	mov    %ecx,%eax
 392:	31 d2                	xor    %edx,%edx
 394:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 397:	f7 f3                	div    %ebx
 399:	89 45 c0             	mov    %eax,-0x40(%ebp)
 39c:	0f b6 92 18 08 00 00 	movzbl 0x818(%edx),%edx
 3a3:	8d 47 01             	lea    0x1(%edi),%eax
 3a6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3a9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 3ad:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 3af:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 3b2:	39 da                	cmp    %ebx,%edx
 3b4:	73 da                	jae    390 <printint+0x40>
  if(neg)
 3b6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 3b9:	85 c0                	test   %eax,%eax
 3bb:	74 0a                	je     3c7 <printint+0x77>
    buf[i++] = '-';
 3bd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3c0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 3c5:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 3c7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3ca:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 3ce:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 3d0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 3d3:	89 74 24 04          	mov    %esi,0x4(%esp)
 3d7:	88 45 d7             	mov    %al,-0x29(%ebp)
 3da:	b8 01 00 00 00       	mov    $0x1,%eax
 3df:	89 44 24 08          	mov    %eax,0x8(%esp)
 3e3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 3e6:	89 04 24             	mov    %eax,(%esp)
 3e9:	e8 85 fe ff ff       	call   273 <write>
  while(--i >= 0)
 3ee:	89 f8                	mov    %edi,%eax
 3f0:	4f                   	dec    %edi
 3f1:	39 d8                	cmp    %ebx,%eax
 3f3:	75 db                	jne    3d0 <printint+0x80>
}
 3f5:	83 c4 4c             	add    $0x4c,%esp
 3f8:	5b                   	pop    %ebx
 3f9:	5e                   	pop    %esi
 3fa:	5f                   	pop    %edi
 3fb:	5d                   	pop    %ebp
 3fc:	c3                   	ret
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 400:	31 c0                	xor    %eax,%eax
 402:	e9 77 ff ff ff       	jmp    37e <printint+0x2e>
 407:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40e:	00 
 40f:	90                   	nop

00000410 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 419:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 41c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 41f:	0f b6 13             	movzbl (%ebx),%edx
 422:	43                   	inc    %ebx
 423:	84 d2                	test   %dl,%dl
 425:	74 35                	je     45c <printf+0x4c>
 427:	8d 45 10             	lea    0x10(%ebp),%eax
 42a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 42d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 430:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 433:	83 f8 25             	cmp    $0x25,%eax
 436:	74 30                	je     468 <printf+0x58>
  write(fd, &c, 1);
 438:	89 34 24             	mov    %esi,(%esp)
 43b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 440:	43                   	inc    %ebx
  write(fd, &c, 1);
 441:	89 44 24 08          	mov    %eax,0x8(%esp)
 445:	8d 45 e7             	lea    -0x19(%ebp),%eax
 448:	89 44 24 04          	mov    %eax,0x4(%esp)
 44c:	88 55 e7             	mov    %dl,-0x19(%ebp)
 44f:	e8 1f fe ff ff       	call   273 <write>
  for(i = 0; fmt[i]; i++){
 454:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 458:	84 d2                	test   %dl,%dl
 45a:	75 d4                	jne    430 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 45c:	83 c4 3c             	add    $0x3c,%esp
 45f:	5b                   	pop    %ebx
 460:	5e                   	pop    %esi
 461:	5f                   	pop    %edi
 462:	5d                   	pop    %ebp
 463:	c3                   	ret
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 468:	0f b6 13             	movzbl (%ebx),%edx
 46b:	84 d2                	test   %dl,%dl
 46d:	74 ed                	je     45c <printf+0x4c>
    c = fmt[i] & 0xff;
 46f:	80 fa 25             	cmp    $0x25,%dl
 472:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 475:	0f 84 75 01 00 00    	je     5f0 <printf+0x1e0>
 47b:	83 e8 63             	sub    $0x63,%eax
 47e:	83 f8 15             	cmp    $0x15,%eax
 481:	77 0d                	ja     490 <printf+0x80>
 483:	ff 24 85 c0 07 00 00 	jmp    *0x7c0(,%eax,4)
 48a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 490:	89 34 24             	mov    %esi,(%esp)
 493:	8d 7d e7             	lea    -0x19(%ebp),%edi
 496:	b8 01 00 00 00       	mov    $0x1,%eax
 49b:	89 44 24 08          	mov    %eax,0x8(%esp)
 49f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4a3:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 4a6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4aa:	e8 c4 fd ff ff       	call   273 <write>
        putc(fd, c);
 4af:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 4b3:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4b6:	ba 01 00 00 00       	mov    $0x1,%edx
 4bb:	89 54 24 08          	mov    %edx,0x8(%esp)
 4bf:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 4c3:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 4c6:	89 34 24             	mov    %esi,(%esp)
 4c9:	e8 a5 fd ff ff       	call   273 <write>
  for(i = 0; fmt[i]; i++){
 4ce:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4d2:	84 d2                	test   %dl,%dl
 4d4:	0f 85 56 ff ff ff    	jne    430 <printf+0x20>
}
 4da:	83 c4 3c             	add    $0x3c,%esp
 4dd:	5b                   	pop    %ebx
 4de:	5e                   	pop    %esi
 4df:	5f                   	pop    %edi
 4e0:	5d                   	pop    %ebp
 4e1:	c3                   	ret
 4e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4e8:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4eb:	b9 10 00 00 00       	mov    $0x10,%ecx
 4f0:	8b 17                	mov    (%edi),%edx
 4f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 4f9:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 4fc:	89 f0                	mov    %esi,%eax
 4fe:	e8 4d fe ff ff       	call   350 <printint>
  for(i = 0; fmt[i]; i++){
 503:	83 c3 02             	add    $0x2,%ebx
        ap++;
 506:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 509:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 50d:	84 d2                	test   %dl,%dl
 50f:	0f 85 1b ff ff ff    	jne    430 <printf+0x20>
}
 515:	83 c4 3c             	add    $0x3c,%esp
 518:	5b                   	pop    %ebx
 519:	5e                   	pop    %esi
 51a:	5f                   	pop    %edi
 51b:	5d                   	pop    %ebp
 51c:	c3                   	ret
 51d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 520:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 523:	8b 01                	mov    (%ecx),%eax
        ap++;
 525:	83 c1 04             	add    $0x4,%ecx
 528:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 52b:	85 c0                	test   %eax,%eax
 52d:	0f 84 d5 00 00 00    	je     608 <printf+0x1f8>
        while(*s != 0){
 533:	0f b6 10             	movzbl (%eax),%edx
 536:	84 d2                	test   %dl,%dl
 538:	74 39                	je     573 <printf+0x163>
 53a:	89 c7                	mov    %eax,%edi
 53c:	88 d0                	mov    %dl,%al
 53e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 541:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 544:	89 fb                	mov    %edi,%ebx
 546:	89 cf                	mov    %ecx,%edi
 548:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 54f:	00 
          putc(fd, *s);
 550:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 553:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 558:	43                   	inc    %ebx
  write(fd, &c, 1);
 559:	89 44 24 08          	mov    %eax,0x8(%esp)
 55d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 561:	89 34 24             	mov    %esi,(%esp)
 564:	e8 0a fd ff ff       	call   273 <write>
        while(*s != 0){
 569:	0f b6 03             	movzbl (%ebx),%eax
 56c:	84 c0                	test   %al,%al
 56e:	75 e0                	jne    550 <printf+0x140>
 570:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 573:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 577:	83 c3 02             	add    $0x2,%ebx
 57a:	84 d2                	test   %dl,%dl
 57c:	0f 85 ae fe ff ff    	jne    430 <printf+0x20>
 582:	e9 d5 fe ff ff       	jmp    45c <printf+0x4c>
 587:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 58e:	00 
 58f:	90                   	nop
        printint(fd, *ap, 10, 1);
 590:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 593:	b9 0a 00 00 00       	mov    $0xa,%ecx
 598:	8b 17                	mov    (%edi),%edx
 59a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5a1:	e9 53 ff ff ff       	jmp    4f9 <printf+0xe9>
 5a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ad:	00 
 5ae:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 5b0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 5b3:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 5b8:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 5bb:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 5bd:	89 7c 24 08          	mov    %edi,0x8(%esp)
 5c1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5c4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5c8:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 5cb:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 5ce:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 5d2:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5d5:	e8 99 fc ff ff       	call   273 <write>
        ap++;
 5da:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5de:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5e2:	84 d2                	test   %dl,%dl
 5e4:	0f 85 46 fe ff ff    	jne    430 <printf+0x20>
 5ea:	e9 6d fe ff ff       	jmp    45c <printf+0x4c>
 5ef:	90                   	nop
        putc(fd, c);
 5f0:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5f3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5f6:	b9 01 00 00 00       	mov    $0x1,%ecx
 5fb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5ff:	e9 bb fe ff ff       	jmp    4bf <printf+0xaf>
 604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 608:	bf b8 07 00 00       	mov    $0x7b8,%edi
 60d:	b0 28                	mov    $0x28,%al
 60f:	e9 2a ff ff ff       	jmp    53e <printf+0x12e>
 614:	66 90                	xchg   %ax,%ax
 616:	66 90                	xchg   %ax,%ax
 618:	66 90                	xchg   %ax,%ax
 61a:	66 90                	xchg   %ax,%ax
 61c:	66 90                	xchg   %ax,%ax
 61e:	66 90                	xchg   %ax,%ax

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	a1 2c 08 00 00       	mov    0x82c,%eax
{
 626:	89 e5                	mov    %esp,%ebp
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	53                   	push   %ebx
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 62e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 638:	00 
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 640:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 642:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 644:	39 ca                	cmp    %ecx,%edx
 646:	73 30                	jae    678 <free+0x58>
 648:	39 c1                	cmp    %eax,%ecx
 64a:	72 04                	jb     650 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64c:	39 c2                	cmp    %eax,%edx
 64e:	72 f0                	jb     640 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 650:	8b 73 fc             	mov    -0x4(%ebx),%esi
 653:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 656:	39 f8                	cmp    %edi,%eax
 658:	74 36                	je     690 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 65a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 65d:	8b 42 04             	mov    0x4(%edx),%eax
 660:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 663:	39 f1                	cmp    %esi,%ecx
 665:	74 42                	je     6a9 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 667:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 669:	5b                   	pop    %ebx
  freep = p;
 66a:	89 15 2c 08 00 00    	mov    %edx,0x82c
}
 670:	5e                   	pop    %esi
 671:	5f                   	pop    %edi
 672:	5d                   	pop    %ebp
 673:	c3                   	ret
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	39 c2                	cmp    %eax,%edx
 67a:	72 c4                	jb     640 <free+0x20>
 67c:	39 c1                	cmp    %eax,%ecx
 67e:	73 c0                	jae    640 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 680:	8b 73 fc             	mov    -0x4(%ebx),%esi
 683:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 686:	39 f8                	cmp    %edi,%eax
 688:	75 d0                	jne    65a <free+0x3a>
 68a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 690:	8b 78 04             	mov    0x4(%eax),%edi
 693:	01 fe                	add    %edi,%esi
 695:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 698:	8b 02                	mov    (%edx),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 69f:	8b 42 04             	mov    0x4(%edx),%eax
 6a2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6a5:	39 f1                	cmp    %esi,%ecx
 6a7:	75 be                	jne    667 <free+0x47>
  freep = p;
 6a9:	89 15 2c 08 00 00    	mov    %edx,0x82c
    p->s.size += bp->s.size;
 6af:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 6b2:	01 c8                	add    %ecx,%eax
 6b4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6b7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6ba:	89 0a                	mov    %ecx,(%edx)
}
 6bc:	5b                   	pop    %ebx
 6bd:	5e                   	pop    %esi
 6be:	5f                   	pop    %edi
 6bf:	5d                   	pop    %ebp
 6c0:	c3                   	ret
 6c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6c8:	00 
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	56                   	push   %esi
 6d5:	53                   	push   %ebx
 6d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6dc:	8b 15 2c 08 00 00    	mov    0x82c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e2:	8d 78 07             	lea    0x7(%eax),%edi
 6e5:	c1 ef 03             	shr    $0x3,%edi
 6e8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 6e9:	85 d2                	test   %edx,%edx
 6eb:	0f 84 8f 00 00 00    	je     780 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f3:	8b 48 04             	mov    0x4(%eax),%ecx
 6f6:	39 f9                	cmp    %edi,%ecx
 6f8:	73 5e                	jae    758 <malloc+0x88>
  if(nu < 4096)
 6fa:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6ff:	39 df                	cmp    %ebx,%edi
 701:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 704:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 70b:	eb 0c                	jmp    719 <malloc+0x49>
 70d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 710:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 712:	8b 48 04             	mov    0x4(%eax),%ecx
 715:	39 f9                	cmp    %edi,%ecx
 717:	73 3f                	jae    758 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 719:	39 05 2c 08 00 00    	cmp    %eax,0x82c
 71f:	89 c2                	mov    %eax,%edx
 721:	75 ed                	jne    710 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 723:	89 34 24             	mov    %esi,(%esp)
 726:	e8 b0 fb ff ff       	call   2db <sbrk>
  if(p == (char*)-1)
 72b:	83 f8 ff             	cmp    $0xffffffff,%eax
 72e:	74 18                	je     748 <malloc+0x78>
  hp->s.size = nu;
 730:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 733:	83 c0 08             	add    $0x8,%eax
 736:	89 04 24             	mov    %eax,(%esp)
 739:	e8 e2 fe ff ff       	call   620 <free>
  return freep;
 73e:	8b 15 2c 08 00 00    	mov    0x82c,%edx
      if((p = morecore(nunits)) == 0)
 744:	85 d2                	test   %edx,%edx
 746:	75 c8                	jne    710 <malloc+0x40>
        return 0;
  }
}
 748:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 74b:	31 c0                	xor    %eax,%eax
}
 74d:	5b                   	pop    %ebx
 74e:	5e                   	pop    %esi
 74f:	5f                   	pop    %edi
 750:	5d                   	pop    %ebp
 751:	c3                   	ret
 752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 758:	39 cf                	cmp    %ecx,%edi
 75a:	74 54                	je     7b0 <malloc+0xe0>
        p->s.size -= nunits;
 75c:	29 f9                	sub    %edi,%ecx
 75e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 761:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 764:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 767:	89 15 2c 08 00 00    	mov    %edx,0x82c
}
 76d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 770:	83 c0 08             	add    $0x8,%eax
}
 773:	5b                   	pop    %ebx
 774:	5e                   	pop    %esi
 775:	5f                   	pop    %edi
 776:	5d                   	pop    %ebp
 777:	c3                   	ret
 778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 77f:	00 
    base.s.ptr = freep = prevp = &base;
 780:	b8 30 08 00 00       	mov    $0x830,%eax
 785:	ba 30 08 00 00       	mov    $0x830,%edx
 78a:	a3 2c 08 00 00       	mov    %eax,0x82c
    base.s.size = 0;
 78f:	31 c9                	xor    %ecx,%ecx
 791:	b8 30 08 00 00       	mov    $0x830,%eax
    base.s.ptr = freep = prevp = &base;
 796:	89 15 30 08 00 00    	mov    %edx,0x830
    base.s.size = 0;
 79c:	89 0d 34 08 00 00    	mov    %ecx,0x834
    if(p->s.size >= nunits){
 7a2:	e9 53 ff ff ff       	jmp    6fa <malloc+0x2a>
 7a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ae:	00 
 7af:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 7b0:	8b 08                	mov    (%eax),%ecx
 7b2:	89 0a                	mov    %ecx,(%edx)
 7b4:	eb b1                	jmp    767 <malloc+0x97>
