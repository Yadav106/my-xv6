
_t_getpgtablesize:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
    printf(1, "Page Table Size %d Pages\n", get_pgtb_size());
   9:	e8 fd 03 00 00       	call   40b <get_pgtb_size>
   e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  15:	89 44 24 08          	mov    %eax,0x8(%esp)
  19:	b8 98 08 00 00       	mov    $0x898,%eax
  1e:	89 44 24 04          	mov    %eax,0x4(%esp)
  22:	e8 c9 04 00 00       	call   4f0 <printf>
    printf(1, "User Pages Table Size %d Pages\n", get_usr_pgtb_size());
  27:	e8 e7 03 00 00       	call   413 <get_usr_pgtb_size>
  2c:	ba bc 08 00 00       	mov    $0x8bc,%edx
  31:	89 54 24 04          	mov    %edx,0x4(%esp)
  35:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3c:	89 44 24 08          	mov    %eax,0x8(%esp)
  40:	e8 ab 04 00 00       	call   4f0 <printf>
    printf(1, "kernel Pages Table Size %d Pages\n", get_kernel_pgtb_size());
  45:	e8 d1 03 00 00       	call   41b <get_kernel_pgtb_size>
  4a:	b9 dc 08 00 00       	mov    $0x8dc,%ecx
  4f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  53:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5a:	89 44 24 08          	mov    %eax,0x8(%esp)
  5e:	e8 8d 04 00 00       	call   4f0 <printf>
    sbrk(4096 * 4096);
  63:	c7 04 24 00 00 00 01 	movl   $0x1000000,(%esp)
  6a:	e8 4c 03 00 00       	call   3bb <sbrk>
    printf(1,"------------Doing sbrk-----------\n");
  6f:	b8 00 09 00 00       	mov    $0x900,%eax
  74:	89 44 24 04          	mov    %eax,0x4(%esp)
  78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7f:	e8 6c 04 00 00       	call   4f0 <printf>
    printf(1, "Page Table Size %d Pages\n", get_pgtb_size());
  84:	e8 82 03 00 00       	call   40b <get_pgtb_size>
  89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  90:	89 44 24 08          	mov    %eax,0x8(%esp)
  94:	b8 98 08 00 00       	mov    $0x898,%eax
  99:	89 44 24 04          	mov    %eax,0x4(%esp)
  9d:	e8 4e 04 00 00       	call   4f0 <printf>
    printf(1, "User Pages Table Size %d Pages\n", get_usr_pgtb_size());
  a2:	e8 6c 03 00 00       	call   413 <get_usr_pgtb_size>
  a7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ae:	89 44 24 08          	mov    %eax,0x8(%esp)
  b2:	b8 bc 08 00 00       	mov    $0x8bc,%eax
  b7:	89 44 24 04          	mov    %eax,0x4(%esp)
  bb:	e8 30 04 00 00       	call   4f0 <printf>
    printf(1, "kernel Pages Table Size %d Pages\n", get_kernel_pgtb_size());
  c0:	e8 56 03 00 00       	call   41b <get_kernel_pgtb_size>
  c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cc:	89 44 24 08          	mov    %eax,0x8(%esp)
  d0:	b8 dc 08 00 00       	mov    $0x8dc,%eax
  d5:	89 44 24 04          	mov    %eax,0x4(%esp)
  d9:	e8 12 04 00 00       	call   4f0 <printf>
    exit();
  de:	e8 50 02 00 00       	call   333 <exit>
  e3:	66 90                	xchg   %ax,%ax
  e5:	66 90                	xchg   %ax,%ax
  e7:	66 90                	xchg   %ax,%ax
  e9:	66 90                	xchg   %ax,%ax
  eb:	66 90                	xchg   %ax,%ax
  ed:	66 90                	xchg   %ax,%ax
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f1:	31 c0                	xor    %eax,%eax
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	53                   	push   %ebx
  f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 100:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 104:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 107:	40                   	inc    %eax
 108:	84 d2                	test   %dl,%dl
 10a:	75 f4                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 10c:	5b                   	pop    %ebx
 10d:	89 c8                	mov    %ecx,%eax
 10f:	5d                   	pop    %ebp
 110:	c3                   	ret
 111:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 118:	00 
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 55 08             	mov    0x8(%ebp),%edx
 127:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 12a:	0f b6 02             	movzbl (%edx),%eax
 12d:	84 c0                	test   %al,%al
 12f:	75 15                	jne    146 <strcmp+0x26>
 131:	eb 30                	jmp    163 <strcmp+0x43>
 133:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 138:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 13c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 13f:	42                   	inc    %edx
  while(*p && *p == *q)
 140:	84 c0                	test   %al,%al
 142:	74 14                	je     158 <strcmp+0x38>
 144:	89 cb                	mov    %ecx,%ebx
 146:	0f b6 0b             	movzbl (%ebx),%ecx
 149:	38 c1                	cmp    %al,%cl
 14b:	74 eb                	je     138 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 14d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 14e:	29 c8                	sub    %ecx,%eax
}
 150:	5d                   	pop    %ebp
 151:	c3                   	ret
 152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 158:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 15c:	31 c0                	xor    %eax,%eax
}
 15e:	5b                   	pop    %ebx
 15f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 160:	29 c8                	sub    %ecx,%eax
}
 162:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 163:	0f b6 0b             	movzbl (%ebx),%ecx
 166:	31 c0                	xor    %eax,%eax
 168:	eb e3                	jmp    14d <strcmp+0x2d>
 16a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000170 <strlen>:

uint
strlen(const char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 3a 00             	cmpb   $0x0,(%edx)
 179:	74 15                	je     190 <strlen+0x20>
 17b:	31 c0                	xor    %eax,%eax
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	40                   	inc    %eax
 181:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 185:	89 c1                	mov    %eax,%ecx
 187:	75 f7                	jne    180 <strlen+0x10>
    ;
  return n;
}
 189:	5d                   	pop    %ebp
 18a:	89 c8                	mov    %ecx,%eax
 18c:	c3                   	ret
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 191:	31 c9                	xor    %ecx,%ecx
}
 193:	89 c8                	mov    %ecx,%eax
 195:	c3                   	ret
 196:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19d:	00 
 19e:	66 90                	xchg   %ax,%ax

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
 1a6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	5f                   	pop    %edi
 1b3:	89 d0                	mov    %edx,%eax
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret
 1b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1be:	00 
 1bf:	90                   	nop

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	75 10                	jne    1e1 <strchr+0x21>
 1d1:	eb 1d                	jmp    1f0 <strchr+0x30>
 1d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1dc:	40                   	inc    %eax
 1dd:	84 d2                	test   %dl,%dl
 1df:	74 0f                	je     1f0 <strchr+0x30>
    if(*s == c)
 1e1:	38 d1                	cmp    %dl,%cl
 1e3:	75 f3                	jne    1d8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret
 1e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ee:	00 
 1ef:	90                   	nop
 1f0:	5d                   	pop    %ebp
  return 0;
 1f1:	31 c0                	xor    %eax,%eax
}
 1f3:	c3                   	ret
 1f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1fb:	00 
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 205:	31 f6                	xor    %esi,%esi
{
 207:	53                   	push   %ebx
    cc = read(0, &c, 1);
 208:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 20b:	83 ec 3c             	sub    $0x3c,%esp
 20e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 211:	eb 32                	jmp    245 <gets+0x45>
 213:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 218:	89 7c 24 04          	mov    %edi,0x4(%esp)
 21c:	b8 01 00 00 00       	mov    $0x1,%eax
 221:	89 44 24 08          	mov    %eax,0x8(%esp)
 225:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 22c:	e8 1a 01 00 00       	call   34b <read>
    if(cc < 1)
 231:	85 c0                	test   %eax,%eax
 233:	7e 19                	jle    24e <gets+0x4e>
      break;
    buf[i++] = c;
 235:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 239:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 23d:	3c 0a                	cmp    $0xa,%al
 23f:	74 10                	je     251 <gets+0x51>
 241:	3c 0d                	cmp    $0xd,%al
 243:	74 0c                	je     251 <gets+0x51>
  for(i=0; i+1 < max; ){
 245:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 248:	46                   	inc    %esi
 249:	3b 75 0c             	cmp    0xc(%ebp),%esi
 24c:	7c ca                	jl     218 <gets+0x18>
 24e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 251:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 255:	83 c4 3c             	add    $0x3c,%esp
 258:	89 d8                	mov    %ebx,%eax
 25a:	5b                   	pop    %ebx
 25b:	5e                   	pop    %esi
 25c:	5f                   	pop    %edi
 25d:	5d                   	pop    %ebp
 25e:	c3                   	ret
 25f:	90                   	nop

00000260 <stat>:

int
stat(const char *n, struct stat *st)
{
 260:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 261:	31 c0                	xor    %eax,%eax
{
 263:	89 e5                	mov    %esp,%ebp
 265:	83 ec 18             	sub    $0x18,%esp
 268:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 26b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 26e:	89 44 24 04          	mov    %eax,0x4(%esp)
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	89 04 24             	mov    %eax,(%esp)
 278:	e8 f6 00 00 00       	call   373 <open>
  if(fd < 0)
 27d:	85 c0                	test   %eax,%eax
 27f:	78 2f                	js     2b0 <stat+0x50>
 281:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 283:	8b 45 0c             	mov    0xc(%ebp),%eax
 286:	89 1c 24             	mov    %ebx,(%esp)
 289:	89 44 24 04          	mov    %eax,0x4(%esp)
 28d:	e8 f9 00 00 00       	call   38b <fstat>
  close(fd);
 292:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 295:	89 c6                	mov    %eax,%esi
  close(fd);
 297:	e8 bf 00 00 00       	call   35b <close>
  return r;
}
 29c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 29f:	89 f0                	mov    %esi,%eax
 2a1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2a4:	89 ec                	mov    %ebp,%esp
 2a6:	5d                   	pop    %ebp
 2a7:	c3                   	ret
 2a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2af:	00 
    return -1;
 2b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2b5:	eb e5                	jmp    29c <stat+0x3c>
 2b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2be:	00 
 2bf:	90                   	nop

000002c0 <atoi>:

int
atoi(const char *s)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c7:	0f be 02             	movsbl (%edx),%eax
 2ca:	88 c1                	mov    %al,%cl
 2cc:	80 e9 30             	sub    $0x30,%cl
 2cf:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2d2:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2d7:	77 1c                	ja     2f5 <atoi+0x35>
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2e0:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2e3:	42                   	inc    %edx
 2e4:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2e8:	0f be 02             	movsbl (%edx),%eax
 2eb:	88 c3                	mov    %al,%bl
 2ed:	80 eb 30             	sub    $0x30,%bl
 2f0:	80 fb 09             	cmp    $0x9,%bl
 2f3:	76 eb                	jbe    2e0 <atoi+0x20>
  return n;
}
 2f5:	5b                   	pop    %ebx
 2f6:	89 c8                	mov    %ecx,%eax
 2f8:	5d                   	pop    %ebp
 2f9:	c3                   	ret
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000300 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	8b 45 10             	mov    0x10(%ebp),%eax
 307:	56                   	push   %esi
 308:	8b 55 08             	mov    0x8(%ebp),%edx
 30b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 30e:	85 c0                	test   %eax,%eax
 310:	7e 13                	jle    325 <memmove+0x25>
 312:	01 d0                	add    %edx,%eax
  dst = vdst;
 314:	89 d7                	mov    %edx,%edi
 316:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31d:	00 
 31e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 320:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 321:	39 f8                	cmp    %edi,%eax
 323:	75 fb                	jne    320 <memmove+0x20>
  return vdst;
}
 325:	5e                   	pop    %esi
 326:	89 d0                	mov    %edx,%eax
 328:	5f                   	pop    %edi
 329:	5d                   	pop    %ebp
 32a:	c3                   	ret

0000032b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32b:	b8 01 00 00 00       	mov    $0x1,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <exit>:
SYSCALL(exit)
 333:	b8 02 00 00 00       	mov    $0x2,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <wait>:
SYSCALL(wait)
 33b:	b8 03 00 00 00       	mov    $0x3,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <pipe>:
SYSCALL(pipe)
 343:	b8 04 00 00 00       	mov    $0x4,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <read>:
SYSCALL(read)
 34b:	b8 05 00 00 00       	mov    $0x5,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <write>:
SYSCALL(write)
 353:	b8 10 00 00 00       	mov    $0x10,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <close>:
SYSCALL(close)
 35b:	b8 15 00 00 00       	mov    $0x15,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <kill>:
SYSCALL(kill)
 363:	b8 06 00 00 00       	mov    $0x6,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <exec>:
SYSCALL(exec)
 36b:	b8 07 00 00 00       	mov    $0x7,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <open>:
SYSCALL(open)
 373:	b8 0f 00 00 00       	mov    $0xf,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <mknod>:
SYSCALL(mknod)
 37b:	b8 11 00 00 00       	mov    $0x11,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <unlink>:
SYSCALL(unlink)
 383:	b8 12 00 00 00       	mov    $0x12,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <fstat>:
SYSCALL(fstat)
 38b:	b8 08 00 00 00       	mov    $0x8,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <link>:
SYSCALL(link)
 393:	b8 13 00 00 00       	mov    $0x13,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <mkdir>:
SYSCALL(mkdir)
 39b:	b8 14 00 00 00       	mov    $0x14,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <chdir>:
SYSCALL(chdir)
 3a3:	b8 09 00 00 00       	mov    $0x9,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <dup>:
SYSCALL(dup)
 3ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <getpid>:
SYSCALL(getpid)
 3b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <sbrk>:
SYSCALL(sbrk)
 3bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <sleep>:
SYSCALL(sleep)
 3c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <uptime>:
SYSCALL(uptime)
 3cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <worldpeace>:
SYSCALL(worldpeace)
 3d3:	b8 16 00 00 00       	mov    $0x16,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <numberofprocesses>:
SYSCALL(numberofprocesses)
 3db:	b8 17 00 00 00       	mov    $0x17,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <whatsthestatus>:
SYSCALL(whatsthestatus)
 3e3:	b8 18 00 00 00       	mov    $0x18,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <get_sibling>:
SYSCALL(get_sibling)
 3eb:	b8 19 00 00 00       	mov    $0x19,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <spawn>:
SYSCALL(spawn)
 3f3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <getvasize>:
SYSCALL(getvasize)
 3fb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <va2pa>:
SYSCALL(va2pa)
 403:	b8 1c 00 00 00       	mov    $0x1c,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 40b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 413:	b8 1e 00 00 00       	mov    $0x1e,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 41b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <getpasize>:
SYSCALL(getpasize)
 423:	b8 20 00 00 00       	mov    $0x20,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret
 42b:	66 90                	xchg   %ax,%ax
 42d:	66 90                	xchg   %ax,%ax
 42f:	90                   	nop

00000430 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	89 cb                	mov    %ecx,%ebx
 438:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 43b:	89 d1                	mov    %edx,%ecx
{
 43d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 440:	89 d0                	mov    %edx,%eax
 442:	c1 e8 1f             	shr    $0x1f,%eax
 445:	84 c0                	test   %al,%al
 447:	0f 84 93 00 00 00    	je     4e0 <printint+0xb0>
 44d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 451:	0f 84 89 00 00 00    	je     4e0 <printint+0xb0>
    x = -xx;
 457:	f7 d9                	neg    %ecx
    neg = 1;
 459:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 45e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 465:	8d 75 d7             	lea    -0x29(%ebp),%esi
 468:	89 45 b8             	mov    %eax,-0x48(%ebp)
 46b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 470:	89 c8                	mov    %ecx,%eax
 472:	31 d2                	xor    %edx,%edx
 474:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 477:	f7 f3                	div    %ebx
 479:	89 45 c0             	mov    %eax,-0x40(%ebp)
 47c:	0f b6 92 7c 09 00 00 	movzbl 0x97c(%edx),%edx
 483:	8d 47 01             	lea    0x1(%edi),%eax
 486:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 489:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 48d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 48f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 492:	39 da                	cmp    %ebx,%edx
 494:	73 da                	jae    470 <printint+0x40>
  if(neg)
 496:	8b 45 b8             	mov    -0x48(%ebp),%eax
 499:	85 c0                	test   %eax,%eax
 49b:	74 0a                	je     4a7 <printint+0x77>
    buf[i++] = '-';
 49d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4a0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 4a5:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 4a7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4aa:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 4ae:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 4b0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4b3:	89 74 24 04          	mov    %esi,0x4(%esp)
 4b7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4ba:	b8 01 00 00 00       	mov    $0x1,%eax
 4bf:	89 44 24 08          	mov    %eax,0x8(%esp)
 4c3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 4c6:	89 04 24             	mov    %eax,(%esp)
 4c9:	e8 85 fe ff ff       	call   353 <write>
  while(--i >= 0)
 4ce:	89 f8                	mov    %edi,%eax
 4d0:	4f                   	dec    %edi
 4d1:	39 d8                	cmp    %ebx,%eax
 4d3:	75 db                	jne    4b0 <printint+0x80>
}
 4d5:	83 c4 4c             	add    $0x4c,%esp
 4d8:	5b                   	pop    %ebx
 4d9:	5e                   	pop    %esi
 4da:	5f                   	pop    %edi
 4db:	5d                   	pop    %ebp
 4dc:	c3                   	ret
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 4e0:	31 c0                	xor    %eax,%eax
 4e2:	e9 77 ff ff ff       	jmp    45e <printint+0x2e>
 4e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ee:	00 
 4ef:	90                   	nop

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4fc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4ff:	0f b6 13             	movzbl (%ebx),%edx
 502:	43                   	inc    %ebx
 503:	84 d2                	test   %dl,%dl
 505:	74 35                	je     53c <printf+0x4c>
 507:	8d 45 10             	lea    0x10(%ebp),%eax
 50a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 50d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 510:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 513:	83 f8 25             	cmp    $0x25,%eax
 516:	74 30                	je     548 <printf+0x58>
  write(fd, &c, 1);
 518:	89 34 24             	mov    %esi,(%esp)
 51b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 520:	43                   	inc    %ebx
  write(fd, &c, 1);
 521:	89 44 24 08          	mov    %eax,0x8(%esp)
 525:	8d 45 e7             	lea    -0x19(%ebp),%eax
 528:	89 44 24 04          	mov    %eax,0x4(%esp)
 52c:	88 55 e7             	mov    %dl,-0x19(%ebp)
 52f:	e8 1f fe ff ff       	call   353 <write>
  for(i = 0; fmt[i]; i++){
 534:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 538:	84 d2                	test   %dl,%dl
 53a:	75 d4                	jne    510 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 53c:	83 c4 3c             	add    $0x3c,%esp
 53f:	5b                   	pop    %ebx
 540:	5e                   	pop    %esi
 541:	5f                   	pop    %edi
 542:	5d                   	pop    %ebp
 543:	c3                   	ret
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 548:	0f b6 13             	movzbl (%ebx),%edx
 54b:	84 d2                	test   %dl,%dl
 54d:	74 ed                	je     53c <printf+0x4c>
    c = fmt[i] & 0xff;
 54f:	80 fa 25             	cmp    $0x25,%dl
 552:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 555:	0f 84 75 01 00 00    	je     6d0 <printf+0x1e0>
 55b:	83 e8 63             	sub    $0x63,%eax
 55e:	83 f8 15             	cmp    $0x15,%eax
 561:	77 0d                	ja     570 <printf+0x80>
 563:	ff 24 85 24 09 00 00 	jmp    *0x924(,%eax,4)
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 570:	89 34 24             	mov    %esi,(%esp)
 573:	8d 7d e7             	lea    -0x19(%ebp),%edi
 576:	b8 01 00 00 00       	mov    $0x1,%eax
 57b:	89 44 24 08          	mov    %eax,0x8(%esp)
 57f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 583:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 586:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 58a:	e8 c4 fd ff ff       	call   353 <write>
        putc(fd, c);
 58f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 593:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 596:	ba 01 00 00 00       	mov    $0x1,%edx
 59b:	89 54 24 08          	mov    %edx,0x8(%esp)
 59f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 5a3:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 5a6:	89 34 24             	mov    %esi,(%esp)
 5a9:	e8 a5 fd ff ff       	call   353 <write>
  for(i = 0; fmt[i]; i++){
 5ae:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5b2:	84 d2                	test   %dl,%dl
 5b4:	0f 85 56 ff ff ff    	jne    510 <printf+0x20>
}
 5ba:	83 c4 3c             	add    $0x3c,%esp
 5bd:	5b                   	pop    %ebx
 5be:	5e                   	pop    %esi
 5bf:	5f                   	pop    %edi
 5c0:	5d                   	pop    %ebp
 5c1:	c3                   	ret
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5c8:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5cb:	b9 10 00 00 00       	mov    $0x10,%ecx
 5d0:	8b 17                	mov    (%edi),%edx
 5d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 5d9:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 5dc:	89 f0                	mov    %esi,%eax
 5de:	e8 4d fe ff ff       	call   430 <printint>
  for(i = 0; fmt[i]; i++){
 5e3:	83 c3 02             	add    $0x2,%ebx
        ap++;
 5e6:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5e9:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5ed:	84 d2                	test   %dl,%dl
 5ef:	0f 85 1b ff ff ff    	jne    510 <printf+0x20>
}
 5f5:	83 c4 3c             	add    $0x3c,%esp
 5f8:	5b                   	pop    %ebx
 5f9:	5e                   	pop    %esi
 5fa:	5f                   	pop    %edi
 5fb:	5d                   	pop    %ebp
 5fc:	c3                   	ret
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 600:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 603:	8b 01                	mov    (%ecx),%eax
        ap++;
 605:	83 c1 04             	add    $0x4,%ecx
 608:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 60b:	85 c0                	test   %eax,%eax
 60d:	0f 84 d5 00 00 00    	je     6e8 <printf+0x1f8>
        while(*s != 0){
 613:	0f b6 10             	movzbl (%eax),%edx
 616:	84 d2                	test   %dl,%dl
 618:	74 39                	je     653 <printf+0x163>
 61a:	89 c7                	mov    %eax,%edi
 61c:	88 d0                	mov    %dl,%al
 61e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 621:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 624:	89 fb                	mov    %edi,%ebx
 626:	89 cf                	mov    %ecx,%edi
 628:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 62f:	00 
          putc(fd, *s);
 630:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 633:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 638:	43                   	inc    %ebx
  write(fd, &c, 1);
 639:	89 44 24 08          	mov    %eax,0x8(%esp)
 63d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 641:	89 34 24             	mov    %esi,(%esp)
 644:	e8 0a fd ff ff       	call   353 <write>
        while(*s != 0){
 649:	0f b6 03             	movzbl (%ebx),%eax
 64c:	84 c0                	test   %al,%al
 64e:	75 e0                	jne    630 <printf+0x140>
 650:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 653:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 657:	83 c3 02             	add    $0x2,%ebx
 65a:	84 d2                	test   %dl,%dl
 65c:	0f 85 ae fe ff ff    	jne    510 <printf+0x20>
 662:	e9 d5 fe ff ff       	jmp    53c <printf+0x4c>
 667:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 66e:	00 
 66f:	90                   	nop
        printint(fd, *ap, 10, 1);
 670:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 673:	b9 0a 00 00 00       	mov    $0xa,%ecx
 678:	8b 17                	mov    (%edi),%edx
 67a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 681:	e9 53 ff ff ff       	jmp    5d9 <printf+0xe9>
 686:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 68d:	00 
 68e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 690:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 693:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 698:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 69b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 69d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 6a1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 6a4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6a8:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 6ab:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 6ae:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 6b2:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6b5:	e8 99 fc ff ff       	call   353 <write>
        ap++;
 6ba:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 6be:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6c2:	84 d2                	test   %dl,%dl
 6c4:	0f 85 46 fe ff ff    	jne    510 <printf+0x20>
 6ca:	e9 6d fe ff ff       	jmp    53c <printf+0x4c>
 6cf:	90                   	nop
        putc(fd, c);
 6d0:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 6d3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 6d6:	b9 01 00 00 00       	mov    $0x1,%ecx
 6db:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 6df:	e9 bb fe ff ff       	jmp    59f <printf+0xaf>
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 6e8:	bf b2 08 00 00       	mov    $0x8b2,%edi
 6ed:	b0 28                	mov    $0x28,%al
 6ef:	e9 2a ff ff ff       	jmp    61e <printf+0x12e>
 6f4:	66 90                	xchg   %ax,%ax
 6f6:	66 90                	xchg   %ax,%ax
 6f8:	66 90                	xchg   %ax,%ax
 6fa:	66 90                	xchg   %ax,%ax
 6fc:	66 90                	xchg   %ax,%ax
 6fe:	66 90                	xchg   %ax,%ax

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 90 09 00 00       	mov    0x990,%eax
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 70e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 718:	00 
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 720:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 722:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 724:	39 ca                	cmp    %ecx,%edx
 726:	73 30                	jae    758 <free+0x58>
 728:	39 c1                	cmp    %eax,%ecx
 72a:	72 04                	jb     730 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72c:	39 c2                	cmp    %eax,%edx
 72e:	72 f0                	jb     720 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 730:	8b 73 fc             	mov    -0x4(%ebx),%esi
 733:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 736:	39 f8                	cmp    %edi,%eax
 738:	74 36                	je     770 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 73a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 73d:	8b 42 04             	mov    0x4(%edx),%eax
 740:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 743:	39 f1                	cmp    %esi,%ecx
 745:	74 42                	je     789 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 747:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 749:	5b                   	pop    %ebx
  freep = p;
 74a:	89 15 90 09 00 00    	mov    %edx,0x990
}
 750:	5e                   	pop    %esi
 751:	5f                   	pop    %edi
 752:	5d                   	pop    %ebp
 753:	c3                   	ret
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 758:	39 c2                	cmp    %eax,%edx
 75a:	72 c4                	jb     720 <free+0x20>
 75c:	39 c1                	cmp    %eax,%ecx
 75e:	73 c0                	jae    720 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 760:	8b 73 fc             	mov    -0x4(%ebx),%esi
 763:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 766:	39 f8                	cmp    %edi,%eax
 768:	75 d0                	jne    73a <free+0x3a>
 76a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 770:	8b 78 04             	mov    0x4(%eax),%edi
 773:	01 fe                	add    %edi,%esi
 775:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 778:	8b 02                	mov    (%edx),%eax
 77a:	8b 00                	mov    (%eax),%eax
 77c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 77f:	8b 42 04             	mov    0x4(%edx),%eax
 782:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 785:	39 f1                	cmp    %esi,%ecx
 787:	75 be                	jne    747 <free+0x47>
  freep = p;
 789:	89 15 90 09 00 00    	mov    %edx,0x990
    p->s.size += bp->s.size;
 78f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 792:	01 c8                	add    %ecx,%eax
 794:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 797:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 79a:	89 0a                	mov    %ecx,(%edx)
}
 79c:	5b                   	pop    %ebx
 79d:	5e                   	pop    %esi
 79e:	5f                   	pop    %edi
 79f:	5d                   	pop    %ebp
 7a0:	c3                   	ret
 7a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7a8:	00 
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7bc:	8b 15 90 09 00 00    	mov    0x990,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c2:	8d 78 07             	lea    0x7(%eax),%edi
 7c5:	c1 ef 03             	shr    $0x3,%edi
 7c8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 7c9:	85 d2                	test   %edx,%edx
 7cb:	0f 84 8f 00 00 00    	je     860 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7d3:	8b 48 04             	mov    0x4(%eax),%ecx
 7d6:	39 f9                	cmp    %edi,%ecx
 7d8:	73 5e                	jae    838 <malloc+0x88>
  if(nu < 4096)
 7da:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7df:	39 df                	cmp    %ebx,%edi
 7e1:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7e4:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7eb:	eb 0c                	jmp    7f9 <malloc+0x49>
 7ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7f2:	8b 48 04             	mov    0x4(%eax),%ecx
 7f5:	39 f9                	cmp    %edi,%ecx
 7f7:	73 3f                	jae    838 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f9:	39 05 90 09 00 00    	cmp    %eax,0x990
 7ff:	89 c2                	mov    %eax,%edx
 801:	75 ed                	jne    7f0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 803:	89 34 24             	mov    %esi,(%esp)
 806:	e8 b0 fb ff ff       	call   3bb <sbrk>
  if(p == (char*)-1)
 80b:	83 f8 ff             	cmp    $0xffffffff,%eax
 80e:	74 18                	je     828 <malloc+0x78>
  hp->s.size = nu;
 810:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 813:	83 c0 08             	add    $0x8,%eax
 816:	89 04 24             	mov    %eax,(%esp)
 819:	e8 e2 fe ff ff       	call   700 <free>
  return freep;
 81e:	8b 15 90 09 00 00    	mov    0x990,%edx
      if((p = morecore(nunits)) == 0)
 824:	85 d2                	test   %edx,%edx
 826:	75 c8                	jne    7f0 <malloc+0x40>
        return 0;
  }
}
 828:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 82b:	31 c0                	xor    %eax,%eax
}
 82d:	5b                   	pop    %ebx
 82e:	5e                   	pop    %esi
 82f:	5f                   	pop    %edi
 830:	5d                   	pop    %ebp
 831:	c3                   	ret
 832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 838:	39 cf                	cmp    %ecx,%edi
 83a:	74 54                	je     890 <malloc+0xe0>
        p->s.size -= nunits;
 83c:	29 f9                	sub    %edi,%ecx
 83e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 841:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 844:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 847:	89 15 90 09 00 00    	mov    %edx,0x990
}
 84d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 850:	83 c0 08             	add    $0x8,%eax
}
 853:	5b                   	pop    %ebx
 854:	5e                   	pop    %esi
 855:	5f                   	pop    %edi
 856:	5d                   	pop    %ebp
 857:	c3                   	ret
 858:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 85f:	00 
    base.s.ptr = freep = prevp = &base;
 860:	b8 94 09 00 00       	mov    $0x994,%eax
 865:	ba 94 09 00 00       	mov    $0x994,%edx
 86a:	a3 90 09 00 00       	mov    %eax,0x990
    base.s.size = 0;
 86f:	31 c9                	xor    %ecx,%ecx
 871:	b8 94 09 00 00       	mov    $0x994,%eax
    base.s.ptr = freep = prevp = &base;
 876:	89 15 94 09 00 00    	mov    %edx,0x994
    base.s.size = 0;
 87c:	89 0d 98 09 00 00    	mov    %ecx,0x998
    if(p->s.size >= nunits){
 882:	e9 53 ff ff ff       	jmp    7da <malloc+0x2a>
 887:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 88e:	00 
 88f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 890:	8b 08                	mov    (%eax),%ecx
 892:	89 0a                	mov    %ecx,(%edx)
 894:	eb b1                	jmp    847 <malloc+0x97>
