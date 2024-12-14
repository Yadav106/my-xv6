
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	bb 01 00 00 00       	mov    $0x1,%ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 75 08             	mov    0x8(%ebp),%esi
  14:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 21                	jle    3d <main+0x3d>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  for(i=1; i<argc; i++)
  23:	43                   	inc    %ebx
    kill(atoi(argv[i]));
  24:	89 04 24             	mov    %eax,(%esp)
  27:	e8 04 02 00 00       	call   230 <atoi>
  2c:	89 04 24             	mov    %eax,(%esp)
  2f:	e8 9f 02 00 00       	call   2d3 <kill>
  for(i=1; i<argc; i++)
  34:	39 de                	cmp    %ebx,%esi
  36:	75 e8                	jne    20 <main+0x20>
  exit();
  38:	e8 66 02 00 00       	call   2a3 <exit>
    printf(2, "usage: kill pid...\n");
  3d:	c7 44 24 04 08 08 00 	movl   $0x808,0x4(%esp)
  44:	00 
  45:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4c:	e8 0f 04 00 00       	call   460 <printf>
    exit();
  51:	e8 4d 02 00 00       	call   2a3 <exit>
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  61:	31 c0                	xor    %eax,%eax
{
  63:	89 e5                	mov    %esp,%ebp
  65:	53                   	push   %ebx
  66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  77:	40                   	inc    %eax
  78:	84 d2                	test   %dl,%dl
  7a:	75 f4                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7c:	5b                   	pop    %ebx
  7d:	89 c8                	mov    %ecx,%eax
  7f:	5d                   	pop    %ebp
  80:	c3                   	ret
  81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  88:	00 
  89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 15                	jne    b6 <strcmp+0x26>
  a1:	eb 30                	jmp    d3 <strcmp+0x43>
  a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  ac:	8d 4b 01             	lea    0x1(%ebx),%ecx
  af:	42                   	inc    %edx
  while(*p && *p == *q)
  b0:	84 c0                	test   %al,%al
  b2:	74 14                	je     c8 <strcmp+0x38>
  b4:	89 cb                	mov    %ecx,%ebx
  b6:	0f b6 0b             	movzbl (%ebx),%ecx
  b9:	38 c1                	cmp    %al,%cl
  bb:	74 eb                	je     a8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  bd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  be:	29 c8                	sub    %ecx,%eax
}
  c0:	5d                   	pop    %ebp
  c1:	c3                   	ret
  c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  c8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  cc:	31 c0                	xor    %eax,%eax
}
  ce:	5b                   	pop    %ebx
  cf:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  d0:	29 c8                	sub    %ecx,%eax
}
  d2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  d3:	0f b6 0b             	movzbl (%ebx),%ecx
  d6:	31 c0                	xor    %eax,%eax
  d8:	eb e3                	jmp    bd <strcmp+0x2d>
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 3a 00             	cmpb   $0x0,(%edx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 c0                	xor    %eax,%eax
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	40                   	inc    %eax
  f1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  f5:	89 c1                	mov    %eax,%ecx
  f7:	75 f7                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  f9:	5d                   	pop    %ebp
  fa:	89 c8                	mov    %ecx,%eax
  fc:	c3                   	ret
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 101:	31 c9                	xor    %ecx,%ecx
}
 103:	89 c8                	mov    %ecx,%eax
 105:	c3                   	ret
 106:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10d:	00 
 10e:	66 90                	xchg   %ax,%ax

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	5f                   	pop    %edi
 123:	89 d0                	mov    %edx,%eax
 125:	5d                   	pop    %ebp
 126:	c3                   	ret
 127:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12e:	00 
 12f:	90                   	nop

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	75 10                	jne    151 <strchr+0x21>
 141:	eb 1d                	jmp    160 <strchr+0x30>
 143:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 148:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 14c:	40                   	inc    %eax
 14d:	84 d2                	test   %dl,%dl
 14f:	74 0f                	je     160 <strchr+0x30>
    if(*s == c)
 151:	38 d1                	cmp    %dl,%cl
 153:	75 f3                	jne    148 <strchr+0x18>
      return (char*)s;
  return 0;
}
 155:	5d                   	pop    %ebp
 156:	c3                   	ret
 157:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15e:	00 
 15f:	90                   	nop
 160:	5d                   	pop    %ebp
  return 0;
 161:	31 c0                	xor    %eax,%eax
}
 163:	c3                   	ret
 164:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16b:	00 
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 175:	31 f6                	xor    %esi,%esi
{
 177:	53                   	push   %ebx
    cc = read(0, &c, 1);
 178:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 17b:	83 ec 3c             	sub    $0x3c,%esp
 17e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 181:	eb 32                	jmp    1b5 <gets+0x45>
 183:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 188:	89 7c 24 04          	mov    %edi,0x4(%esp)
 18c:	b8 01 00 00 00       	mov    $0x1,%eax
 191:	89 44 24 08          	mov    %eax,0x8(%esp)
 195:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 19c:	e8 1a 01 00 00       	call   2bb <read>
    if(cc < 1)
 1a1:	85 c0                	test   %eax,%eax
 1a3:	7e 19                	jle    1be <gets+0x4e>
      break;
    buf[i++] = c;
 1a5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 1ad:	3c 0a                	cmp    $0xa,%al
 1af:	74 10                	je     1c1 <gets+0x51>
 1b1:	3c 0d                	cmp    $0xd,%al
 1b3:	74 0c                	je     1c1 <gets+0x51>
  for(i=0; i+1 < max; ){
 1b5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1b8:	46                   	inc    %esi
 1b9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1bc:	7c ca                	jl     188 <gets+0x18>
 1be:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 1c1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 1c5:	83 c4 3c             	add    $0x3c,%esp
 1c8:	89 d8                	mov    %ebx,%eax
 1ca:	5b                   	pop    %ebx
 1cb:	5e                   	pop    %esi
 1cc:	5f                   	pop    %edi
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret
 1cf:	90                   	nop

000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d1:	31 c0                	xor    %eax,%eax
{
 1d3:	89 e5                	mov    %esp,%ebp
 1d5:	83 ec 18             	sub    $0x18,%esp
 1d8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1db:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1de:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	89 04 24             	mov    %eax,(%esp)
 1e8:	e8 f6 00 00 00       	call   2e3 <open>
  if(fd < 0)
 1ed:	85 c0                	test   %eax,%eax
 1ef:	78 2f                	js     220 <stat+0x50>
 1f1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1f3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f6:	89 1c 24             	mov    %ebx,(%esp)
 1f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1fd:	e8 f9 00 00 00       	call   2fb <fstat>
  close(fd);
 202:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 205:	89 c6                	mov    %eax,%esi
  close(fd);
 207:	e8 bf 00 00 00       	call   2cb <close>
  return r;
}
 20c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 20f:	89 f0                	mov    %esi,%eax
 211:	8b 75 fc             	mov    -0x4(%ebp),%esi
 214:	89 ec                	mov    %ebp,%esp
 216:	5d                   	pop    %ebp
 217:	c3                   	ret
 218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21f:	00 
    return -1;
 220:	be ff ff ff ff       	mov    $0xffffffff,%esi
 225:	eb e5                	jmp    20c <stat+0x3c>
 227:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22e:	00 
 22f:	90                   	nop

00000230 <atoi>:

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 237:	0f be 02             	movsbl (%edx),%eax
 23a:	88 c1                	mov    %al,%cl
 23c:	80 e9 30             	sub    $0x30,%cl
 23f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 242:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 247:	77 1c                	ja     265 <atoi+0x35>
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 250:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 253:	42                   	inc    %edx
 254:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 258:	0f be 02             	movsbl (%edx),%eax
 25b:	88 c3                	mov    %al,%bl
 25d:	80 eb 30             	sub    $0x30,%bl
 260:	80 fb 09             	cmp    $0x9,%bl
 263:	76 eb                	jbe    250 <atoi+0x20>
  return n;
}
 265:	5b                   	pop    %ebx
 266:	89 c8                	mov    %ecx,%eax
 268:	5d                   	pop    %ebp
 269:	c3                   	ret
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	8b 45 10             	mov    0x10(%ebp),%eax
 277:	56                   	push   %esi
 278:	8b 55 08             	mov    0x8(%ebp),%edx
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 c0                	test   %eax,%eax
 280:	7e 13                	jle    295 <memmove+0x25>
 282:	01 d0                	add    %edx,%eax
  dst = vdst;
 284:	89 d7                	mov    %edx,%edi
 286:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28d:	00 
 28e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 290:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 291:	39 f8                	cmp    %edi,%eax
 293:	75 fb                	jne    290 <memmove+0x20>
  return vdst;
}
 295:	5e                   	pop    %esi
 296:	89 d0                	mov    %edx,%eax
 298:	5f                   	pop    %edi
 299:	5d                   	pop    %ebp
 29a:	c3                   	ret

0000029b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29b:	b8 01 00 00 00       	mov    $0x1,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <exit>:
SYSCALL(exit)
 2a3:	b8 02 00 00 00       	mov    $0x2,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <wait>:
SYSCALL(wait)
 2ab:	b8 03 00 00 00       	mov    $0x3,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <pipe>:
SYSCALL(pipe)
 2b3:	b8 04 00 00 00       	mov    $0x4,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <read>:
SYSCALL(read)
 2bb:	b8 05 00 00 00       	mov    $0x5,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <write>:
SYSCALL(write)
 2c3:	b8 10 00 00 00       	mov    $0x10,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <close>:
SYSCALL(close)
 2cb:	b8 15 00 00 00       	mov    $0x15,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <kill>:
SYSCALL(kill)
 2d3:	b8 06 00 00 00       	mov    $0x6,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <exec>:
SYSCALL(exec)
 2db:	b8 07 00 00 00       	mov    $0x7,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <open>:
SYSCALL(open)
 2e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <mknod>:
SYSCALL(mknod)
 2eb:	b8 11 00 00 00       	mov    $0x11,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <unlink>:
SYSCALL(unlink)
 2f3:	b8 12 00 00 00       	mov    $0x12,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <fstat>:
SYSCALL(fstat)
 2fb:	b8 08 00 00 00       	mov    $0x8,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <link>:
SYSCALL(link)
 303:	b8 13 00 00 00       	mov    $0x13,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <mkdir>:
SYSCALL(mkdir)
 30b:	b8 14 00 00 00       	mov    $0x14,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <chdir>:
SYSCALL(chdir)
 313:	b8 09 00 00 00       	mov    $0x9,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <dup>:
SYSCALL(dup)
 31b:	b8 0a 00 00 00       	mov    $0xa,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <getpid>:
SYSCALL(getpid)
 323:	b8 0b 00 00 00       	mov    $0xb,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <sbrk>:
SYSCALL(sbrk)
 32b:	b8 0c 00 00 00       	mov    $0xc,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <sleep>:
SYSCALL(sleep)
 333:	b8 0d 00 00 00       	mov    $0xd,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <uptime>:
SYSCALL(uptime)
 33b:	b8 0e 00 00 00       	mov    $0xe,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <worldpeace>:
SYSCALL(worldpeace)
 343:	b8 16 00 00 00       	mov    $0x16,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <numberofprocesses>:
SYSCALL(numberofprocesses)
 34b:	b8 17 00 00 00       	mov    $0x17,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <whatsthestatus>:
SYSCALL(whatsthestatus)
 353:	b8 18 00 00 00       	mov    $0x18,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <get_sibling>:
SYSCALL(get_sibling)
 35b:	b8 19 00 00 00       	mov    $0x19,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <spawn>:
SYSCALL(spawn)
 363:	b8 1a 00 00 00       	mov    $0x1a,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <getvasize>:
SYSCALL(getvasize)
 36b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <va2pa>:
SYSCALL(va2pa)
 373:	b8 1c 00 00 00       	mov    $0x1c,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 37b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 383:	b8 1e 00 00 00       	mov    $0x1e,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 38b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <getpasize>:
SYSCALL(getpasize)
 393:	b8 20 00 00 00       	mov    $0x20,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret
 39b:	66 90                	xchg   %ax,%ax
 39d:	66 90                	xchg   %ax,%ax
 39f:	90                   	nop

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	89 cb                	mov    %ecx,%ebx
 3a8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3ab:	89 d1                	mov    %edx,%ecx
{
 3ad:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 3b0:	89 d0                	mov    %edx,%eax
 3b2:	c1 e8 1f             	shr    $0x1f,%eax
 3b5:	84 c0                	test   %al,%al
 3b7:	0f 84 93 00 00 00    	je     450 <printint+0xb0>
 3bd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3c1:	0f 84 89 00 00 00    	je     450 <printint+0xb0>
    x = -xx;
 3c7:	f7 d9                	neg    %ecx
    neg = 1;
 3c9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 3ce:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3d5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3d8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 3db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3e0:	89 c8                	mov    %ecx,%eax
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3e7:	f7 f3                	div    %ebx
 3e9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3ec:	0f b6 92 7c 08 00 00 	movzbl 0x87c(%edx),%edx
 3f3:	8d 47 01             	lea    0x1(%edi),%eax
 3f6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3f9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 3fd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 3ff:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 402:	39 da                	cmp    %ebx,%edx
 404:	73 da                	jae    3e0 <printint+0x40>
  if(neg)
 406:	8b 45 b8             	mov    -0x48(%ebp),%eax
 409:	85 c0                	test   %eax,%eax
 40b:	74 0a                	je     417 <printint+0x77>
    buf[i++] = '-';
 40d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 410:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 415:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 417:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 41a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 41e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 420:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 423:	89 74 24 04          	mov    %esi,0x4(%esp)
 427:	88 45 d7             	mov    %al,-0x29(%ebp)
 42a:	b8 01 00 00 00       	mov    $0x1,%eax
 42f:	89 44 24 08          	mov    %eax,0x8(%esp)
 433:	8b 45 bc             	mov    -0x44(%ebp),%eax
 436:	89 04 24             	mov    %eax,(%esp)
 439:	e8 85 fe ff ff       	call   2c3 <write>
  while(--i >= 0)
 43e:	89 f8                	mov    %edi,%eax
 440:	4f                   	dec    %edi
 441:	39 d8                	cmp    %ebx,%eax
 443:	75 db                	jne    420 <printint+0x80>
}
 445:	83 c4 4c             	add    $0x4c,%esp
 448:	5b                   	pop    %ebx
 449:	5e                   	pop    %esi
 44a:	5f                   	pop    %edi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret
 44d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 450:	31 c0                	xor    %eax,%eax
 452:	e9 77 ff ff ff       	jmp    3ce <printint+0x2e>
 457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45e:	00 
 45f:	90                   	nop

00000460 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 469:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 46c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 46f:	0f b6 13             	movzbl (%ebx),%edx
 472:	43                   	inc    %ebx
 473:	84 d2                	test   %dl,%dl
 475:	74 35                	je     4ac <printf+0x4c>
 477:	8d 45 10             	lea    0x10(%ebp),%eax
 47a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 47d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 480:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 483:	83 f8 25             	cmp    $0x25,%eax
 486:	74 30                	je     4b8 <printf+0x58>
  write(fd, &c, 1);
 488:	89 34 24             	mov    %esi,(%esp)
 48b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 490:	43                   	inc    %ebx
  write(fd, &c, 1);
 491:	89 44 24 08          	mov    %eax,0x8(%esp)
 495:	8d 45 e7             	lea    -0x19(%ebp),%eax
 498:	89 44 24 04          	mov    %eax,0x4(%esp)
 49c:	88 55 e7             	mov    %dl,-0x19(%ebp)
 49f:	e8 1f fe ff ff       	call   2c3 <write>
  for(i = 0; fmt[i]; i++){
 4a4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4a8:	84 d2                	test   %dl,%dl
 4aa:	75 d4                	jne    480 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4ac:	83 c4 3c             	add    $0x3c,%esp
 4af:	5b                   	pop    %ebx
 4b0:	5e                   	pop    %esi
 4b1:	5f                   	pop    %edi
 4b2:	5d                   	pop    %ebp
 4b3:	c3                   	ret
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 4b8:	0f b6 13             	movzbl (%ebx),%edx
 4bb:	84 d2                	test   %dl,%dl
 4bd:	74 ed                	je     4ac <printf+0x4c>
    c = fmt[i] & 0xff;
 4bf:	80 fa 25             	cmp    $0x25,%dl
 4c2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 4c5:	0f 84 75 01 00 00    	je     640 <printf+0x1e0>
 4cb:	83 e8 63             	sub    $0x63,%eax
 4ce:	83 f8 15             	cmp    $0x15,%eax
 4d1:	77 0d                	ja     4e0 <printf+0x80>
 4d3:	ff 24 85 24 08 00 00 	jmp    *0x824(,%eax,4)
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4e0:	89 34 24             	mov    %esi,(%esp)
 4e3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4e6:	b8 01 00 00 00       	mov    $0x1,%eax
 4eb:	89 44 24 08          	mov    %eax,0x8(%esp)
 4ef:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4f3:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 4f6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4fa:	e8 c4 fd ff ff       	call   2c3 <write>
        putc(fd, c);
 4ff:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 503:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 506:	ba 01 00 00 00       	mov    $0x1,%edx
 50b:	89 54 24 08          	mov    %edx,0x8(%esp)
 50f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 513:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 516:	89 34 24             	mov    %esi,(%esp)
 519:	e8 a5 fd ff ff       	call   2c3 <write>
  for(i = 0; fmt[i]; i++){
 51e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 522:	84 d2                	test   %dl,%dl
 524:	0f 85 56 ff ff ff    	jne    480 <printf+0x20>
}
 52a:	83 c4 3c             	add    $0x3c,%esp
 52d:	5b                   	pop    %ebx
 52e:	5e                   	pop    %esi
 52f:	5f                   	pop    %edi
 530:	5d                   	pop    %ebp
 531:	c3                   	ret
 532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 538:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 53b:	b9 10 00 00 00       	mov    $0x10,%ecx
 540:	8b 17                	mov    (%edi),%edx
 542:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 549:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 54c:	89 f0                	mov    %esi,%eax
 54e:	e8 4d fe ff ff       	call   3a0 <printint>
  for(i = 0; fmt[i]; i++){
 553:	83 c3 02             	add    $0x2,%ebx
        ap++;
 556:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 559:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 55d:	84 d2                	test   %dl,%dl
 55f:	0f 85 1b ff ff ff    	jne    480 <printf+0x20>
}
 565:	83 c4 3c             	add    $0x3c,%esp
 568:	5b                   	pop    %ebx
 569:	5e                   	pop    %esi
 56a:	5f                   	pop    %edi
 56b:	5d                   	pop    %ebp
 56c:	c3                   	ret
 56d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 570:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 573:	8b 01                	mov    (%ecx),%eax
        ap++;
 575:	83 c1 04             	add    $0x4,%ecx
 578:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 57b:	85 c0                	test   %eax,%eax
 57d:	0f 84 d5 00 00 00    	je     658 <printf+0x1f8>
        while(*s != 0){
 583:	0f b6 10             	movzbl (%eax),%edx
 586:	84 d2                	test   %dl,%dl
 588:	74 39                	je     5c3 <printf+0x163>
 58a:	89 c7                	mov    %eax,%edi
 58c:	88 d0                	mov    %dl,%al
 58e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 591:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 594:	89 fb                	mov    %edi,%ebx
 596:	89 cf                	mov    %ecx,%edi
 598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59f:	00 
          putc(fd, *s);
 5a0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5a8:	43                   	inc    %ebx
  write(fd, &c, 1);
 5a9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5ad:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5b1:	89 34 24             	mov    %esi,(%esp)
 5b4:	e8 0a fd ff ff       	call   2c3 <write>
        while(*s != 0){
 5b9:	0f b6 03             	movzbl (%ebx),%eax
 5bc:	84 c0                	test   %al,%al
 5be:	75 e0                	jne    5a0 <printf+0x140>
 5c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5c3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5c7:	83 c3 02             	add    $0x2,%ebx
 5ca:	84 d2                	test   %dl,%dl
 5cc:	0f 85 ae fe ff ff    	jne    480 <printf+0x20>
 5d2:	e9 d5 fe ff ff       	jmp    4ac <printf+0x4c>
 5d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5de:	00 
 5df:	90                   	nop
        printint(fd, *ap, 10, 1);
 5e0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5e8:	8b 17                	mov    (%edi),%edx
 5ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5f1:	e9 53 ff ff ff       	jmp    549 <printf+0xe9>
 5f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5fd:	00 
 5fe:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 600:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 603:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 608:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 60b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 60d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 611:	8d 7d e7             	lea    -0x19(%ebp),%edi
 614:	89 7c 24 04          	mov    %edi,0x4(%esp)
 618:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 61b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 61e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 622:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 625:	e8 99 fc ff ff       	call   2c3 <write>
        ap++;
 62a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 62e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 632:	84 d2                	test   %dl,%dl
 634:	0f 85 46 fe ff ff    	jne    480 <printf+0x20>
 63a:	e9 6d fe ff ff       	jmp    4ac <printf+0x4c>
 63f:	90                   	nop
        putc(fd, c);
 640:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 643:	8d 7d e7             	lea    -0x19(%ebp),%edi
 646:	b9 01 00 00 00       	mov    $0x1,%ecx
 64b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 64f:	e9 bb fe ff ff       	jmp    50f <printf+0xaf>
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 658:	bf 1c 08 00 00       	mov    $0x81c,%edi
 65d:	b0 28                	mov    $0x28,%al
 65f:	e9 2a ff ff ff       	jmp    58e <printf+0x12e>
 664:	66 90                	xchg   %ax,%ax
 666:	66 90                	xchg   %ax,%ax
 668:	66 90                	xchg   %ax,%ax
 66a:	66 90                	xchg   %ax,%ax
 66c:	66 90                	xchg   %ax,%ax
 66e:	66 90                	xchg   %ax,%ax

00000670 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 670:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 671:	a1 90 08 00 00       	mov    0x890,%eax
{
 676:	89 e5                	mov    %esp,%ebp
 678:	57                   	push   %edi
 679:	56                   	push   %esi
 67a:	53                   	push   %ebx
 67b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 67e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 688:	00 
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 690:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 692:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 694:	39 ca                	cmp    %ecx,%edx
 696:	73 30                	jae    6c8 <free+0x58>
 698:	39 c1                	cmp    %eax,%ecx
 69a:	72 04                	jb     6a0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69c:	39 c2                	cmp    %eax,%edx
 69e:	72 f0                	jb     690 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6a3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6a6:	39 f8                	cmp    %edi,%eax
 6a8:	74 36                	je     6e0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6aa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6ad:	8b 42 04             	mov    0x4(%edx),%eax
 6b0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6b3:	39 f1                	cmp    %esi,%ecx
 6b5:	74 42                	je     6f9 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6b7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6b9:	5b                   	pop    %ebx
  freep = p;
 6ba:	89 15 90 08 00 00    	mov    %edx,0x890
}
 6c0:	5e                   	pop    %esi
 6c1:	5f                   	pop    %edi
 6c2:	5d                   	pop    %ebp
 6c3:	c3                   	ret
 6c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c8:	39 c2                	cmp    %eax,%edx
 6ca:	72 c4                	jb     690 <free+0x20>
 6cc:	39 c1                	cmp    %eax,%ecx
 6ce:	73 c0                	jae    690 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 6d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6d6:	39 f8                	cmp    %edi,%eax
 6d8:	75 d0                	jne    6aa <free+0x3a>
 6da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 6e0:	8b 78 04             	mov    0x4(%eax),%edi
 6e3:	01 fe                	add    %edi,%esi
 6e5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e8:	8b 02                	mov    (%edx),%eax
 6ea:	8b 00                	mov    (%eax),%eax
 6ec:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ef:	8b 42 04             	mov    0x4(%edx),%eax
 6f2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6f5:	39 f1                	cmp    %esi,%ecx
 6f7:	75 be                	jne    6b7 <free+0x47>
  freep = p;
 6f9:	89 15 90 08 00 00    	mov    %edx,0x890
    p->s.size += bp->s.size;
 6ff:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 702:	01 c8                	add    %ecx,%eax
 704:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 707:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 70a:	89 0a                	mov    %ecx,(%edx)
}
 70c:	5b                   	pop    %ebx
 70d:	5e                   	pop    %esi
 70e:	5f                   	pop    %edi
 70f:	5d                   	pop    %ebp
 710:	c3                   	ret
 711:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 718:	00 
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 90 08 00 00    	mov    0x890,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 78 07             	lea    0x7(%eax),%edi
 735:	c1 ef 03             	shr    $0x3,%edi
 738:	47                   	inc    %edi
  if((prevp = freep) == 0){
 739:	85 d2                	test   %edx,%edx
 73b:	0f 84 8f 00 00 00    	je     7d0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 741:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 743:	8b 48 04             	mov    0x4(%eax),%ecx
 746:	39 f9                	cmp    %edi,%ecx
 748:	73 5e                	jae    7a8 <malloc+0x88>
  if(nu < 4096)
 74a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 74f:	39 df                	cmp    %ebx,%edi
 751:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 754:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 75b:	eb 0c                	jmp    769 <malloc+0x49>
 75d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 760:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 762:	8b 48 04             	mov    0x4(%eax),%ecx
 765:	39 f9                	cmp    %edi,%ecx
 767:	73 3f                	jae    7a8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 769:	39 05 90 08 00 00    	cmp    %eax,0x890
 76f:	89 c2                	mov    %eax,%edx
 771:	75 ed                	jne    760 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 773:	89 34 24             	mov    %esi,(%esp)
 776:	e8 b0 fb ff ff       	call   32b <sbrk>
  if(p == (char*)-1)
 77b:	83 f8 ff             	cmp    $0xffffffff,%eax
 77e:	74 18                	je     798 <malloc+0x78>
  hp->s.size = nu;
 780:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 783:	83 c0 08             	add    $0x8,%eax
 786:	89 04 24             	mov    %eax,(%esp)
 789:	e8 e2 fe ff ff       	call   670 <free>
  return freep;
 78e:	8b 15 90 08 00 00    	mov    0x890,%edx
      if((p = morecore(nunits)) == 0)
 794:	85 d2                	test   %edx,%edx
 796:	75 c8                	jne    760 <malloc+0x40>
        return 0;
  }
}
 798:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 79b:	31 c0                	xor    %eax,%eax
}
 79d:	5b                   	pop    %ebx
 79e:	5e                   	pop    %esi
 79f:	5f                   	pop    %edi
 7a0:	5d                   	pop    %ebp
 7a1:	c3                   	ret
 7a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7a8:	39 cf                	cmp    %ecx,%edi
 7aa:	74 54                	je     800 <malloc+0xe0>
        p->s.size -= nunits;
 7ac:	29 f9                	sub    %edi,%ecx
 7ae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7b4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7b7:	89 15 90 08 00 00    	mov    %edx,0x890
}
 7bd:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 7c0:	83 c0 08             	add    $0x8,%eax
}
 7c3:	5b                   	pop    %ebx
 7c4:	5e                   	pop    %esi
 7c5:	5f                   	pop    %edi
 7c6:	5d                   	pop    %ebp
 7c7:	c3                   	ret
 7c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7cf:	00 
    base.s.ptr = freep = prevp = &base;
 7d0:	b8 94 08 00 00       	mov    $0x894,%eax
 7d5:	ba 94 08 00 00       	mov    $0x894,%edx
 7da:	a3 90 08 00 00       	mov    %eax,0x890
    base.s.size = 0;
 7df:	31 c9                	xor    %ecx,%ecx
 7e1:	b8 94 08 00 00       	mov    $0x894,%eax
    base.s.ptr = freep = prevp = &base;
 7e6:	89 15 94 08 00 00    	mov    %edx,0x894
    base.s.size = 0;
 7ec:	89 0d 98 08 00 00    	mov    %ecx,0x898
    if(p->s.size >= nunits){
 7f2:	e9 53 ff ff ff       	jmp    74a <malloc+0x2a>
 7f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7fe:	00 
 7ff:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 800:	8b 08                	mov    (%eax),%ecx
 802:	89 0a                	mov    %ecx,(%edx)
 804:	eb b1                	jmp    7b7 <malloc+0x97>
