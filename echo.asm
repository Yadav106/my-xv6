
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp
   c:	8b 75 08             	mov    0x8(%ebp),%esi
   f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  for(i = 1; i < argc; i++)
  12:	83 fe 01             	cmp    $0x1,%esi
  15:	7e 66                	jle    7d <main+0x7d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  17:	83 fe 02             	cmp    $0x2,%esi
  1a:	8b 47 04             	mov    0x4(%edi),%eax
  1d:	74 3c                	je     5b <main+0x5b>
  1f:	bb 02 00 00 00       	mov    $0x2,%ebx
  24:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2b:	00 
  2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  30:	89 44 24 08          	mov    %eax,0x8(%esp)
  34:	ba 38 08 00 00       	mov    $0x838,%edx
  39:	b9 3a 08 00 00       	mov    $0x83a,%ecx
  3e:	89 54 24 0c          	mov    %edx,0xc(%esp)
  42:	43                   	inc    %ebx
  43:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4e:	e8 3d 04 00 00       	call   490 <printf>
  53:	39 de                	cmp    %ebx,%esi
  55:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  59:	75 d5                	jne    30 <main+0x30>
  5b:	89 44 24 08          	mov    %eax,0x8(%esp)
  5f:	ba 3f 08 00 00       	mov    $0x83f,%edx
  64:	b9 3a 08 00 00       	mov    $0x83a,%ecx
  69:	89 54 24 0c          	mov    %edx,0xc(%esp)
  6d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  78:	e8 13 04 00 00       	call   490 <printf>
  exit();
  7d:	e8 51 02 00 00       	call   2d3 <exit>
  82:	66 90                	xchg   %ax,%ax
  84:	66 90                	xchg   %ax,%ax
  86:	66 90                	xchg   %ax,%ax
  88:	66 90                	xchg   %ax,%ax
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  90:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  91:	31 c0                	xor    %eax,%eax
{
  93:	89 e5                	mov    %esp,%ebp
  95:	53                   	push   %ebx
  96:	8b 4d 08             	mov    0x8(%ebp),%ecx
  99:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  a7:	40                   	inc    %eax
  a8:	84 d2                	test   %dl,%dl
  aa:	75 f4                	jne    a0 <strcpy+0x10>
    ;
  return os;
}
  ac:	5b                   	pop    %ebx
  ad:	89 c8                	mov    %ecx,%eax
  af:	5d                   	pop    %ebp
  b0:	c3                   	ret
  b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  b8:	00 
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	53                   	push   %ebx
  c4:	8b 55 08             	mov    0x8(%ebp),%edx
  c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  ca:	0f b6 02             	movzbl (%edx),%eax
  cd:	84 c0                	test   %al,%al
  cf:	75 15                	jne    e6 <strcmp+0x26>
  d1:	eb 30                	jmp    103 <strcmp+0x43>
  d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  d8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  dc:	8d 4b 01             	lea    0x1(%ebx),%ecx
  df:	42                   	inc    %edx
  while(*p && *p == *q)
  e0:	84 c0                	test   %al,%al
  e2:	74 14                	je     f8 <strcmp+0x38>
  e4:	89 cb                	mov    %ecx,%ebx
  e6:	0f b6 0b             	movzbl (%ebx),%ecx
  e9:	38 c1                	cmp    %al,%cl
  eb:	74 eb                	je     d8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  ed:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  ee:	29 c8                	sub    %ecx,%eax
}
  f0:	5d                   	pop    %ebp
  f1:	c3                   	ret
  f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  f8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  fc:	31 c0                	xor    %eax,%eax
}
  fe:	5b                   	pop    %ebx
  ff:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 100:	29 c8                	sub    %ecx,%eax
}
 102:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 103:	0f b6 0b             	movzbl (%ebx),%ecx
 106:	31 c0                	xor    %eax,%eax
 108:	eb e3                	jmp    ed <strcmp+0x2d>
 10a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000110 <strlen>:

uint
strlen(const char *s)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 116:	80 3a 00             	cmpb   $0x0,(%edx)
 119:	74 15                	je     130 <strlen+0x20>
 11b:	31 c0                	xor    %eax,%eax
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	40                   	inc    %eax
 121:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 125:	89 c1                	mov    %eax,%ecx
 127:	75 f7                	jne    120 <strlen+0x10>
    ;
  return n;
}
 129:	5d                   	pop    %ebp
 12a:	89 c8                	mov    %ecx,%eax
 12c:	c3                   	ret
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 131:	31 c9                	xor    %ecx,%ecx
}
 133:	89 c8                	mov    %ecx,%eax
 135:	c3                   	ret
 136:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13d:	00 
 13e:	66 90                	xchg   %ax,%ax

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 55 08             	mov    0x8(%ebp),%edx
 146:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 147:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 d7                	mov    %edx,%edi
 14f:	fc                   	cld
 150:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 152:	5f                   	pop    %edi
 153:	89 d0                	mov    %edx,%eax
 155:	5d                   	pop    %ebp
 156:	c3                   	ret
 157:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15e:	00 
 15f:	90                   	nop

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	75 10                	jne    181 <strchr+0x21>
 171:	eb 1d                	jmp    190 <strchr+0x30>
 173:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 178:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 17c:	40                   	inc    %eax
 17d:	84 d2                	test   %dl,%dl
 17f:	74 0f                	je     190 <strchr+0x30>
    if(*s == c)
 181:	38 d1                	cmp    %dl,%cl
 183:	75 f3                	jne    178 <strchr+0x18>
      return (char*)s;
  return 0;
}
 185:	5d                   	pop    %ebp
 186:	c3                   	ret
 187:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18e:	00 
 18f:	90                   	nop
 190:	5d                   	pop    %ebp
  return 0;
 191:	31 c0                	xor    %eax,%eax
}
 193:	c3                   	ret
 194:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19b:	00 
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a5:	31 f6                	xor    %esi,%esi
{
 1a7:	53                   	push   %ebx
    cc = read(0, &c, 1);
 1a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1ab:	83 ec 3c             	sub    $0x3c,%esp
 1ae:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 1b1:	eb 32                	jmp    1e5 <gets+0x45>
 1b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 1b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1bc:	b8 01 00 00 00       	mov    $0x1,%eax
 1c1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1cc:	e8 1a 01 00 00       	call   2eb <read>
    if(cc < 1)
 1d1:	85 c0                	test   %eax,%eax
 1d3:	7e 19                	jle    1ee <gets+0x4e>
      break;
    buf[i++] = c;
 1d5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1d9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 1dd:	3c 0a                	cmp    $0xa,%al
 1df:	74 10                	je     1f1 <gets+0x51>
 1e1:	3c 0d                	cmp    $0xd,%al
 1e3:	74 0c                	je     1f1 <gets+0x51>
  for(i=0; i+1 < max; ){
 1e5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1e8:	46                   	inc    %esi
 1e9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1ec:	7c ca                	jl     1b8 <gets+0x18>
 1ee:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 1f1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 1f5:	83 c4 3c             	add    $0x3c,%esp
 1f8:	89 d8                	mov    %ebx,%eax
 1fa:	5b                   	pop    %ebx
 1fb:	5e                   	pop    %esi
 1fc:	5f                   	pop    %edi
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret
 1ff:	90                   	nop

00000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 201:	31 c0                	xor    %eax,%eax
{
 203:	89 e5                	mov    %esp,%ebp
 205:	83 ec 18             	sub    $0x18,%esp
 208:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 20b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 20e:	89 44 24 04          	mov    %eax,0x4(%esp)
 212:	8b 45 08             	mov    0x8(%ebp),%eax
 215:	89 04 24             	mov    %eax,(%esp)
 218:	e8 f6 00 00 00       	call   313 <open>
  if(fd < 0)
 21d:	85 c0                	test   %eax,%eax
 21f:	78 2f                	js     250 <stat+0x50>
 221:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 223:	8b 45 0c             	mov    0xc(%ebp),%eax
 226:	89 1c 24             	mov    %ebx,(%esp)
 229:	89 44 24 04          	mov    %eax,0x4(%esp)
 22d:	e8 f9 00 00 00       	call   32b <fstat>
  close(fd);
 232:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 235:	89 c6                	mov    %eax,%esi
  close(fd);
 237:	e8 bf 00 00 00       	call   2fb <close>
  return r;
}
 23c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 23f:	89 f0                	mov    %esi,%eax
 241:	8b 75 fc             	mov    -0x4(%ebp),%esi
 244:	89 ec                	mov    %ebp,%esp
 246:	5d                   	pop    %ebp
 247:	c3                   	ret
 248:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24f:	00 
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb e5                	jmp    23c <stat+0x3c>
 257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25e:	00 
 25f:	90                   	nop

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 02             	movsbl (%edx),%eax
 26a:	88 c1                	mov    %al,%cl
 26c:	80 e9 30             	sub    $0x30,%cl
 26f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 272:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 277:	77 1c                	ja     295 <atoi+0x35>
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 280:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 283:	42                   	inc    %edx
 284:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 288:	0f be 02             	movsbl (%edx),%eax
 28b:	88 c3                	mov    %al,%bl
 28d:	80 eb 30             	sub    $0x30,%bl
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	5b                   	pop    %ebx
 296:	89 c8                	mov    %ecx,%eax
 298:	5d                   	pop    %ebp
 299:	c3                   	ret
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 45 10             	mov    0x10(%ebp),%eax
 2a7:	56                   	push   %esi
 2a8:	8b 55 08             	mov    0x8(%ebp),%edx
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 c0                	test   %eax,%eax
 2b0:	7e 13                	jle    2c5 <memmove+0x25>
 2b2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2b4:	89 d7                	mov    %edx,%edi
 2b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2bd:	00 
 2be:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2c1:	39 f8                	cmp    %edi,%eax
 2c3:	75 fb                	jne    2c0 <memmove+0x20>
  return vdst;
}
 2c5:	5e                   	pop    %esi
 2c6:	89 d0                	mov    %edx,%eax
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret

000002cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2cb:	b8 01 00 00 00       	mov    $0x1,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <exit>:
SYSCALL(exit)
 2d3:	b8 02 00 00 00       	mov    $0x2,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <wait>:
SYSCALL(wait)
 2db:	b8 03 00 00 00       	mov    $0x3,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <pipe>:
SYSCALL(pipe)
 2e3:	b8 04 00 00 00       	mov    $0x4,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <read>:
SYSCALL(read)
 2eb:	b8 05 00 00 00       	mov    $0x5,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <write>:
SYSCALL(write)
 2f3:	b8 10 00 00 00       	mov    $0x10,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <close>:
SYSCALL(close)
 2fb:	b8 15 00 00 00       	mov    $0x15,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <kill>:
SYSCALL(kill)
 303:	b8 06 00 00 00       	mov    $0x6,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <exec>:
SYSCALL(exec)
 30b:	b8 07 00 00 00       	mov    $0x7,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <open>:
SYSCALL(open)
 313:	b8 0f 00 00 00       	mov    $0xf,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <mknod>:
SYSCALL(mknod)
 31b:	b8 11 00 00 00       	mov    $0x11,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <unlink>:
SYSCALL(unlink)
 323:	b8 12 00 00 00       	mov    $0x12,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <fstat>:
SYSCALL(fstat)
 32b:	b8 08 00 00 00       	mov    $0x8,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <link>:
SYSCALL(link)
 333:	b8 13 00 00 00       	mov    $0x13,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <mkdir>:
SYSCALL(mkdir)
 33b:	b8 14 00 00 00       	mov    $0x14,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <chdir>:
SYSCALL(chdir)
 343:	b8 09 00 00 00       	mov    $0x9,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <dup>:
SYSCALL(dup)
 34b:	b8 0a 00 00 00       	mov    $0xa,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <getpid>:
SYSCALL(getpid)
 353:	b8 0b 00 00 00       	mov    $0xb,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <sbrk>:
SYSCALL(sbrk)
 35b:	b8 0c 00 00 00       	mov    $0xc,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <sleep>:
SYSCALL(sleep)
 363:	b8 0d 00 00 00       	mov    $0xd,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <uptime>:
SYSCALL(uptime)
 36b:	b8 0e 00 00 00       	mov    $0xe,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <worldpeace>:
SYSCALL(worldpeace)
 373:	b8 16 00 00 00       	mov    $0x16,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <numberofprocesses>:
SYSCALL(numberofprocesses)
 37b:	b8 17 00 00 00       	mov    $0x17,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <whatsthestatus>:
SYSCALL(whatsthestatus)
 383:	b8 18 00 00 00       	mov    $0x18,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <get_sibling>:
SYSCALL(get_sibling)
 38b:	b8 19 00 00 00       	mov    $0x19,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <spawn>:
SYSCALL(spawn)
 393:	b8 1a 00 00 00       	mov    $0x1a,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <getvasize>:
SYSCALL(getvasize)
 39b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <va2pa>:
SYSCALL(va2pa)
 3a3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 3ab:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 3b3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 3bb:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <getpasize>:
SYSCALL(getpasize)
 3c3:	b8 20 00 00 00       	mov    $0x20,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret
 3cb:	66 90                	xchg   %ax,%ax
 3cd:	66 90                	xchg   %ax,%ax
 3cf:	90                   	nop

000003d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	89 cb                	mov    %ecx,%ebx
 3d8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3db:	89 d1                	mov    %edx,%ecx
{
 3dd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 3e0:	89 d0                	mov    %edx,%eax
 3e2:	c1 e8 1f             	shr    $0x1f,%eax
 3e5:	84 c0                	test   %al,%al
 3e7:	0f 84 93 00 00 00    	je     480 <printint+0xb0>
 3ed:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3f1:	0f 84 89 00 00 00    	je     480 <printint+0xb0>
    x = -xx;
 3f7:	f7 d9                	neg    %ecx
    neg = 1;
 3f9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 3fe:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 405:	8d 75 d7             	lea    -0x29(%ebp),%esi
 408:	89 45 b8             	mov    %eax,-0x48(%ebp)
 40b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 410:	89 c8                	mov    %ecx,%eax
 412:	31 d2                	xor    %edx,%edx
 414:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 417:	f7 f3                	div    %ebx
 419:	89 45 c0             	mov    %eax,-0x40(%ebp)
 41c:	0f b6 92 a0 08 00 00 	movzbl 0x8a0(%edx),%edx
 423:	8d 47 01             	lea    0x1(%edi),%eax
 426:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 429:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 42d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 42f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 432:	39 da                	cmp    %ebx,%edx
 434:	73 da                	jae    410 <printint+0x40>
  if(neg)
 436:	8b 45 b8             	mov    -0x48(%ebp),%eax
 439:	85 c0                	test   %eax,%eax
 43b:	74 0a                	je     447 <printint+0x77>
    buf[i++] = '-';
 43d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 440:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 445:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 447:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 44a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 44e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 450:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 453:	89 74 24 04          	mov    %esi,0x4(%esp)
 457:	88 45 d7             	mov    %al,-0x29(%ebp)
 45a:	b8 01 00 00 00       	mov    $0x1,%eax
 45f:	89 44 24 08          	mov    %eax,0x8(%esp)
 463:	8b 45 bc             	mov    -0x44(%ebp),%eax
 466:	89 04 24             	mov    %eax,(%esp)
 469:	e8 85 fe ff ff       	call   2f3 <write>
  while(--i >= 0)
 46e:	89 f8                	mov    %edi,%eax
 470:	4f                   	dec    %edi
 471:	39 d8                	cmp    %ebx,%eax
 473:	75 db                	jne    450 <printint+0x80>
}
 475:	83 c4 4c             	add    $0x4c,%esp
 478:	5b                   	pop    %ebx
 479:	5e                   	pop    %esi
 47a:	5f                   	pop    %edi
 47b:	5d                   	pop    %ebp
 47c:	c3                   	ret
 47d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 480:	31 c0                	xor    %eax,%eax
 482:	e9 77 ff ff ff       	jmp    3fe <printint+0x2e>
 487:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 48e:	00 
 48f:	90                   	nop

00000490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 499:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 49c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 49f:	0f b6 13             	movzbl (%ebx),%edx
 4a2:	43                   	inc    %ebx
 4a3:	84 d2                	test   %dl,%dl
 4a5:	74 35                	je     4dc <printf+0x4c>
 4a7:	8d 45 10             	lea    0x10(%ebp),%eax
 4aa:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 4b0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 4b3:	83 f8 25             	cmp    $0x25,%eax
 4b6:	74 30                	je     4e8 <printf+0x58>
  write(fd, &c, 1);
 4b8:	89 34 24             	mov    %esi,(%esp)
 4bb:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 4c0:	43                   	inc    %ebx
  write(fd, &c, 1);
 4c1:	89 44 24 08          	mov    %eax,0x8(%esp)
 4c5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cc:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4cf:	e8 1f fe ff ff       	call   2f3 <write>
  for(i = 0; fmt[i]; i++){
 4d4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4d8:	84 d2                	test   %dl,%dl
 4da:	75 d4                	jne    4b0 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4dc:	83 c4 3c             	add    $0x3c,%esp
 4df:	5b                   	pop    %ebx
 4e0:	5e                   	pop    %esi
 4e1:	5f                   	pop    %edi
 4e2:	5d                   	pop    %ebp
 4e3:	c3                   	ret
 4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 4e8:	0f b6 13             	movzbl (%ebx),%edx
 4eb:	84 d2                	test   %dl,%dl
 4ed:	74 ed                	je     4dc <printf+0x4c>
    c = fmt[i] & 0xff;
 4ef:	80 fa 25             	cmp    $0x25,%dl
 4f2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 4f5:	0f 84 75 01 00 00    	je     670 <printf+0x1e0>
 4fb:	83 e8 63             	sub    $0x63,%eax
 4fe:	83 f8 15             	cmp    $0x15,%eax
 501:	77 0d                	ja     510 <printf+0x80>
 503:	ff 24 85 48 08 00 00 	jmp    *0x848(,%eax,4)
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 510:	89 34 24             	mov    %esi,(%esp)
 513:	8d 7d e7             	lea    -0x19(%ebp),%edi
 516:	b8 01 00 00 00       	mov    $0x1,%eax
 51b:	89 44 24 08          	mov    %eax,0x8(%esp)
 51f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 523:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 526:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 52a:	e8 c4 fd ff ff       	call   2f3 <write>
        putc(fd, c);
 52f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 533:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 536:	ba 01 00 00 00       	mov    $0x1,%edx
 53b:	89 54 24 08          	mov    %edx,0x8(%esp)
 53f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 543:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 546:	89 34 24             	mov    %esi,(%esp)
 549:	e8 a5 fd ff ff       	call   2f3 <write>
  for(i = 0; fmt[i]; i++){
 54e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 552:	84 d2                	test   %dl,%dl
 554:	0f 85 56 ff ff ff    	jne    4b0 <printf+0x20>
}
 55a:	83 c4 3c             	add    $0x3c,%esp
 55d:	5b                   	pop    %ebx
 55e:	5e                   	pop    %esi
 55f:	5f                   	pop    %edi
 560:	5d                   	pop    %ebp
 561:	c3                   	ret
 562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 568:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 56b:	b9 10 00 00 00       	mov    $0x10,%ecx
 570:	8b 17                	mov    (%edi),%edx
 572:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 579:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 57c:	89 f0                	mov    %esi,%eax
 57e:	e8 4d fe ff ff       	call   3d0 <printint>
  for(i = 0; fmt[i]; i++){
 583:	83 c3 02             	add    $0x2,%ebx
        ap++;
 586:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 589:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 58d:	84 d2                	test   %dl,%dl
 58f:	0f 85 1b ff ff ff    	jne    4b0 <printf+0x20>
}
 595:	83 c4 3c             	add    $0x3c,%esp
 598:	5b                   	pop    %ebx
 599:	5e                   	pop    %esi
 59a:	5f                   	pop    %edi
 59b:	5d                   	pop    %ebp
 59c:	c3                   	ret
 59d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 5a0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 5a3:	8b 01                	mov    (%ecx),%eax
        ap++;
 5a5:	83 c1 04             	add    $0x4,%ecx
 5a8:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 5ab:	85 c0                	test   %eax,%eax
 5ad:	0f 84 d5 00 00 00    	je     688 <printf+0x1f8>
        while(*s != 0){
 5b3:	0f b6 10             	movzbl (%eax),%edx
 5b6:	84 d2                	test   %dl,%dl
 5b8:	74 39                	je     5f3 <printf+0x163>
 5ba:	89 c7                	mov    %eax,%edi
 5bc:	88 d0                	mov    %dl,%al
 5be:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5c1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5c4:	89 fb                	mov    %edi,%ebx
 5c6:	89 cf                	mov    %ecx,%edi
 5c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5cf:	00 
          putc(fd, *s);
 5d0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5d3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5d8:	43                   	inc    %ebx
  write(fd, &c, 1);
 5d9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5dd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5e1:	89 34 24             	mov    %esi,(%esp)
 5e4:	e8 0a fd ff ff       	call   2f3 <write>
        while(*s != 0){
 5e9:	0f b6 03             	movzbl (%ebx),%eax
 5ec:	84 c0                	test   %al,%al
 5ee:	75 e0                	jne    5d0 <printf+0x140>
 5f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5f3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5f7:	83 c3 02             	add    $0x2,%ebx
 5fa:	84 d2                	test   %dl,%dl
 5fc:	0f 85 ae fe ff ff    	jne    4b0 <printf+0x20>
 602:	e9 d5 fe ff ff       	jmp    4dc <printf+0x4c>
 607:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 60e:	00 
 60f:	90                   	nop
        printint(fd, *ap, 10, 1);
 610:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 613:	b9 0a 00 00 00       	mov    $0xa,%ecx
 618:	8b 17                	mov    (%edi),%edx
 61a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 621:	e9 53 ff ff ff       	jmp    579 <printf+0xe9>
 626:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 62d:	00 
 62e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 630:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 633:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 638:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 63b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 63d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 641:	8d 7d e7             	lea    -0x19(%ebp),%edi
 644:	89 7c 24 04          	mov    %edi,0x4(%esp)
 648:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 64b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 64e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 652:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 655:	e8 99 fc ff ff       	call   2f3 <write>
        ap++;
 65a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 65e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 662:	84 d2                	test   %dl,%dl
 664:	0f 85 46 fe ff ff    	jne    4b0 <printf+0x20>
 66a:	e9 6d fe ff ff       	jmp    4dc <printf+0x4c>
 66f:	90                   	nop
        putc(fd, c);
 670:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 673:	8d 7d e7             	lea    -0x19(%ebp),%edi
 676:	b9 01 00 00 00       	mov    $0x1,%ecx
 67b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 67f:	e9 bb fe ff ff       	jmp    53f <printf+0xaf>
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 688:	bf 41 08 00 00       	mov    $0x841,%edi
 68d:	b0 28                	mov    $0x28,%al
 68f:	e9 2a ff ff ff       	jmp    5be <printf+0x12e>
 694:	66 90                	xchg   %ax,%ax
 696:	66 90                	xchg   %ax,%ax
 698:	66 90                	xchg   %ax,%ax
 69a:	66 90                	xchg   %ax,%ax
 69c:	66 90                	xchg   %ax,%ax
 69e:	66 90                	xchg   %ax,%ax

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	a1 b4 08 00 00       	mov    0x8b4,%eax
{
 6a6:	89 e5                	mov    %esp,%ebp
 6a8:	57                   	push   %edi
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6b8:	00 
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6c0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c4:	39 ca                	cmp    %ecx,%edx
 6c6:	73 30                	jae    6f8 <free+0x58>
 6c8:	39 c1                	cmp    %eax,%ecx
 6ca:	72 04                	jb     6d0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6cc:	39 c2                	cmp    %eax,%edx
 6ce:	72 f0                	jb     6c0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6d6:	39 f8                	cmp    %edi,%eax
 6d8:	74 36                	je     710 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6dd:	8b 42 04             	mov    0x4(%edx),%eax
 6e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6e3:	39 f1                	cmp    %esi,%ecx
 6e5:	74 42                	je     729 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6e7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6e9:	5b                   	pop    %ebx
  freep = p;
 6ea:	89 15 b4 08 00 00    	mov    %edx,0x8b4
}
 6f0:	5e                   	pop    %esi
 6f1:	5f                   	pop    %edi
 6f2:	5d                   	pop    %ebp
 6f3:	c3                   	ret
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f8:	39 c2                	cmp    %eax,%edx
 6fa:	72 c4                	jb     6c0 <free+0x20>
 6fc:	39 c1                	cmp    %eax,%ecx
 6fe:	73 c0                	jae    6c0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 700:	8b 73 fc             	mov    -0x4(%ebx),%esi
 703:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 706:	39 f8                	cmp    %edi,%eax
 708:	75 d0                	jne    6da <free+0x3a>
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 710:	8b 78 04             	mov    0x4(%eax),%edi
 713:	01 fe                	add    %edi,%esi
 715:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 718:	8b 02                	mov    (%edx),%eax
 71a:	8b 00                	mov    (%eax),%eax
 71c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 71f:	8b 42 04             	mov    0x4(%edx),%eax
 722:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 725:	39 f1                	cmp    %esi,%ecx
 727:	75 be                	jne    6e7 <free+0x47>
  freep = p;
 729:	89 15 b4 08 00 00    	mov    %edx,0x8b4
    p->s.size += bp->s.size;
 72f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 732:	01 c8                	add    %ecx,%eax
 734:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 737:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 73a:	89 0a                	mov    %ecx,(%edx)
}
 73c:	5b                   	pop    %ebx
 73d:	5e                   	pop    %esi
 73e:	5f                   	pop    %edi
 73f:	5d                   	pop    %ebp
 740:	c3                   	ret
 741:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 748:	00 
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 75c:	8b 15 b4 08 00 00    	mov    0x8b4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	8d 78 07             	lea    0x7(%eax),%edi
 765:	c1 ef 03             	shr    $0x3,%edi
 768:	47                   	inc    %edi
  if((prevp = freep) == 0){
 769:	85 d2                	test   %edx,%edx
 76b:	0f 84 8f 00 00 00    	je     800 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 771:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 773:	8b 48 04             	mov    0x4(%eax),%ecx
 776:	39 f9                	cmp    %edi,%ecx
 778:	73 5e                	jae    7d8 <malloc+0x88>
  if(nu < 4096)
 77a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 77f:	39 df                	cmp    %ebx,%edi
 781:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 784:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 78b:	eb 0c                	jmp    799 <malloc+0x49>
 78d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 790:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 792:	8b 48 04             	mov    0x4(%eax),%ecx
 795:	39 f9                	cmp    %edi,%ecx
 797:	73 3f                	jae    7d8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 799:	39 05 b4 08 00 00    	cmp    %eax,0x8b4
 79f:	89 c2                	mov    %eax,%edx
 7a1:	75 ed                	jne    790 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7a3:	89 34 24             	mov    %esi,(%esp)
 7a6:	e8 b0 fb ff ff       	call   35b <sbrk>
  if(p == (char*)-1)
 7ab:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ae:	74 18                	je     7c8 <malloc+0x78>
  hp->s.size = nu;
 7b0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7b3:	83 c0 08             	add    $0x8,%eax
 7b6:	89 04 24             	mov    %eax,(%esp)
 7b9:	e8 e2 fe ff ff       	call   6a0 <free>
  return freep;
 7be:	8b 15 b4 08 00 00    	mov    0x8b4,%edx
      if((p = morecore(nunits)) == 0)
 7c4:	85 d2                	test   %edx,%edx
 7c6:	75 c8                	jne    790 <malloc+0x40>
        return 0;
  }
}
 7c8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7cb:	31 c0                	xor    %eax,%eax
}
 7cd:	5b                   	pop    %ebx
 7ce:	5e                   	pop    %esi
 7cf:	5f                   	pop    %edi
 7d0:	5d                   	pop    %ebp
 7d1:	c3                   	ret
 7d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7d8:	39 cf                	cmp    %ecx,%edi
 7da:	74 54                	je     830 <malloc+0xe0>
        p->s.size -= nunits;
 7dc:	29 f9                	sub    %edi,%ecx
 7de:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7e1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7e4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7e7:	89 15 b4 08 00 00    	mov    %edx,0x8b4
}
 7ed:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 7f0:	83 c0 08             	add    $0x8,%eax
}
 7f3:	5b                   	pop    %ebx
 7f4:	5e                   	pop    %esi
 7f5:	5f                   	pop    %edi
 7f6:	5d                   	pop    %ebp
 7f7:	c3                   	ret
 7f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ff:	00 
    base.s.ptr = freep = prevp = &base;
 800:	b8 b8 08 00 00       	mov    $0x8b8,%eax
 805:	ba b8 08 00 00       	mov    $0x8b8,%edx
 80a:	a3 b4 08 00 00       	mov    %eax,0x8b4
    base.s.size = 0;
 80f:	31 c9                	xor    %ecx,%ecx
 811:	b8 b8 08 00 00       	mov    $0x8b8,%eax
    base.s.ptr = freep = prevp = &base;
 816:	89 15 b8 08 00 00    	mov    %edx,0x8b8
    base.s.size = 0;
 81c:	89 0d bc 08 00 00    	mov    %ecx,0x8bc
    if(p->s.size >= nunits){
 822:	e9 53 ff ff ff       	jmp    77a <malloc+0x2a>
 827:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 82e:	00 
 82f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 830:	8b 08                	mov    (%eax),%ecx
 832:	89 0a                	mov    %ecx,(%edx)
 834:	eb b1                	jmp    7e7 <malloc+0x97>
