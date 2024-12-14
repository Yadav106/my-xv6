
_t_pagefault:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
  int pid=getpid();
   a:	e8 34 03 00 00       	call   343 <getpid>
  printf(1,"Pid of the process is %d\n",pid);
   f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  16:	89 44 24 08          	mov    %eax,0x8(%esp)
  1a:	b8 28 08 00 00       	mov    $0x828,%eax
  1f:	89 44 24 04          	mov    %eax,0x4(%esp)
  23:	e8 58 04 00 00       	call   480 <printf>
  char *sbrk_before=sbrk(0);
  28:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2f:	e8 17 03 00 00       	call   34b <sbrk>
  printf(1,"Simulating a page_fault on addr %p\n",(sbrk_before+4096));
  34:	ba 4c 08 00 00       	mov    $0x84c,%edx
  39:	89 54 24 04          	mov    %edx,0x4(%esp)
  3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  char *sbrk_before=sbrk(0);
  44:	89 c3                	mov    %eax,%ebx
  printf(1,"Simulating a page_fault on addr %p\n",(sbrk_before+4096));
  46:	8d 80 00 10 00 00    	lea    0x1000(%eax),%eax
  4c:	89 44 24 08          	mov    %eax,0x8(%esp)
  50:	e8 2b 04 00 00       	call   480 <printf>
  int n=*(sbrk_before+4096); // why we are doing this any guesses??
  55:	0f be 83 00 10 00 00 	movsbl 0x1000(%ebx),%eax
  printf(1,"%d\n",n);
  5c:	b9 3e 08 00 00       	mov    $0x83e,%ecx
  61:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  int n=*(sbrk_before+4096); // why we are doing this any guesses??
  6c:	89 44 24 08          	mov    %eax,0x8(%esp)
  printf(1,"%d\n",n);
  70:	e8 0b 04 00 00       	call   480 <printf>
  exit();
  75:	e8 49 02 00 00       	call   2c3 <exit>
  7a:	66 90                	xchg   %ax,%ax
  7c:	66 90                	xchg   %ax,%ax
  7e:	66 90                	xchg   %ax,%ax

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  81:	31 c0                	xor    %eax,%eax
{
  83:	89 e5                	mov    %esp,%ebp
  85:	53                   	push   %ebx
  86:	8b 4d 08             	mov    0x8(%ebp),%ecx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  97:	40                   	inc    %eax
  98:	84 d2                	test   %dl,%dl
  9a:	75 f4                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9c:	5b                   	pop    %ebx
  9d:	89 c8                	mov    %ecx,%eax
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret
  a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  a8:	00 
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 15                	jne    d6 <strcmp+0x26>
  c1:	eb 30                	jmp    f3 <strcmp+0x43>
  c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  cc:	8d 4b 01             	lea    0x1(%ebx),%ecx
  cf:	42                   	inc    %edx
  while(*p && *p == *q)
  d0:	84 c0                	test   %al,%al
  d2:	74 14                	je     e8 <strcmp+0x38>
  d4:	89 cb                	mov    %ecx,%ebx
  d6:	0f b6 0b             	movzbl (%ebx),%ecx
  d9:	38 c1                	cmp    %al,%cl
  db:	74 eb                	je     c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  dd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  de:	29 c8                	sub    %ecx,%eax
}
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret
  e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  e8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  ec:	31 c0                	xor    %eax,%eax
}
  ee:	5b                   	pop    %ebx
  ef:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  f0:	29 c8                	sub    %ecx,%eax
}
  f2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  f3:	0f b6 0b             	movzbl (%ebx),%ecx
  f6:	31 c0                	xor    %eax,%eax
  f8:	eb e3                	jmp    dd <strcmp+0x2d>
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 3a 00             	cmpb   $0x0,(%edx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 c0                	xor    %eax,%eax
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	40                   	inc    %eax
 111:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 115:	89 c1                	mov    %eax,%ecx
 117:	75 f7                	jne    110 <strlen+0x10>
    ;
  return n;
}
 119:	5d                   	pop    %ebp
 11a:	89 c8                	mov    %ecx,%eax
 11c:	c3                   	ret
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 121:	31 c9                	xor    %ecx,%ecx
}
 123:	89 c8                	mov    %ecx,%eax
 125:	c3                   	ret
 126:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12d:	00 
 12e:	66 90                	xchg   %ax,%ax

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 55 08             	mov    0x8(%ebp),%edx
 136:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	5f                   	pop    %edi
 143:	89 d0                	mov    %edx,%eax
 145:	5d                   	pop    %ebp
 146:	c3                   	ret
 147:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14e:	00 
 14f:	90                   	nop

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 10                	jne    171 <strchr+0x21>
 161:	eb 1d                	jmp    180 <strchr+0x30>
 163:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 168:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 16c:	40                   	inc    %eax
 16d:	84 d2                	test   %dl,%dl
 16f:	74 0f                	je     180 <strchr+0x30>
    if(*s == c)
 171:	38 d1                	cmp    %dl,%cl
 173:	75 f3                	jne    168 <strchr+0x18>
      return (char*)s;
  return 0;
}
 175:	5d                   	pop    %ebp
 176:	c3                   	ret
 177:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17e:	00 
 17f:	90                   	nop
 180:	5d                   	pop    %ebp
  return 0;
 181:	31 c0                	xor    %eax,%eax
}
 183:	c3                   	ret
 184:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18b:	00 
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	31 f6                	xor    %esi,%esi
{
 197:	53                   	push   %ebx
    cc = read(0, &c, 1);
 198:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 19b:	83 ec 3c             	sub    $0x3c,%esp
 19e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 1a1:	eb 32                	jmp    1d5 <gets+0x45>
 1a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 1a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ac:	b8 01 00 00 00       	mov    $0x1,%eax
 1b1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1bc:	e8 1a 01 00 00       	call   2db <read>
    if(cc < 1)
 1c1:	85 c0                	test   %eax,%eax
 1c3:	7e 19                	jle    1de <gets+0x4e>
      break;
    buf[i++] = c;
 1c5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 1cd:	3c 0a                	cmp    $0xa,%al
 1cf:	74 10                	je     1e1 <gets+0x51>
 1d1:	3c 0d                	cmp    $0xd,%al
 1d3:	74 0c                	je     1e1 <gets+0x51>
  for(i=0; i+1 < max; ){
 1d5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1d8:	46                   	inc    %esi
 1d9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1dc:	7c ca                	jl     1a8 <gets+0x18>
 1de:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 1e1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 1e5:	83 c4 3c             	add    $0x3c,%esp
 1e8:	89 d8                	mov    %ebx,%eax
 1ea:	5b                   	pop    %ebx
 1eb:	5e                   	pop    %esi
 1ec:	5f                   	pop    %edi
 1ed:	5d                   	pop    %ebp
 1ee:	c3                   	ret
 1ef:	90                   	nop

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f1:	31 c0                	xor    %eax,%eax
{
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	83 ec 18             	sub    $0x18,%esp
 1f8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1fb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 202:	8b 45 08             	mov    0x8(%ebp),%eax
 205:	89 04 24             	mov    %eax,(%esp)
 208:	e8 f6 00 00 00       	call   303 <open>
  if(fd < 0)
 20d:	85 c0                	test   %eax,%eax
 20f:	78 2f                	js     240 <stat+0x50>
 211:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 213:	8b 45 0c             	mov    0xc(%ebp),%eax
 216:	89 1c 24             	mov    %ebx,(%esp)
 219:	89 44 24 04          	mov    %eax,0x4(%esp)
 21d:	e8 f9 00 00 00       	call   31b <fstat>
  close(fd);
 222:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 225:	89 c6                	mov    %eax,%esi
  close(fd);
 227:	e8 bf 00 00 00       	call   2eb <close>
  return r;
}
 22c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 22f:	89 f0                	mov    %esi,%eax
 231:	8b 75 fc             	mov    -0x4(%ebp),%esi
 234:	89 ec                	mov    %ebp,%esp
 236:	5d                   	pop    %ebp
 237:	c3                   	ret
 238:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23f:	00 
    return -1;
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb e5                	jmp    22c <stat+0x3c>
 247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24e:	00 
 24f:	90                   	nop

00000250 <atoi>:

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	0f be 02             	movsbl (%edx),%eax
 25a:	88 c1                	mov    %al,%cl
 25c:	80 e9 30             	sub    $0x30,%cl
 25f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 262:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 267:	77 1c                	ja     285 <atoi+0x35>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 270:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 273:	42                   	inc    %edx
 274:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 278:	0f be 02             	movsbl (%edx),%eax
 27b:	88 c3                	mov    %al,%bl
 27d:	80 eb 30             	sub    $0x30,%bl
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
  return n;
}
 285:	5b                   	pop    %ebx
 286:	89 c8                	mov    %ecx,%eax
 288:	5d                   	pop    %ebp
 289:	c3                   	ret
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	8b 45 10             	mov    0x10(%ebp),%eax
 297:	56                   	push   %esi
 298:	8b 55 08             	mov    0x8(%ebp),%edx
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 c0                	test   %eax,%eax
 2a0:	7e 13                	jle    2b5 <memmove+0x25>
 2a2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2a4:	89 d7                	mov    %edx,%edi
 2a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ad:	00 
 2ae:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2b1:	39 f8                	cmp    %edi,%eax
 2b3:	75 fb                	jne    2b0 <memmove+0x20>
  return vdst;
}
 2b5:	5e                   	pop    %esi
 2b6:	89 d0                	mov    %edx,%eax
 2b8:	5f                   	pop    %edi
 2b9:	5d                   	pop    %ebp
 2ba:	c3                   	ret

000002bb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2bb:	b8 01 00 00 00       	mov    $0x1,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <exit>:
SYSCALL(exit)
 2c3:	b8 02 00 00 00       	mov    $0x2,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <wait>:
SYSCALL(wait)
 2cb:	b8 03 00 00 00       	mov    $0x3,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <pipe>:
SYSCALL(pipe)
 2d3:	b8 04 00 00 00       	mov    $0x4,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <read>:
SYSCALL(read)
 2db:	b8 05 00 00 00       	mov    $0x5,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <write>:
SYSCALL(write)
 2e3:	b8 10 00 00 00       	mov    $0x10,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <close>:
SYSCALL(close)
 2eb:	b8 15 00 00 00       	mov    $0x15,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <kill>:
SYSCALL(kill)
 2f3:	b8 06 00 00 00       	mov    $0x6,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <exec>:
SYSCALL(exec)
 2fb:	b8 07 00 00 00       	mov    $0x7,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <open>:
SYSCALL(open)
 303:	b8 0f 00 00 00       	mov    $0xf,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <mknod>:
SYSCALL(mknod)
 30b:	b8 11 00 00 00       	mov    $0x11,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <unlink>:
SYSCALL(unlink)
 313:	b8 12 00 00 00       	mov    $0x12,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <fstat>:
SYSCALL(fstat)
 31b:	b8 08 00 00 00       	mov    $0x8,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <link>:
SYSCALL(link)
 323:	b8 13 00 00 00       	mov    $0x13,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <mkdir>:
SYSCALL(mkdir)
 32b:	b8 14 00 00 00       	mov    $0x14,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <chdir>:
SYSCALL(chdir)
 333:	b8 09 00 00 00       	mov    $0x9,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <dup>:
SYSCALL(dup)
 33b:	b8 0a 00 00 00       	mov    $0xa,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <getpid>:
SYSCALL(getpid)
 343:	b8 0b 00 00 00       	mov    $0xb,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <sbrk>:
SYSCALL(sbrk)
 34b:	b8 0c 00 00 00       	mov    $0xc,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <sleep>:
SYSCALL(sleep)
 353:	b8 0d 00 00 00       	mov    $0xd,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <uptime>:
SYSCALL(uptime)
 35b:	b8 0e 00 00 00       	mov    $0xe,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <worldpeace>:
SYSCALL(worldpeace)
 363:	b8 16 00 00 00       	mov    $0x16,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <numberofprocesses>:
SYSCALL(numberofprocesses)
 36b:	b8 17 00 00 00       	mov    $0x17,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <whatsthestatus>:
SYSCALL(whatsthestatus)
 373:	b8 18 00 00 00       	mov    $0x18,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <get_sibling>:
SYSCALL(get_sibling)
 37b:	b8 19 00 00 00       	mov    $0x19,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <spawn>:
SYSCALL(spawn)
 383:	b8 1a 00 00 00       	mov    $0x1a,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <getvasize>:
SYSCALL(getvasize)
 38b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <va2pa>:
SYSCALL(va2pa)
 393:	b8 1c 00 00 00       	mov    $0x1c,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 39b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 3a3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 3ab:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <getpasize>:
SYSCALL(getpasize)
 3b3:	b8 20 00 00 00       	mov    $0x20,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret
 3bb:	66 90                	xchg   %ax,%ax
 3bd:	66 90                	xchg   %ax,%ax
 3bf:	90                   	nop

000003c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	89 cb                	mov    %ecx,%ebx
 3c8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3cb:	89 d1                	mov    %edx,%ecx
{
 3cd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 3d0:	89 d0                	mov    %edx,%eax
 3d2:	c1 e8 1f             	shr    $0x1f,%eax
 3d5:	84 c0                	test   %al,%al
 3d7:	0f 84 93 00 00 00    	je     470 <printint+0xb0>
 3dd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3e1:	0f 84 89 00 00 00    	je     470 <printint+0xb0>
    x = -xx;
 3e7:	f7 d9                	neg    %ecx
    neg = 1;
 3e9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 3ee:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3f5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3f8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 3fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 400:	89 c8                	mov    %ecx,%eax
 402:	31 d2                	xor    %edx,%edx
 404:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 407:	f7 f3                	div    %ebx
 409:	89 45 c0             	mov    %eax,-0x40(%ebp)
 40c:	0f b6 92 c8 08 00 00 	movzbl 0x8c8(%edx),%edx
 413:	8d 47 01             	lea    0x1(%edi),%eax
 416:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 419:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 41d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 41f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 422:	39 da                	cmp    %ebx,%edx
 424:	73 da                	jae    400 <printint+0x40>
  if(neg)
 426:	8b 45 b8             	mov    -0x48(%ebp),%eax
 429:	85 c0                	test   %eax,%eax
 42b:	74 0a                	je     437 <printint+0x77>
    buf[i++] = '-';
 42d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 430:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 435:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 437:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 43a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 43e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 440:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 443:	89 74 24 04          	mov    %esi,0x4(%esp)
 447:	88 45 d7             	mov    %al,-0x29(%ebp)
 44a:	b8 01 00 00 00       	mov    $0x1,%eax
 44f:	89 44 24 08          	mov    %eax,0x8(%esp)
 453:	8b 45 bc             	mov    -0x44(%ebp),%eax
 456:	89 04 24             	mov    %eax,(%esp)
 459:	e8 85 fe ff ff       	call   2e3 <write>
  while(--i >= 0)
 45e:	89 f8                	mov    %edi,%eax
 460:	4f                   	dec    %edi
 461:	39 d8                	cmp    %ebx,%eax
 463:	75 db                	jne    440 <printint+0x80>
}
 465:	83 c4 4c             	add    $0x4c,%esp
 468:	5b                   	pop    %ebx
 469:	5e                   	pop    %esi
 46a:	5f                   	pop    %edi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret
 46d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 470:	31 c0                	xor    %eax,%eax
 472:	e9 77 ff ff ff       	jmp    3ee <printint+0x2e>
 477:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47e:	00 
 47f:	90                   	nop

00000480 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 489:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 48c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 48f:	0f b6 13             	movzbl (%ebx),%edx
 492:	43                   	inc    %ebx
 493:	84 d2                	test   %dl,%dl
 495:	74 35                	je     4cc <printf+0x4c>
 497:	8d 45 10             	lea    0x10(%ebp),%eax
 49a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 49d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 4a0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 4a3:	83 f8 25             	cmp    $0x25,%eax
 4a6:	74 30                	je     4d8 <printf+0x58>
  write(fd, &c, 1);
 4a8:	89 34 24             	mov    %esi,(%esp)
 4ab:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 4b0:	43                   	inc    %ebx
  write(fd, &c, 1);
 4b1:	89 44 24 08          	mov    %eax,0x8(%esp)
 4b5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bc:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4bf:	e8 1f fe ff ff       	call   2e3 <write>
  for(i = 0; fmt[i]; i++){
 4c4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4c8:	84 d2                	test   %dl,%dl
 4ca:	75 d4                	jne    4a0 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4cc:	83 c4 3c             	add    $0x3c,%esp
 4cf:	5b                   	pop    %ebx
 4d0:	5e                   	pop    %esi
 4d1:	5f                   	pop    %edi
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 4d8:	0f b6 13             	movzbl (%ebx),%edx
 4db:	84 d2                	test   %dl,%dl
 4dd:	74 ed                	je     4cc <printf+0x4c>
    c = fmt[i] & 0xff;
 4df:	80 fa 25             	cmp    $0x25,%dl
 4e2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 4e5:	0f 84 75 01 00 00    	je     660 <printf+0x1e0>
 4eb:	83 e8 63             	sub    $0x63,%eax
 4ee:	83 f8 15             	cmp    $0x15,%eax
 4f1:	77 0d                	ja     500 <printf+0x80>
 4f3:	ff 24 85 70 08 00 00 	jmp    *0x870(,%eax,4)
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 500:	89 34 24             	mov    %esi,(%esp)
 503:	8d 7d e7             	lea    -0x19(%ebp),%edi
 506:	b8 01 00 00 00       	mov    $0x1,%eax
 50b:	89 44 24 08          	mov    %eax,0x8(%esp)
 50f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 513:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 516:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 51a:	e8 c4 fd ff ff       	call   2e3 <write>
        putc(fd, c);
 51f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 523:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 526:	ba 01 00 00 00       	mov    $0x1,%edx
 52b:	89 54 24 08          	mov    %edx,0x8(%esp)
 52f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 533:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 536:	89 34 24             	mov    %esi,(%esp)
 539:	e8 a5 fd ff ff       	call   2e3 <write>
  for(i = 0; fmt[i]; i++){
 53e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 542:	84 d2                	test   %dl,%dl
 544:	0f 85 56 ff ff ff    	jne    4a0 <printf+0x20>
}
 54a:	83 c4 3c             	add    $0x3c,%esp
 54d:	5b                   	pop    %ebx
 54e:	5e                   	pop    %esi
 54f:	5f                   	pop    %edi
 550:	5d                   	pop    %ebp
 551:	c3                   	ret
 552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 558:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 55b:	b9 10 00 00 00       	mov    $0x10,%ecx
 560:	8b 17                	mov    (%edi),%edx
 562:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 569:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 56c:	89 f0                	mov    %esi,%eax
 56e:	e8 4d fe ff ff       	call   3c0 <printint>
  for(i = 0; fmt[i]; i++){
 573:	83 c3 02             	add    $0x2,%ebx
        ap++;
 576:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 579:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 57d:	84 d2                	test   %dl,%dl
 57f:	0f 85 1b ff ff ff    	jne    4a0 <printf+0x20>
}
 585:	83 c4 3c             	add    $0x3c,%esp
 588:	5b                   	pop    %ebx
 589:	5e                   	pop    %esi
 58a:	5f                   	pop    %edi
 58b:	5d                   	pop    %ebp
 58c:	c3                   	ret
 58d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 590:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 593:	8b 01                	mov    (%ecx),%eax
        ap++;
 595:	83 c1 04             	add    $0x4,%ecx
 598:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 59b:	85 c0                	test   %eax,%eax
 59d:	0f 84 d5 00 00 00    	je     678 <printf+0x1f8>
        while(*s != 0){
 5a3:	0f b6 10             	movzbl (%eax),%edx
 5a6:	84 d2                	test   %dl,%dl
 5a8:	74 39                	je     5e3 <printf+0x163>
 5aa:	89 c7                	mov    %eax,%edi
 5ac:	88 d0                	mov    %dl,%al
 5ae:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5b1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5b4:	89 fb                	mov    %edi,%ebx
 5b6:	89 cf                	mov    %ecx,%edi
 5b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5bf:	00 
          putc(fd, *s);
 5c0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5c3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5c8:	43                   	inc    %ebx
  write(fd, &c, 1);
 5c9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5cd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5d1:	89 34 24             	mov    %esi,(%esp)
 5d4:	e8 0a fd ff ff       	call   2e3 <write>
        while(*s != 0){
 5d9:	0f b6 03             	movzbl (%ebx),%eax
 5dc:	84 c0                	test   %al,%al
 5de:	75 e0                	jne    5c0 <printf+0x140>
 5e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5e3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5e7:	83 c3 02             	add    $0x2,%ebx
 5ea:	84 d2                	test   %dl,%dl
 5ec:	0f 85 ae fe ff ff    	jne    4a0 <printf+0x20>
 5f2:	e9 d5 fe ff ff       	jmp    4cc <printf+0x4c>
 5f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5fe:	00 
 5ff:	90                   	nop
        printint(fd, *ap, 10, 1);
 600:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 603:	b9 0a 00 00 00       	mov    $0xa,%ecx
 608:	8b 17                	mov    (%edi),%edx
 60a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 611:	e9 53 ff ff ff       	jmp    569 <printf+0xe9>
 616:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 61d:	00 
 61e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 620:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 623:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 628:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 62b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 62d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 631:	8d 7d e7             	lea    -0x19(%ebp),%edi
 634:	89 7c 24 04          	mov    %edi,0x4(%esp)
 638:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 63b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 63e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 642:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 645:	e8 99 fc ff ff       	call   2e3 <write>
        ap++;
 64a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 64e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 652:	84 d2                	test   %dl,%dl
 654:	0f 85 46 fe ff ff    	jne    4a0 <printf+0x20>
 65a:	e9 6d fe ff ff       	jmp    4cc <printf+0x4c>
 65f:	90                   	nop
        putc(fd, c);
 660:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 663:	8d 7d e7             	lea    -0x19(%ebp),%edi
 666:	b9 01 00 00 00       	mov    $0x1,%ecx
 66b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 66f:	e9 bb fe ff ff       	jmp    52f <printf+0xaf>
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 678:	bf 42 08 00 00       	mov    $0x842,%edi
 67d:	b0 28                	mov    $0x28,%al
 67f:	e9 2a ff ff ff       	jmp    5ae <printf+0x12e>
 684:	66 90                	xchg   %ax,%ax
 686:	66 90                	xchg   %ax,%ax
 688:	66 90                	xchg   %ax,%ax
 68a:	66 90                	xchg   %ax,%ax
 68c:	66 90                	xchg   %ax,%ax
 68e:	66 90                	xchg   %ax,%ax

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 dc 08 00 00       	mov    0x8dc,%eax
{
 696:	89 e5                	mov    %esp,%ebp
 698:	57                   	push   %edi
 699:	56                   	push   %esi
 69a:	53                   	push   %ebx
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 69e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6a8:	00 
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6b0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b4:	39 ca                	cmp    %ecx,%edx
 6b6:	73 30                	jae    6e8 <free+0x58>
 6b8:	39 c1                	cmp    %eax,%ecx
 6ba:	72 04                	jb     6c0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6bc:	39 c2                	cmp    %eax,%edx
 6be:	72 f0                	jb     6b0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6c6:	39 f8                	cmp    %edi,%eax
 6c8:	74 36                	je     700 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6ca:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6cd:	8b 42 04             	mov    0x4(%edx),%eax
 6d0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6d3:	39 f1                	cmp    %esi,%ecx
 6d5:	74 42                	je     719 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6d7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6d9:	5b                   	pop    %ebx
  freep = p;
 6da:	89 15 dc 08 00 00    	mov    %edx,0x8dc
}
 6e0:	5e                   	pop    %esi
 6e1:	5f                   	pop    %edi
 6e2:	5d                   	pop    %ebp
 6e3:	c3                   	ret
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e8:	39 c2                	cmp    %eax,%edx
 6ea:	72 c4                	jb     6b0 <free+0x20>
 6ec:	39 c1                	cmp    %eax,%ecx
 6ee:	73 c0                	jae    6b0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 6f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6f6:	39 f8                	cmp    %edi,%eax
 6f8:	75 d0                	jne    6ca <free+0x3a>
 6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 700:	8b 78 04             	mov    0x4(%eax),%edi
 703:	01 fe                	add    %edi,%esi
 705:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 708:	8b 02                	mov    (%edx),%eax
 70a:	8b 00                	mov    (%eax),%eax
 70c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 70f:	8b 42 04             	mov    0x4(%edx),%eax
 712:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 715:	39 f1                	cmp    %esi,%ecx
 717:	75 be                	jne    6d7 <free+0x47>
  freep = p;
 719:	89 15 dc 08 00 00    	mov    %edx,0x8dc
    p->s.size += bp->s.size;
 71f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 722:	01 c8                	add    %ecx,%eax
 724:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 727:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 72a:	89 0a                	mov    %ecx,(%edx)
}
 72c:	5b                   	pop    %ebx
 72d:	5e                   	pop    %esi
 72e:	5f                   	pop    %edi
 72f:	5d                   	pop    %ebp
 730:	c3                   	ret
 731:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 738:	00 
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000740 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 749:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 74c:	8b 15 dc 08 00 00    	mov    0x8dc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 752:	8d 78 07             	lea    0x7(%eax),%edi
 755:	c1 ef 03             	shr    $0x3,%edi
 758:	47                   	inc    %edi
  if((prevp = freep) == 0){
 759:	85 d2                	test   %edx,%edx
 75b:	0f 84 8f 00 00 00    	je     7f0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 761:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 763:	8b 48 04             	mov    0x4(%eax),%ecx
 766:	39 f9                	cmp    %edi,%ecx
 768:	73 5e                	jae    7c8 <malloc+0x88>
  if(nu < 4096)
 76a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 76f:	39 df                	cmp    %ebx,%edi
 771:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 774:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 77b:	eb 0c                	jmp    789 <malloc+0x49>
 77d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 780:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 782:	8b 48 04             	mov    0x4(%eax),%ecx
 785:	39 f9                	cmp    %edi,%ecx
 787:	73 3f                	jae    7c8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 789:	39 05 dc 08 00 00    	cmp    %eax,0x8dc
 78f:	89 c2                	mov    %eax,%edx
 791:	75 ed                	jne    780 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 793:	89 34 24             	mov    %esi,(%esp)
 796:	e8 b0 fb ff ff       	call   34b <sbrk>
  if(p == (char*)-1)
 79b:	83 f8 ff             	cmp    $0xffffffff,%eax
 79e:	74 18                	je     7b8 <malloc+0x78>
  hp->s.size = nu;
 7a0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7a3:	83 c0 08             	add    $0x8,%eax
 7a6:	89 04 24             	mov    %eax,(%esp)
 7a9:	e8 e2 fe ff ff       	call   690 <free>
  return freep;
 7ae:	8b 15 dc 08 00 00    	mov    0x8dc,%edx
      if((p = morecore(nunits)) == 0)
 7b4:	85 d2                	test   %edx,%edx
 7b6:	75 c8                	jne    780 <malloc+0x40>
        return 0;
  }
}
 7b8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7bb:	31 c0                	xor    %eax,%eax
}
 7bd:	5b                   	pop    %ebx
 7be:	5e                   	pop    %esi
 7bf:	5f                   	pop    %edi
 7c0:	5d                   	pop    %ebp
 7c1:	c3                   	ret
 7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7c8:	39 cf                	cmp    %ecx,%edi
 7ca:	74 54                	je     820 <malloc+0xe0>
        p->s.size -= nunits;
 7cc:	29 f9                	sub    %edi,%ecx
 7ce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7d4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7d7:	89 15 dc 08 00 00    	mov    %edx,0x8dc
}
 7dd:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 7e0:	83 c0 08             	add    $0x8,%eax
}
 7e3:	5b                   	pop    %ebx
 7e4:	5e                   	pop    %esi
 7e5:	5f                   	pop    %edi
 7e6:	5d                   	pop    %ebp
 7e7:	c3                   	ret
 7e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ef:	00 
    base.s.ptr = freep = prevp = &base;
 7f0:	b8 e0 08 00 00       	mov    $0x8e0,%eax
 7f5:	ba e0 08 00 00       	mov    $0x8e0,%edx
 7fa:	a3 dc 08 00 00       	mov    %eax,0x8dc
    base.s.size = 0;
 7ff:	31 c9                	xor    %ecx,%ecx
 801:	b8 e0 08 00 00       	mov    $0x8e0,%eax
    base.s.ptr = freep = prevp = &base;
 806:	89 15 e0 08 00 00    	mov    %edx,0x8e0
    base.s.size = 0;
 80c:	89 0d e4 08 00 00    	mov    %ecx,0x8e4
    if(p->s.size >= nunits){
 812:	e9 53 ff ff ff       	jmp    76a <malloc+0x2a>
 817:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 81e:	00 
 81f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 820:	8b 08                	mov    (%eax),%ecx
 822:	89 0a                	mov    %ecx,(%edx)
 824:	eb b1                	jmp    7d7 <malloc+0x97>
