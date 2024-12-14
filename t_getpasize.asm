
_t_getpasize:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
    int process_size_before_sbrk = getpasize(getpid());
   a:	e8 74 03 00 00       	call   383 <getpid>
   f:	89 04 24             	mov    %eax,(%esp)
  12:	e8 dc 03 00 00       	call   3f3 <getpasize>
  17:	89 c3                	mov    %eax,%ebx
    printf(1, "Virtual Address Space of process: %d Pages\n", (uint)getvasize(getpid()) / 4096);
  19:	e8 65 03 00 00       	call   383 <getpid>
  1e:	89 04 24             	mov    %eax,(%esp)
  21:	e8 a5 03 00 00       	call   3cb <getvasize>
  26:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  2d:	c1 e8 0c             	shr    $0xc,%eax
  30:	89 44 24 08          	mov    %eax,0x8(%esp)
  34:	b8 68 08 00 00       	mov    $0x868,%eax
  39:	89 44 24 04          	mov    %eax,0x4(%esp)
  3d:	e8 7e 04 00 00       	call   4c0 <printf>
    printf(1, "Number of physical pages allocated to process: %d Pages\n", process_size_before_sbrk);
  42:	ba 94 08 00 00       	mov    $0x894,%edx
  47:	89 54 24 04          	mov    %edx,0x4(%esp)
  4b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  4f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  56:	e8 65 04 00 00       	call   4c0 <printf>
    sbrk(11 * 4096); // Allocating 10 Physical Pages to process
  5b:	c7 04 24 00 b0 00 00 	movl   $0xb000,(%esp)
  62:	e8 24 03 00 00       	call   38b <sbrk>
    int process_size_after_sbrk = getpasize(getpid());
  67:	e8 17 03 00 00       	call   383 <getpid>
  6c:	89 04 24             	mov    %eax,(%esp)
  6f:	e8 7f 03 00 00       	call   3f3 <getpasize>
  74:	89 c3                	mov    %eax,%ebx
    printf(1, "Virtual Address Space of process after sbrk: %d Pages\n", (uint)getvasize(getpid()) / 4096);
  76:	e8 08 03 00 00       	call   383 <getpid>
  7b:	89 04 24             	mov    %eax,(%esp)
  7e:	e8 48 03 00 00       	call   3cb <getvasize>
  83:	b9 d0 08 00 00       	mov    $0x8d0,%ecx
  88:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  93:	c1 e8 0c             	shr    $0xc,%eax
  96:	89 44 24 08          	mov    %eax,0x8(%esp)
  9a:	e8 21 04 00 00       	call   4c0 <printf>
    printf(1, "Number of physical pages allocated to process after sbrk: %d Pages\n", process_size_after_sbrk);
  9f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  a3:	bb 08 09 00 00       	mov    $0x908,%ebx
  a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b3:	e8 08 04 00 00       	call   4c0 <printf>
    exit();
  b8:	e8 46 02 00 00       	call   303 <exit>
  bd:	66 90                	xchg   %ax,%ax
  bf:	90                   	nop

000000c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  c0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  c1:	31 c0                	xor    %eax,%eax
{
  c3:	89 e5                	mov    %esp,%ebp
  c5:	53                   	push   %ebx
  c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  d7:	40                   	inc    %eax
  d8:	84 d2                	test   %dl,%dl
  da:	75 f4                	jne    d0 <strcpy+0x10>
    ;
  return os;
}
  dc:	5b                   	pop    %ebx
  dd:	89 c8                	mov    %ecx,%eax
  df:	5d                   	pop    %ebp
  e0:	c3                   	ret
  e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  e8:	00 
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
  f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  fa:	0f b6 02             	movzbl (%edx),%eax
  fd:	84 c0                	test   %al,%al
  ff:	75 15                	jne    116 <strcmp+0x26>
 101:	eb 30                	jmp    133 <strcmp+0x43>
 103:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 108:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 10c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 10f:	42                   	inc    %edx
  while(*p && *p == *q)
 110:	84 c0                	test   %al,%al
 112:	74 14                	je     128 <strcmp+0x38>
 114:	89 cb                	mov    %ecx,%ebx
 116:	0f b6 0b             	movzbl (%ebx),%ecx
 119:	38 c1                	cmp    %al,%cl
 11b:	74 eb                	je     108 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 11d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 11e:	29 c8                	sub    %ecx,%eax
}
 120:	5d                   	pop    %ebp
 121:	c3                   	ret
 122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 128:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 12c:	31 c0                	xor    %eax,%eax
}
 12e:	5b                   	pop    %ebx
 12f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 130:	29 c8                	sub    %ecx,%eax
}
 132:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 133:	0f b6 0b             	movzbl (%ebx),%ecx
 136:	31 c0                	xor    %eax,%eax
 138:	eb e3                	jmp    11d <strcmp+0x2d>
 13a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000140 <strlen>:

uint
strlen(const char *s)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 146:	80 3a 00             	cmpb   $0x0,(%edx)
 149:	74 15                	je     160 <strlen+0x20>
 14b:	31 c0                	xor    %eax,%eax
 14d:	8d 76 00             	lea    0x0(%esi),%esi
 150:	40                   	inc    %eax
 151:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 155:	89 c1                	mov    %eax,%ecx
 157:	75 f7                	jne    150 <strlen+0x10>
    ;
  return n;
}
 159:	5d                   	pop    %ebp
 15a:	89 c8                	mov    %ecx,%eax
 15c:	c3                   	ret
 15d:	8d 76 00             	lea    0x0(%esi),%esi
 160:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 161:	31 c9                	xor    %ecx,%ecx
}
 163:	89 c8                	mov    %ecx,%eax
 165:	c3                   	ret
 166:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16d:	00 
 16e:	66 90                	xchg   %ax,%ax

00000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 55 08             	mov    0x8(%ebp),%edx
 176:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 177:	8b 4d 10             	mov    0x10(%ebp),%ecx
 17a:	8b 45 0c             	mov    0xc(%ebp),%eax
 17d:	89 d7                	mov    %edx,%edi
 17f:	fc                   	cld
 180:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 182:	5f                   	pop    %edi
 183:	89 d0                	mov    %edx,%eax
 185:	5d                   	pop    %ebp
 186:	c3                   	ret
 187:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18e:	00 
 18f:	90                   	nop

00000190 <strchr>:

char*
strchr(const char *s, char c)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 19a:	0f b6 10             	movzbl (%eax),%edx
 19d:	84 d2                	test   %dl,%dl
 19f:	75 10                	jne    1b1 <strchr+0x21>
 1a1:	eb 1d                	jmp    1c0 <strchr+0x30>
 1a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1a8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1ac:	40                   	inc    %eax
 1ad:	84 d2                	test   %dl,%dl
 1af:	74 0f                	je     1c0 <strchr+0x30>
    if(*s == c)
 1b1:	38 d1                	cmp    %dl,%cl
 1b3:	75 f3                	jne    1a8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret
 1b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1be:	00 
 1bf:	90                   	nop
 1c0:	5d                   	pop    %ebp
  return 0;
 1c1:	31 c0                	xor    %eax,%eax
}
 1c3:	c3                   	ret
 1c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cb:	00 
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001d0 <gets>:

char*
gets(char *buf, int max)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d5:	31 f6                	xor    %esi,%esi
{
 1d7:	53                   	push   %ebx
    cc = read(0, &c, 1);
 1d8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1db:	83 ec 3c             	sub    $0x3c,%esp
 1de:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 1e1:	eb 32                	jmp    215 <gets+0x45>
 1e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 1e8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ec:	b8 01 00 00 00       	mov    $0x1,%eax
 1f1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1f5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1fc:	e8 1a 01 00 00       	call   31b <read>
    if(cc < 1)
 201:	85 c0                	test   %eax,%eax
 203:	7e 19                	jle    21e <gets+0x4e>
      break;
    buf[i++] = c;
 205:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 209:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 20d:	3c 0a                	cmp    $0xa,%al
 20f:	74 10                	je     221 <gets+0x51>
 211:	3c 0d                	cmp    $0xd,%al
 213:	74 0c                	je     221 <gets+0x51>
  for(i=0; i+1 < max; ){
 215:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 218:	46                   	inc    %esi
 219:	3b 75 0c             	cmp    0xc(%ebp),%esi
 21c:	7c ca                	jl     1e8 <gets+0x18>
 21e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 221:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 225:	83 c4 3c             	add    $0x3c,%esp
 228:	89 d8                	mov    %ebx,%eax
 22a:	5b                   	pop    %ebx
 22b:	5e                   	pop    %esi
 22c:	5f                   	pop    %edi
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret
 22f:	90                   	nop

00000230 <stat>:

int
stat(const char *n, struct stat *st)
{
 230:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 231:	31 c0                	xor    %eax,%eax
{
 233:	89 e5                	mov    %esp,%ebp
 235:	83 ec 18             	sub    $0x18,%esp
 238:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 23b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 23e:	89 44 24 04          	mov    %eax,0x4(%esp)
 242:	8b 45 08             	mov    0x8(%ebp),%eax
 245:	89 04 24             	mov    %eax,(%esp)
 248:	e8 f6 00 00 00       	call   343 <open>
  if(fd < 0)
 24d:	85 c0                	test   %eax,%eax
 24f:	78 2f                	js     280 <stat+0x50>
 251:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 253:	8b 45 0c             	mov    0xc(%ebp),%eax
 256:	89 1c 24             	mov    %ebx,(%esp)
 259:	89 44 24 04          	mov    %eax,0x4(%esp)
 25d:	e8 f9 00 00 00       	call   35b <fstat>
  close(fd);
 262:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 265:	89 c6                	mov    %eax,%esi
  close(fd);
 267:	e8 bf 00 00 00       	call   32b <close>
  return r;
}
 26c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 26f:	89 f0                	mov    %esi,%eax
 271:	8b 75 fc             	mov    -0x4(%ebp),%esi
 274:	89 ec                	mov    %ebp,%esp
 276:	5d                   	pop    %ebp
 277:	c3                   	ret
 278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27f:	00 
    return -1;
 280:	be ff ff ff ff       	mov    $0xffffffff,%esi
 285:	eb e5                	jmp    26c <stat+0x3c>
 287:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28e:	00 
 28f:	90                   	nop

00000290 <atoi>:

int
atoi(const char *s)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	53                   	push   %ebx
 294:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 297:	0f be 02             	movsbl (%edx),%eax
 29a:	88 c1                	mov    %al,%cl
 29c:	80 e9 30             	sub    $0x30,%cl
 29f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2a2:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2a7:	77 1c                	ja     2c5 <atoi+0x35>
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2b0:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2b3:	42                   	inc    %edx
 2b4:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2b8:	0f be 02             	movsbl (%edx),%eax
 2bb:	88 c3                	mov    %al,%bl
 2bd:	80 eb 30             	sub    $0x30,%bl
 2c0:	80 fb 09             	cmp    $0x9,%bl
 2c3:	76 eb                	jbe    2b0 <atoi+0x20>
  return n;
}
 2c5:	5b                   	pop    %ebx
 2c6:	89 c8                	mov    %ecx,%eax
 2c8:	5d                   	pop    %ebp
 2c9:	c3                   	ret
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	8b 45 10             	mov    0x10(%ebp),%eax
 2d7:	56                   	push   %esi
 2d8:	8b 55 08             	mov    0x8(%ebp),%edx
 2db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2de:	85 c0                	test   %eax,%eax
 2e0:	7e 13                	jle    2f5 <memmove+0x25>
 2e2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2e4:	89 d7                	mov    %edx,%edi
 2e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ed:	00 
 2ee:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2f0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2f1:	39 f8                	cmp    %edi,%eax
 2f3:	75 fb                	jne    2f0 <memmove+0x20>
  return vdst;
}
 2f5:	5e                   	pop    %esi
 2f6:	89 d0                	mov    %edx,%eax
 2f8:	5f                   	pop    %edi
 2f9:	5d                   	pop    %ebp
 2fa:	c3                   	ret

000002fb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2fb:	b8 01 00 00 00       	mov    $0x1,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <exit>:
SYSCALL(exit)
 303:	b8 02 00 00 00       	mov    $0x2,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <wait>:
SYSCALL(wait)
 30b:	b8 03 00 00 00       	mov    $0x3,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <pipe>:
SYSCALL(pipe)
 313:	b8 04 00 00 00       	mov    $0x4,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <read>:
SYSCALL(read)
 31b:	b8 05 00 00 00       	mov    $0x5,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <write>:
SYSCALL(write)
 323:	b8 10 00 00 00       	mov    $0x10,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <close>:
SYSCALL(close)
 32b:	b8 15 00 00 00       	mov    $0x15,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <kill>:
SYSCALL(kill)
 333:	b8 06 00 00 00       	mov    $0x6,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <exec>:
SYSCALL(exec)
 33b:	b8 07 00 00 00       	mov    $0x7,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <open>:
SYSCALL(open)
 343:	b8 0f 00 00 00       	mov    $0xf,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <mknod>:
SYSCALL(mknod)
 34b:	b8 11 00 00 00       	mov    $0x11,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <unlink>:
SYSCALL(unlink)
 353:	b8 12 00 00 00       	mov    $0x12,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <fstat>:
SYSCALL(fstat)
 35b:	b8 08 00 00 00       	mov    $0x8,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <link>:
SYSCALL(link)
 363:	b8 13 00 00 00       	mov    $0x13,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <mkdir>:
SYSCALL(mkdir)
 36b:	b8 14 00 00 00       	mov    $0x14,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <chdir>:
SYSCALL(chdir)
 373:	b8 09 00 00 00       	mov    $0x9,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <dup>:
SYSCALL(dup)
 37b:	b8 0a 00 00 00       	mov    $0xa,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <getpid>:
SYSCALL(getpid)
 383:	b8 0b 00 00 00       	mov    $0xb,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <sbrk>:
SYSCALL(sbrk)
 38b:	b8 0c 00 00 00       	mov    $0xc,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <sleep>:
SYSCALL(sleep)
 393:	b8 0d 00 00 00       	mov    $0xd,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <uptime>:
SYSCALL(uptime)
 39b:	b8 0e 00 00 00       	mov    $0xe,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <worldpeace>:
SYSCALL(worldpeace)
 3a3:	b8 16 00 00 00       	mov    $0x16,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <numberofprocesses>:
SYSCALL(numberofprocesses)
 3ab:	b8 17 00 00 00       	mov    $0x17,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <whatsthestatus>:
SYSCALL(whatsthestatus)
 3b3:	b8 18 00 00 00       	mov    $0x18,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <get_sibling>:
SYSCALL(get_sibling)
 3bb:	b8 19 00 00 00       	mov    $0x19,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <spawn>:
SYSCALL(spawn)
 3c3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <getvasize>:
SYSCALL(getvasize)
 3cb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <va2pa>:
SYSCALL(va2pa)
 3d3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 3db:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 3e3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 3eb:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <getpasize>:
SYSCALL(getpasize)
 3f3:	b8 20 00 00 00       	mov    $0x20,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	89 cb                	mov    %ecx,%ebx
 408:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 40b:	89 d1                	mov    %edx,%ecx
{
 40d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 410:	89 d0                	mov    %edx,%eax
 412:	c1 e8 1f             	shr    $0x1f,%eax
 415:	84 c0                	test   %al,%al
 417:	0f 84 93 00 00 00    	je     4b0 <printint+0xb0>
 41d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 421:	0f 84 89 00 00 00    	je     4b0 <printint+0xb0>
    x = -xx;
 427:	f7 d9                	neg    %ecx
    neg = 1;
 429:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 42e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 435:	8d 75 d7             	lea    -0x29(%ebp),%esi
 438:	89 45 b8             	mov    %eax,-0x48(%ebp)
 43b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 440:	89 c8                	mov    %ecx,%eax
 442:	31 d2                	xor    %edx,%edx
 444:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 447:	f7 f3                	div    %ebx
 449:	89 45 c0             	mov    %eax,-0x40(%ebp)
 44c:	0f b6 92 ac 09 00 00 	movzbl 0x9ac(%edx),%edx
 453:	8d 47 01             	lea    0x1(%edi),%eax
 456:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 459:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 45d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 45f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 462:	39 da                	cmp    %ebx,%edx
 464:	73 da                	jae    440 <printint+0x40>
  if(neg)
 466:	8b 45 b8             	mov    -0x48(%ebp),%eax
 469:	85 c0                	test   %eax,%eax
 46b:	74 0a                	je     477 <printint+0x77>
    buf[i++] = '-';
 46d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 470:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 475:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 477:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 47a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 47e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 480:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 483:	89 74 24 04          	mov    %esi,0x4(%esp)
 487:	88 45 d7             	mov    %al,-0x29(%ebp)
 48a:	b8 01 00 00 00       	mov    $0x1,%eax
 48f:	89 44 24 08          	mov    %eax,0x8(%esp)
 493:	8b 45 bc             	mov    -0x44(%ebp),%eax
 496:	89 04 24             	mov    %eax,(%esp)
 499:	e8 85 fe ff ff       	call   323 <write>
  while(--i >= 0)
 49e:	89 f8                	mov    %edi,%eax
 4a0:	4f                   	dec    %edi
 4a1:	39 d8                	cmp    %ebx,%eax
 4a3:	75 db                	jne    480 <printint+0x80>
}
 4a5:	83 c4 4c             	add    $0x4c,%esp
 4a8:	5b                   	pop    %ebx
 4a9:	5e                   	pop    %esi
 4aa:	5f                   	pop    %edi
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 4b0:	31 c0                	xor    %eax,%eax
 4b2:	e9 77 ff ff ff       	jmp    42e <printint+0x2e>
 4b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4be:	00 
 4bf:	90                   	nop

000004c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4cc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4cf:	0f b6 13             	movzbl (%ebx),%edx
 4d2:	43                   	inc    %ebx
 4d3:	84 d2                	test   %dl,%dl
 4d5:	74 35                	je     50c <printf+0x4c>
 4d7:	8d 45 10             	lea    0x10(%ebp),%eax
 4da:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 4e0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 4e3:	83 f8 25             	cmp    $0x25,%eax
 4e6:	74 30                	je     518 <printf+0x58>
  write(fd, &c, 1);
 4e8:	89 34 24             	mov    %esi,(%esp)
 4eb:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 4f0:	43                   	inc    %ebx
  write(fd, &c, 1);
 4f1:	89 44 24 08          	mov    %eax,0x8(%esp)
 4f5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fc:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4ff:	e8 1f fe ff ff       	call   323 <write>
  for(i = 0; fmt[i]; i++){
 504:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 508:	84 d2                	test   %dl,%dl
 50a:	75 d4                	jne    4e0 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 50c:	83 c4 3c             	add    $0x3c,%esp
 50f:	5b                   	pop    %ebx
 510:	5e                   	pop    %esi
 511:	5f                   	pop    %edi
 512:	5d                   	pop    %ebp
 513:	c3                   	ret
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 518:	0f b6 13             	movzbl (%ebx),%edx
 51b:	84 d2                	test   %dl,%dl
 51d:	74 ed                	je     50c <printf+0x4c>
    c = fmt[i] & 0xff;
 51f:	80 fa 25             	cmp    $0x25,%dl
 522:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 525:	0f 84 75 01 00 00    	je     6a0 <printf+0x1e0>
 52b:	83 e8 63             	sub    $0x63,%eax
 52e:	83 f8 15             	cmp    $0x15,%eax
 531:	77 0d                	ja     540 <printf+0x80>
 533:	ff 24 85 54 09 00 00 	jmp    *0x954(,%eax,4)
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 540:	89 34 24             	mov    %esi,(%esp)
 543:	8d 7d e7             	lea    -0x19(%ebp),%edi
 546:	b8 01 00 00 00       	mov    $0x1,%eax
 54b:	89 44 24 08          	mov    %eax,0x8(%esp)
 54f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 553:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 556:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 55a:	e8 c4 fd ff ff       	call   323 <write>
        putc(fd, c);
 55f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 563:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 566:	ba 01 00 00 00       	mov    $0x1,%edx
 56b:	89 54 24 08          	mov    %edx,0x8(%esp)
 56f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 573:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 576:	89 34 24             	mov    %esi,(%esp)
 579:	e8 a5 fd ff ff       	call   323 <write>
  for(i = 0; fmt[i]; i++){
 57e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 582:	84 d2                	test   %dl,%dl
 584:	0f 85 56 ff ff ff    	jne    4e0 <printf+0x20>
}
 58a:	83 c4 3c             	add    $0x3c,%esp
 58d:	5b                   	pop    %ebx
 58e:	5e                   	pop    %esi
 58f:	5f                   	pop    %edi
 590:	5d                   	pop    %ebp
 591:	c3                   	ret
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 598:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 59b:	b9 10 00 00 00       	mov    $0x10,%ecx
 5a0:	8b 17                	mov    (%edi),%edx
 5a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 5a9:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 5ac:	89 f0                	mov    %esi,%eax
 5ae:	e8 4d fe ff ff       	call   400 <printint>
  for(i = 0; fmt[i]; i++){
 5b3:	83 c3 02             	add    $0x2,%ebx
        ap++;
 5b6:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5b9:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5bd:	84 d2                	test   %dl,%dl
 5bf:	0f 85 1b ff ff ff    	jne    4e0 <printf+0x20>
}
 5c5:	83 c4 3c             	add    $0x3c,%esp
 5c8:	5b                   	pop    %ebx
 5c9:	5e                   	pop    %esi
 5ca:	5f                   	pop    %edi
 5cb:	5d                   	pop    %ebp
 5cc:	c3                   	ret
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 5d0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 5d3:	8b 01                	mov    (%ecx),%eax
        ap++;
 5d5:	83 c1 04             	add    $0x4,%ecx
 5d8:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 5db:	85 c0                	test   %eax,%eax
 5dd:	0f 84 d5 00 00 00    	je     6b8 <printf+0x1f8>
        while(*s != 0){
 5e3:	0f b6 10             	movzbl (%eax),%edx
 5e6:	84 d2                	test   %dl,%dl
 5e8:	74 39                	je     623 <printf+0x163>
 5ea:	89 c7                	mov    %eax,%edi
 5ec:	88 d0                	mov    %dl,%al
 5ee:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5f1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5f4:	89 fb                	mov    %edi,%ebx
 5f6:	89 cf                	mov    %ecx,%edi
 5f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ff:	00 
          putc(fd, *s);
 600:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 603:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 608:	43                   	inc    %ebx
  write(fd, &c, 1);
 609:	89 44 24 08          	mov    %eax,0x8(%esp)
 60d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 611:	89 34 24             	mov    %esi,(%esp)
 614:	e8 0a fd ff ff       	call   323 <write>
        while(*s != 0){
 619:	0f b6 03             	movzbl (%ebx),%eax
 61c:	84 c0                	test   %al,%al
 61e:	75 e0                	jne    600 <printf+0x140>
 620:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 623:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 627:	83 c3 02             	add    $0x2,%ebx
 62a:	84 d2                	test   %dl,%dl
 62c:	0f 85 ae fe ff ff    	jne    4e0 <printf+0x20>
 632:	e9 d5 fe ff ff       	jmp    50c <printf+0x4c>
 637:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 63e:	00 
 63f:	90                   	nop
        printint(fd, *ap, 10, 1);
 640:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 643:	b9 0a 00 00 00       	mov    $0xa,%ecx
 648:	8b 17                	mov    (%edi),%edx
 64a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 651:	e9 53 ff ff ff       	jmp    5a9 <printf+0xe9>
 656:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 65d:	00 
 65e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 660:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 663:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 668:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 66b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 66d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 671:	8d 7d e7             	lea    -0x19(%ebp),%edi
 674:	89 7c 24 04          	mov    %edi,0x4(%esp)
 678:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 67b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 67e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 682:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 685:	e8 99 fc ff ff       	call   323 <write>
        ap++;
 68a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 68e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 692:	84 d2                	test   %dl,%dl
 694:	0f 85 46 fe ff ff    	jne    4e0 <printf+0x20>
 69a:	e9 6d fe ff ff       	jmp    50c <printf+0x4c>
 69f:	90                   	nop
        putc(fd, c);
 6a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 6a3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 6a6:	b9 01 00 00 00       	mov    $0x1,%ecx
 6ab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 6af:	e9 bb fe ff ff       	jmp    56f <printf+0xaf>
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 6b8:	bf 4c 09 00 00       	mov    $0x94c,%edi
 6bd:	b0 28                	mov    $0x28,%al
 6bf:	e9 2a ff ff ff       	jmp    5ee <printf+0x12e>
 6c4:	66 90                	xchg   %ax,%ax
 6c6:	66 90                	xchg   %ax,%ax
 6c8:	66 90                	xchg   %ax,%ax
 6ca:	66 90                	xchg   %ax,%ax
 6cc:	66 90                	xchg   %ax,%ax
 6ce:	66 90                	xchg   %ax,%ax

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	a1 c0 09 00 00       	mov    0x9c0,%eax
{
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6e8:	00 
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6f0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f4:	39 ca                	cmp    %ecx,%edx
 6f6:	73 30                	jae    728 <free+0x58>
 6f8:	39 c1                	cmp    %eax,%ecx
 6fa:	72 04                	jb     700 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fc:	39 c2                	cmp    %eax,%edx
 6fe:	72 f0                	jb     6f0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 700:	8b 73 fc             	mov    -0x4(%ebx),%esi
 703:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 706:	39 f8                	cmp    %edi,%eax
 708:	74 36                	je     740 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 70a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 70d:	8b 42 04             	mov    0x4(%edx),%eax
 710:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 713:	39 f1                	cmp    %esi,%ecx
 715:	74 42                	je     759 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 717:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 719:	5b                   	pop    %ebx
  freep = p;
 71a:	89 15 c0 09 00 00    	mov    %edx,0x9c0
}
 720:	5e                   	pop    %esi
 721:	5f                   	pop    %edi
 722:	5d                   	pop    %ebp
 723:	c3                   	ret
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 728:	39 c2                	cmp    %eax,%edx
 72a:	72 c4                	jb     6f0 <free+0x20>
 72c:	39 c1                	cmp    %eax,%ecx
 72e:	73 c0                	jae    6f0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 730:	8b 73 fc             	mov    -0x4(%ebx),%esi
 733:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 736:	39 f8                	cmp    %edi,%eax
 738:	75 d0                	jne    70a <free+0x3a>
 73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 740:	8b 78 04             	mov    0x4(%eax),%edi
 743:	01 fe                	add    %edi,%esi
 745:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 748:	8b 02                	mov    (%edx),%eax
 74a:	8b 00                	mov    (%eax),%eax
 74c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 74f:	8b 42 04             	mov    0x4(%edx),%eax
 752:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 755:	39 f1                	cmp    %esi,%ecx
 757:	75 be                	jne    717 <free+0x47>
  freep = p;
 759:	89 15 c0 09 00 00    	mov    %edx,0x9c0
    p->s.size += bp->s.size;
 75f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 762:	01 c8                	add    %ecx,%eax
 764:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 767:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 76a:	89 0a                	mov    %ecx,(%edx)
}
 76c:	5b                   	pop    %ebx
 76d:	5e                   	pop    %esi
 76e:	5f                   	pop    %edi
 76f:	5d                   	pop    %ebp
 770:	c3                   	ret
 771:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 778:	00 
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 78c:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	8d 78 07             	lea    0x7(%eax),%edi
 795:	c1 ef 03             	shr    $0x3,%edi
 798:	47                   	inc    %edi
  if((prevp = freep) == 0){
 799:	85 d2                	test   %edx,%edx
 79b:	0f 84 8f 00 00 00    	je     830 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a3:	8b 48 04             	mov    0x4(%eax),%ecx
 7a6:	39 f9                	cmp    %edi,%ecx
 7a8:	73 5e                	jae    808 <malloc+0x88>
  if(nu < 4096)
 7aa:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7af:	39 df                	cmp    %ebx,%edi
 7b1:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7b4:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7bb:	eb 0c                	jmp    7c9 <malloc+0x49>
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7c2:	8b 48 04             	mov    0x4(%eax),%ecx
 7c5:	39 f9                	cmp    %edi,%ecx
 7c7:	73 3f                	jae    808 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7c9:	39 05 c0 09 00 00    	cmp    %eax,0x9c0
 7cf:	89 c2                	mov    %eax,%edx
 7d1:	75 ed                	jne    7c0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7d3:	89 34 24             	mov    %esi,(%esp)
 7d6:	e8 b0 fb ff ff       	call   38b <sbrk>
  if(p == (char*)-1)
 7db:	83 f8 ff             	cmp    $0xffffffff,%eax
 7de:	74 18                	je     7f8 <malloc+0x78>
  hp->s.size = nu;
 7e0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7e3:	83 c0 08             	add    $0x8,%eax
 7e6:	89 04 24             	mov    %eax,(%esp)
 7e9:	e8 e2 fe ff ff       	call   6d0 <free>
  return freep;
 7ee:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
      if((p = morecore(nunits)) == 0)
 7f4:	85 d2                	test   %edx,%edx
 7f6:	75 c8                	jne    7c0 <malloc+0x40>
        return 0;
  }
}
 7f8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7fb:	31 c0                	xor    %eax,%eax
}
 7fd:	5b                   	pop    %ebx
 7fe:	5e                   	pop    %esi
 7ff:	5f                   	pop    %edi
 800:	5d                   	pop    %ebp
 801:	c3                   	ret
 802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 808:	39 cf                	cmp    %ecx,%edi
 80a:	74 54                	je     860 <malloc+0xe0>
        p->s.size -= nunits;
 80c:	29 f9                	sub    %edi,%ecx
 80e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 811:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 814:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 817:	89 15 c0 09 00 00    	mov    %edx,0x9c0
}
 81d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 820:	83 c0 08             	add    $0x8,%eax
}
 823:	5b                   	pop    %ebx
 824:	5e                   	pop    %esi
 825:	5f                   	pop    %edi
 826:	5d                   	pop    %ebp
 827:	c3                   	ret
 828:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 82f:	00 
    base.s.ptr = freep = prevp = &base;
 830:	b8 c4 09 00 00       	mov    $0x9c4,%eax
 835:	ba c4 09 00 00       	mov    $0x9c4,%edx
 83a:	a3 c0 09 00 00       	mov    %eax,0x9c0
    base.s.size = 0;
 83f:	31 c9                	xor    %ecx,%ecx
 841:	b8 c4 09 00 00       	mov    $0x9c4,%eax
    base.s.ptr = freep = prevp = &base;
 846:	89 15 c4 09 00 00    	mov    %edx,0x9c4
    base.s.size = 0;
 84c:	89 0d c8 09 00 00    	mov    %ecx,0x9c8
    if(p->s.size >= nunits){
 852:	e9 53 ff ff ff       	jmp    7aa <malloc+0x2a>
 857:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 85e:	00 
 85f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 860:	8b 08                	mov    (%eax),%ecx
 862:	89 0a                	mov    %ecx,(%edx)
 864:	eb b1                	jmp    817 <malloc+0x97>
