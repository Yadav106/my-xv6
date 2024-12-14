
_mkdir:     file format elf32-i386


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
   c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  if(argc < 2){
   f:	83 ff 01             	cmp    $0x1,%edi
  12:	7e 43                	jle    57 <main+0x57>
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  17:	be 01 00 00 00       	mov    $0x1,%esi
  1c:	8d 58 04             	lea    0x4(%eax),%ebx
  1f:	90                   	nop
    if(mkdir(argv[i]) < 0){
  20:	8b 03                	mov    (%ebx),%eax
  22:	89 04 24             	mov    %eax,(%esp)
  25:	e8 f1 02 00 00       	call   31b <mkdir>
  2a:	85 c0                	test   %eax,%eax
  2c:	78 0d                	js     3b <main+0x3b>
  for(i = 1; i < argc; i++){
  2e:	46                   	inc    %esi
  2f:	83 c3 04             	add    $0x4,%ebx
  32:	39 f7                	cmp    %esi,%edi
  34:	75 ea                	jne    20 <main+0x20>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  36:	e8 78 02 00 00       	call   2b3 <exit>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  3b:	8b 03                	mov    (%ebx),%eax
  3d:	c7 44 24 04 2f 08 00 	movl   $0x82f,0x4(%esp)
  44:	00 
  45:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4c:	89 44 24 08          	mov    %eax,0x8(%esp)
  50:	e8 1b 04 00 00       	call   470 <printf>
      break;
  55:	eb df                	jmp    36 <main+0x36>
    printf(2, "Usage: mkdir files...\n");
  57:	c7 44 24 04 18 08 00 	movl   $0x818,0x4(%esp)
  5e:	00 
  5f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  66:	e8 05 04 00 00       	call   470 <printf>
    exit();
  6b:	e8 43 02 00 00       	call   2b3 <exit>

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  71:	31 c0                	xor    %eax,%eax
{
  73:	89 e5                	mov    %esp,%ebp
  75:	53                   	push   %ebx
  76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  80:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  84:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  87:	40                   	inc    %eax
  88:	84 d2                	test   %dl,%dl
  8a:	75 f4                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  8c:	5b                   	pop    %ebx
  8d:	89 c8                	mov    %ecx,%eax
  8f:	5d                   	pop    %ebp
  90:	c3                   	ret
  91:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  98:	00 
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 55 08             	mov    0x8(%ebp),%edx
  a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	84 c0                	test   %al,%al
  af:	75 15                	jne    c6 <strcmp+0x26>
  b1:	eb 30                	jmp    e3 <strcmp+0x43>
  b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  b8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  bc:	8d 4b 01             	lea    0x1(%ebx),%ecx
  bf:	42                   	inc    %edx
  while(*p && *p == *q)
  c0:	84 c0                	test   %al,%al
  c2:	74 14                	je     d8 <strcmp+0x38>
  c4:	89 cb                	mov    %ecx,%ebx
  c6:	0f b6 0b             	movzbl (%ebx),%ecx
  c9:	38 c1                	cmp    %al,%cl
  cb:	74 eb                	je     b8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
  cd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  ce:	29 c8                	sub    %ecx,%eax
}
  d0:	5d                   	pop    %ebp
  d1:	c3                   	ret
  d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  d8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  dc:	31 c0                	xor    %eax,%eax
}
  de:	5b                   	pop    %ebx
  df:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
  e0:	29 c8                	sub    %ecx,%eax
}
  e2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  e3:	0f b6 0b             	movzbl (%ebx),%ecx
  e6:	31 c0                	xor    %eax,%eax
  e8:	eb e3                	jmp    cd <strcmp+0x2d>
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 3a 00             	cmpb   $0x0,(%edx)
  f9:	74 15                	je     110 <strlen+0x20>
  fb:	31 c0                	xor    %eax,%eax
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	40                   	inc    %eax
 101:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 105:	89 c1                	mov    %eax,%ecx
 107:	75 f7                	jne    100 <strlen+0x10>
    ;
  return n;
}
 109:	5d                   	pop    %ebp
 10a:	89 c8                	mov    %ecx,%eax
 10c:	c3                   	ret
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 111:	31 c9                	xor    %ecx,%ecx
}
 113:	89 c8                	mov    %ecx,%eax
 115:	c3                   	ret
 116:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11d:	00 
 11e:	66 90                	xchg   %ax,%ax

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 55 08             	mov    0x8(%ebp),%edx
 126:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	5f                   	pop    %edi
 133:	89 d0                	mov    %edx,%eax
 135:	5d                   	pop    %ebp
 136:	c3                   	ret
 137:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13e:	00 
 13f:	90                   	nop

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	75 10                	jne    161 <strchr+0x21>
 151:	eb 1d                	jmp    170 <strchr+0x30>
 153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 158:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 15c:	40                   	inc    %eax
 15d:	84 d2                	test   %dl,%dl
 15f:	74 0f                	je     170 <strchr+0x30>
    if(*s == c)
 161:	38 d1                	cmp    %dl,%cl
 163:	75 f3                	jne    158 <strchr+0x18>
      return (char*)s;
  return 0;
}
 165:	5d                   	pop    %ebp
 166:	c3                   	ret
 167:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16e:	00 
 16f:	90                   	nop
 170:	5d                   	pop    %ebp
  return 0;
 171:	31 c0                	xor    %eax,%eax
}
 173:	c3                   	ret
 174:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17b:	00 
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 185:	31 f6                	xor    %esi,%esi
{
 187:	53                   	push   %ebx
    cc = read(0, &c, 1);
 188:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 18b:	83 ec 3c             	sub    $0x3c,%esp
 18e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 191:	eb 32                	jmp    1c5 <gets+0x45>
 193:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 198:	89 7c 24 04          	mov    %edi,0x4(%esp)
 19c:	b8 01 00 00 00       	mov    $0x1,%eax
 1a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1ac:	e8 1a 01 00 00       	call   2cb <read>
    if(cc < 1)
 1b1:	85 c0                	test   %eax,%eax
 1b3:	7e 19                	jle    1ce <gets+0x4e>
      break;
    buf[i++] = c;
 1b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 1bd:	3c 0a                	cmp    $0xa,%al
 1bf:	74 10                	je     1d1 <gets+0x51>
 1c1:	3c 0d                	cmp    $0xd,%al
 1c3:	74 0c                	je     1d1 <gets+0x51>
  for(i=0; i+1 < max; ){
 1c5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1c8:	46                   	inc    %esi
 1c9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1cc:	7c ca                	jl     198 <gets+0x18>
 1ce:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 1d1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 1d5:	83 c4 3c             	add    $0x3c,%esp
 1d8:	89 d8                	mov    %ebx,%eax
 1da:	5b                   	pop    %ebx
 1db:	5e                   	pop    %esi
 1dc:	5f                   	pop    %edi
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret
 1df:	90                   	nop

000001e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e1:	31 c0                	xor    %eax,%eax
{
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	83 ec 18             	sub    $0x18,%esp
 1e8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1eb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
 1f5:	89 04 24             	mov    %eax,(%esp)
 1f8:	e8 f6 00 00 00       	call   2f3 <open>
  if(fd < 0)
 1fd:	85 c0                	test   %eax,%eax
 1ff:	78 2f                	js     230 <stat+0x50>
 201:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 203:	8b 45 0c             	mov    0xc(%ebp),%eax
 206:	89 1c 24             	mov    %ebx,(%esp)
 209:	89 44 24 04          	mov    %eax,0x4(%esp)
 20d:	e8 f9 00 00 00       	call   30b <fstat>
  close(fd);
 212:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 215:	89 c6                	mov    %eax,%esi
  close(fd);
 217:	e8 bf 00 00 00       	call   2db <close>
  return r;
}
 21c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 21f:	89 f0                	mov    %esi,%eax
 221:	8b 75 fc             	mov    -0x4(%ebp),%esi
 224:	89 ec                	mov    %ebp,%esp
 226:	5d                   	pop    %ebp
 227:	c3                   	ret
 228:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22f:	00 
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb e5                	jmp    21c <stat+0x3c>
 237:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23e:	00 
 23f:	90                   	nop

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 02             	movsbl (%edx),%eax
 24a:	88 c1                	mov    %al,%cl
 24c:	80 e9 30             	sub    $0x30,%cl
 24f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 252:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 257:	77 1c                	ja     275 <atoi+0x35>
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 260:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 263:	42                   	inc    %edx
 264:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 268:	0f be 02             	movsbl (%edx),%eax
 26b:	88 c3                	mov    %al,%bl
 26d:	80 eb 30             	sub    $0x30,%bl
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	5b                   	pop    %ebx
 276:	89 c8                	mov    %ecx,%eax
 278:	5d                   	pop    %ebp
 279:	c3                   	ret
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	8b 45 10             	mov    0x10(%ebp),%eax
 287:	56                   	push   %esi
 288:	8b 55 08             	mov    0x8(%ebp),%edx
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 c0                	test   %eax,%eax
 290:	7e 13                	jle    2a5 <memmove+0x25>
 292:	01 d0                	add    %edx,%eax
  dst = vdst;
 294:	89 d7                	mov    %edx,%edi
 296:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29d:	00 
 29e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2a1:	39 f8                	cmp    %edi,%eax
 2a3:	75 fb                	jne    2a0 <memmove+0x20>
  return vdst;
}
 2a5:	5e                   	pop    %esi
 2a6:	89 d0                	mov    %edx,%eax
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret

000002ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ab:	b8 01 00 00 00       	mov    $0x1,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <exit>:
SYSCALL(exit)
 2b3:	b8 02 00 00 00       	mov    $0x2,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <wait>:
SYSCALL(wait)
 2bb:	b8 03 00 00 00       	mov    $0x3,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <pipe>:
SYSCALL(pipe)
 2c3:	b8 04 00 00 00       	mov    $0x4,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <read>:
SYSCALL(read)
 2cb:	b8 05 00 00 00       	mov    $0x5,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <write>:
SYSCALL(write)
 2d3:	b8 10 00 00 00       	mov    $0x10,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <close>:
SYSCALL(close)
 2db:	b8 15 00 00 00       	mov    $0x15,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <kill>:
SYSCALL(kill)
 2e3:	b8 06 00 00 00       	mov    $0x6,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <exec>:
SYSCALL(exec)
 2eb:	b8 07 00 00 00       	mov    $0x7,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <open>:
SYSCALL(open)
 2f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <mknod>:
SYSCALL(mknod)
 2fb:	b8 11 00 00 00       	mov    $0x11,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <unlink>:
SYSCALL(unlink)
 303:	b8 12 00 00 00       	mov    $0x12,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <fstat>:
SYSCALL(fstat)
 30b:	b8 08 00 00 00       	mov    $0x8,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <link>:
SYSCALL(link)
 313:	b8 13 00 00 00       	mov    $0x13,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <mkdir>:
SYSCALL(mkdir)
 31b:	b8 14 00 00 00       	mov    $0x14,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <chdir>:
SYSCALL(chdir)
 323:	b8 09 00 00 00       	mov    $0x9,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <dup>:
SYSCALL(dup)
 32b:	b8 0a 00 00 00       	mov    $0xa,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <getpid>:
SYSCALL(getpid)
 333:	b8 0b 00 00 00       	mov    $0xb,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <sbrk>:
SYSCALL(sbrk)
 33b:	b8 0c 00 00 00       	mov    $0xc,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <sleep>:
SYSCALL(sleep)
 343:	b8 0d 00 00 00       	mov    $0xd,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <uptime>:
SYSCALL(uptime)
 34b:	b8 0e 00 00 00       	mov    $0xe,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <worldpeace>:
SYSCALL(worldpeace)
 353:	b8 16 00 00 00       	mov    $0x16,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <numberofprocesses>:
SYSCALL(numberofprocesses)
 35b:	b8 17 00 00 00       	mov    $0x17,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <whatsthestatus>:
SYSCALL(whatsthestatus)
 363:	b8 18 00 00 00       	mov    $0x18,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <get_sibling>:
SYSCALL(get_sibling)
 36b:	b8 19 00 00 00       	mov    $0x19,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <spawn>:
SYSCALL(spawn)
 373:	b8 1a 00 00 00       	mov    $0x1a,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <getvasize>:
SYSCALL(getvasize)
 37b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <va2pa>:
SYSCALL(va2pa)
 383:	b8 1c 00 00 00       	mov    $0x1c,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 38b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 393:	b8 1e 00 00 00       	mov    $0x1e,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 39b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <getpasize>:
SYSCALL(getpasize)
 3a3:	b8 20 00 00 00       	mov    $0x20,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret
 3ab:	66 90                	xchg   %ax,%ax
 3ad:	66 90                	xchg   %ax,%ax
 3af:	90                   	nop

000003b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
 3b6:	89 cb                	mov    %ecx,%ebx
 3b8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3bb:	89 d1                	mov    %edx,%ecx
{
 3bd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 3c0:	89 d0                	mov    %edx,%eax
 3c2:	c1 e8 1f             	shr    $0x1f,%eax
 3c5:	84 c0                	test   %al,%al
 3c7:	0f 84 93 00 00 00    	je     460 <printint+0xb0>
 3cd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3d1:	0f 84 89 00 00 00    	je     460 <printint+0xb0>
    x = -xx;
 3d7:	f7 d9                	neg    %ecx
    neg = 1;
 3d9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 3de:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3e5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3e8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 3eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3f0:	89 c8                	mov    %ecx,%eax
 3f2:	31 d2                	xor    %edx,%edx
 3f4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3f7:	f7 f3                	div    %ebx
 3f9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3fc:	0f b6 92 ac 08 00 00 	movzbl 0x8ac(%edx),%edx
 403:	8d 47 01             	lea    0x1(%edi),%eax
 406:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 409:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 40d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 40f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 412:	39 da                	cmp    %ebx,%edx
 414:	73 da                	jae    3f0 <printint+0x40>
  if(neg)
 416:	8b 45 b8             	mov    -0x48(%ebp),%eax
 419:	85 c0                	test   %eax,%eax
 41b:	74 0a                	je     427 <printint+0x77>
    buf[i++] = '-';
 41d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 420:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 425:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 427:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 42a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 42e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 430:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 433:	89 74 24 04          	mov    %esi,0x4(%esp)
 437:	88 45 d7             	mov    %al,-0x29(%ebp)
 43a:	b8 01 00 00 00       	mov    $0x1,%eax
 43f:	89 44 24 08          	mov    %eax,0x8(%esp)
 443:	8b 45 bc             	mov    -0x44(%ebp),%eax
 446:	89 04 24             	mov    %eax,(%esp)
 449:	e8 85 fe ff ff       	call   2d3 <write>
  while(--i >= 0)
 44e:	89 f8                	mov    %edi,%eax
 450:	4f                   	dec    %edi
 451:	39 d8                	cmp    %ebx,%eax
 453:	75 db                	jne    430 <printint+0x80>
}
 455:	83 c4 4c             	add    $0x4c,%esp
 458:	5b                   	pop    %ebx
 459:	5e                   	pop    %esi
 45a:	5f                   	pop    %edi
 45b:	5d                   	pop    %ebp
 45c:	c3                   	ret
 45d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 460:	31 c0                	xor    %eax,%eax
 462:	e9 77 ff ff ff       	jmp    3de <printint+0x2e>
 467:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 46e:	00 
 46f:	90                   	nop

00000470 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	56                   	push   %esi
 475:	53                   	push   %ebx
 476:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 479:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 47c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 47f:	0f b6 13             	movzbl (%ebx),%edx
 482:	43                   	inc    %ebx
 483:	84 d2                	test   %dl,%dl
 485:	74 35                	je     4bc <printf+0x4c>
 487:	8d 45 10             	lea    0x10(%ebp),%eax
 48a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 48d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 490:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 493:	83 f8 25             	cmp    $0x25,%eax
 496:	74 30                	je     4c8 <printf+0x58>
  write(fd, &c, 1);
 498:	89 34 24             	mov    %esi,(%esp)
 49b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 4a0:	43                   	inc    %ebx
  write(fd, &c, 1);
 4a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 4a5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ac:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4af:	e8 1f fe ff ff       	call   2d3 <write>
  for(i = 0; fmt[i]; i++){
 4b4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4b8:	84 d2                	test   %dl,%dl
 4ba:	75 d4                	jne    490 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4bc:	83 c4 3c             	add    $0x3c,%esp
 4bf:	5b                   	pop    %ebx
 4c0:	5e                   	pop    %esi
 4c1:	5f                   	pop    %edi
 4c2:	5d                   	pop    %ebp
 4c3:	c3                   	ret
 4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 4c8:	0f b6 13             	movzbl (%ebx),%edx
 4cb:	84 d2                	test   %dl,%dl
 4cd:	74 ed                	je     4bc <printf+0x4c>
    c = fmt[i] & 0xff;
 4cf:	80 fa 25             	cmp    $0x25,%dl
 4d2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 4d5:	0f 84 75 01 00 00    	je     650 <printf+0x1e0>
 4db:	83 e8 63             	sub    $0x63,%eax
 4de:	83 f8 15             	cmp    $0x15,%eax
 4e1:	77 0d                	ja     4f0 <printf+0x80>
 4e3:	ff 24 85 54 08 00 00 	jmp    *0x854(,%eax,4)
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4f0:	89 34 24             	mov    %esi,(%esp)
 4f3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4f6:	b8 01 00 00 00       	mov    $0x1,%eax
 4fb:	89 44 24 08          	mov    %eax,0x8(%esp)
 4ff:	89 7c 24 04          	mov    %edi,0x4(%esp)
 503:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 506:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 50a:	e8 c4 fd ff ff       	call   2d3 <write>
        putc(fd, c);
 50f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 513:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 516:	ba 01 00 00 00       	mov    $0x1,%edx
 51b:	89 54 24 08          	mov    %edx,0x8(%esp)
 51f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 523:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 526:	89 34 24             	mov    %esi,(%esp)
 529:	e8 a5 fd ff ff       	call   2d3 <write>
  for(i = 0; fmt[i]; i++){
 52e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 532:	84 d2                	test   %dl,%dl
 534:	0f 85 56 ff ff ff    	jne    490 <printf+0x20>
}
 53a:	83 c4 3c             	add    $0x3c,%esp
 53d:	5b                   	pop    %ebx
 53e:	5e                   	pop    %esi
 53f:	5f                   	pop    %edi
 540:	5d                   	pop    %ebp
 541:	c3                   	ret
 542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 548:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 54b:	b9 10 00 00 00       	mov    $0x10,%ecx
 550:	8b 17                	mov    (%edi),%edx
 552:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 559:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 55c:	89 f0                	mov    %esi,%eax
 55e:	e8 4d fe ff ff       	call   3b0 <printint>
  for(i = 0; fmt[i]; i++){
 563:	83 c3 02             	add    $0x2,%ebx
        ap++;
 566:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 569:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 56d:	84 d2                	test   %dl,%dl
 56f:	0f 85 1b ff ff ff    	jne    490 <printf+0x20>
}
 575:	83 c4 3c             	add    $0x3c,%esp
 578:	5b                   	pop    %ebx
 579:	5e                   	pop    %esi
 57a:	5f                   	pop    %edi
 57b:	5d                   	pop    %ebp
 57c:	c3                   	ret
 57d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 580:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 583:	8b 01                	mov    (%ecx),%eax
        ap++;
 585:	83 c1 04             	add    $0x4,%ecx
 588:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 58b:	85 c0                	test   %eax,%eax
 58d:	0f 84 d5 00 00 00    	je     668 <printf+0x1f8>
        while(*s != 0){
 593:	0f b6 10             	movzbl (%eax),%edx
 596:	84 d2                	test   %dl,%dl
 598:	74 39                	je     5d3 <printf+0x163>
 59a:	89 c7                	mov    %eax,%edi
 59c:	88 d0                	mov    %dl,%al
 59e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5a1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5a4:	89 fb                	mov    %edi,%ebx
 5a6:	89 cf                	mov    %ecx,%edi
 5a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5af:	00 
          putc(fd, *s);
 5b0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5b3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5b8:	43                   	inc    %ebx
  write(fd, &c, 1);
 5b9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5bd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5c1:	89 34 24             	mov    %esi,(%esp)
 5c4:	e8 0a fd ff ff       	call   2d3 <write>
        while(*s != 0){
 5c9:	0f b6 03             	movzbl (%ebx),%eax
 5cc:	84 c0                	test   %al,%al
 5ce:	75 e0                	jne    5b0 <printf+0x140>
 5d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5d3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5d7:	83 c3 02             	add    $0x2,%ebx
 5da:	84 d2                	test   %dl,%dl
 5dc:	0f 85 ae fe ff ff    	jne    490 <printf+0x20>
 5e2:	e9 d5 fe ff ff       	jmp    4bc <printf+0x4c>
 5e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ee:	00 
 5ef:	90                   	nop
        printint(fd, *ap, 10, 1);
 5f0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5f8:	8b 17                	mov    (%edi),%edx
 5fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 601:	e9 53 ff ff ff       	jmp    559 <printf+0xe9>
 606:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 60d:	00 
 60e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 610:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 613:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 618:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 61b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 61d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 621:	8d 7d e7             	lea    -0x19(%ebp),%edi
 624:	89 7c 24 04          	mov    %edi,0x4(%esp)
 628:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 62b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 62e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 632:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 635:	e8 99 fc ff ff       	call   2d3 <write>
        ap++;
 63a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 63e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 642:	84 d2                	test   %dl,%dl
 644:	0f 85 46 fe ff ff    	jne    490 <printf+0x20>
 64a:	e9 6d fe ff ff       	jmp    4bc <printf+0x4c>
 64f:	90                   	nop
        putc(fd, c);
 650:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 653:	8d 7d e7             	lea    -0x19(%ebp),%edi
 656:	b9 01 00 00 00       	mov    $0x1,%ecx
 65b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 65f:	e9 bb fe ff ff       	jmp    51f <printf+0xaf>
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 668:	bf 4b 08 00 00       	mov    $0x84b,%edi
 66d:	b0 28                	mov    $0x28,%al
 66f:	e9 2a ff ff ff       	jmp    59e <printf+0x12e>
 674:	66 90                	xchg   %ax,%ax
 676:	66 90                	xchg   %ax,%ax
 678:	66 90                	xchg   %ax,%ax
 67a:	66 90                	xchg   %ax,%ax
 67c:	66 90                	xchg   %ax,%ax
 67e:	66 90                	xchg   %ax,%ax

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 c0 08 00 00       	mov    0x8c0,%eax
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 68e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 698:	00 
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a4:	39 ca                	cmp    %ecx,%edx
 6a6:	73 30                	jae    6d8 <free+0x58>
 6a8:	39 c1                	cmp    %eax,%ecx
 6aa:	72 04                	jb     6b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ac:	39 c2                	cmp    %eax,%edx
 6ae:	72 f0                	jb     6a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6b6:	39 f8                	cmp    %edi,%eax
 6b8:	74 36                	je     6f0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6bd:	8b 42 04             	mov    0x4(%edx),%eax
 6c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6c3:	39 f1                	cmp    %esi,%ecx
 6c5:	74 42                	je     709 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6c7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6c9:	5b                   	pop    %ebx
  freep = p;
 6ca:	89 15 c0 08 00 00    	mov    %edx,0x8c0
}
 6d0:	5e                   	pop    %esi
 6d1:	5f                   	pop    %edi
 6d2:	5d                   	pop    %ebp
 6d3:	c3                   	ret
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d8:	39 c2                	cmp    %eax,%edx
 6da:	72 c4                	jb     6a0 <free+0x20>
 6dc:	39 c1                	cmp    %eax,%ecx
 6de:	73 c0                	jae    6a0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 6e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6e6:	39 f8                	cmp    %edi,%eax
 6e8:	75 d0                	jne    6ba <free+0x3a>
 6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 6f0:	8b 78 04             	mov    0x4(%eax),%edi
 6f3:	01 fe                	add    %edi,%esi
 6f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f8:	8b 02                	mov    (%edx),%eax
 6fa:	8b 00                	mov    (%eax),%eax
 6fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ff:	8b 42 04             	mov    0x4(%edx),%eax
 702:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 705:	39 f1                	cmp    %esi,%ecx
 707:	75 be                	jne    6c7 <free+0x47>
  freep = p;
 709:	89 15 c0 08 00 00    	mov    %edx,0x8c0
    p->s.size += bp->s.size;
 70f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 712:	01 c8                	add    %ecx,%eax
 714:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 717:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 71a:	89 0a                	mov    %ecx,(%edx)
}
 71c:	5b                   	pop    %ebx
 71d:	5e                   	pop    %esi
 71e:	5f                   	pop    %edi
 71f:	5d                   	pop    %ebp
 720:	c3                   	ret
 721:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 728:	00 
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000730 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 739:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 73c:	8b 15 c0 08 00 00    	mov    0x8c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 742:	8d 78 07             	lea    0x7(%eax),%edi
 745:	c1 ef 03             	shr    $0x3,%edi
 748:	47                   	inc    %edi
  if((prevp = freep) == 0){
 749:	85 d2                	test   %edx,%edx
 74b:	0f 84 8f 00 00 00    	je     7e0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 751:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 753:	8b 48 04             	mov    0x4(%eax),%ecx
 756:	39 f9                	cmp    %edi,%ecx
 758:	73 5e                	jae    7b8 <malloc+0x88>
  if(nu < 4096)
 75a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 75f:	39 df                	cmp    %ebx,%edi
 761:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 764:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 76b:	eb 0c                	jmp    779 <malloc+0x49>
 76d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 772:	8b 48 04             	mov    0x4(%eax),%ecx
 775:	39 f9                	cmp    %edi,%ecx
 777:	73 3f                	jae    7b8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 779:	39 05 c0 08 00 00    	cmp    %eax,0x8c0
 77f:	89 c2                	mov    %eax,%edx
 781:	75 ed                	jne    770 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 783:	89 34 24             	mov    %esi,(%esp)
 786:	e8 b0 fb ff ff       	call   33b <sbrk>
  if(p == (char*)-1)
 78b:	83 f8 ff             	cmp    $0xffffffff,%eax
 78e:	74 18                	je     7a8 <malloc+0x78>
  hp->s.size = nu;
 790:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 793:	83 c0 08             	add    $0x8,%eax
 796:	89 04 24             	mov    %eax,(%esp)
 799:	e8 e2 fe ff ff       	call   680 <free>
  return freep;
 79e:	8b 15 c0 08 00 00    	mov    0x8c0,%edx
      if((p = morecore(nunits)) == 0)
 7a4:	85 d2                	test   %edx,%edx
 7a6:	75 c8                	jne    770 <malloc+0x40>
        return 0;
  }
}
 7a8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 7ab:	31 c0                	xor    %eax,%eax
}
 7ad:	5b                   	pop    %ebx
 7ae:	5e                   	pop    %esi
 7af:	5f                   	pop    %edi
 7b0:	5d                   	pop    %ebp
 7b1:	c3                   	ret
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7b8:	39 cf                	cmp    %ecx,%edi
 7ba:	74 54                	je     810 <malloc+0xe0>
        p->s.size -= nunits;
 7bc:	29 f9                	sub    %edi,%ecx
 7be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7c4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7c7:	89 15 c0 08 00 00    	mov    %edx,0x8c0
}
 7cd:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 7d0:	83 c0 08             	add    $0x8,%eax
}
 7d3:	5b                   	pop    %ebx
 7d4:	5e                   	pop    %esi
 7d5:	5f                   	pop    %edi
 7d6:	5d                   	pop    %ebp
 7d7:	c3                   	ret
 7d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7df:	00 
    base.s.ptr = freep = prevp = &base;
 7e0:	b8 c4 08 00 00       	mov    $0x8c4,%eax
 7e5:	ba c4 08 00 00       	mov    $0x8c4,%edx
 7ea:	a3 c0 08 00 00       	mov    %eax,0x8c0
    base.s.size = 0;
 7ef:	31 c9                	xor    %ecx,%ecx
 7f1:	b8 c4 08 00 00       	mov    $0x8c4,%eax
    base.s.ptr = freep = prevp = &base;
 7f6:	89 15 c4 08 00 00    	mov    %edx,0x8c4
    base.s.size = 0;
 7fc:	89 0d c8 08 00 00    	mov    %ecx,0x8c8
    if(p->s.size >= nunits){
 802:	e9 53 ff ff ff       	jmp    75a <malloc+0x2a>
 807:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 80e:	00 
 80f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb b1                	jmp    7c7 <malloc+0x97>
