
_tva2pa:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#define EXTMEM 0x100000
#define KERNBASE 0x80000000          // First kernel virtual address
#define KERNLINK (KERNBASE + EXTMEM) // Address where kernel is linked

int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
  int N = 10;
   1:	b8 0a 00 00 00       	mov    $0xa,%eax
{
   6:	89 e5                	mov    %esp,%ebp
   8:	53                   	push   %ebx
   9:	83 e4 f0             	and    $0xfffffff0,%esp
   c:	83 ec 20             	sub    $0x20,%esp
  int N = 10;
   f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  int uva = (int)&N; // the virtual address of n
  13:	8d 5c 24 1c          	lea    0x1c(%esp),%ebx
  int kva1 = (int)(KERNLINK + 1024);
  int kva2 = (int)(KERNLINK + 2048);
  int kva3 = (int)(KERNLINK + 4096);
  int kva4 = (int)(KERNLINK + 5192);

  printf(1, "Physical Address of user   virtual address %p is %p\n", uva, va2pa(uva));
  17:	89 1c 24             	mov    %ebx,(%esp)
  1a:	e8 f4 03 00 00       	call   413 <va2pa>
  1f:	ba a8 08 00 00       	mov    $0x8a8,%edx
  24:	89 54 24 04          	mov    %edx,0x4(%esp)
  28:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  printf(1, "Physical Address of Kernel virtual address %p is %p\n", kva1, va2pa(kva1));
  2c:	bb e0 08 00 00       	mov    $0x8e0,%ebx
  printf(1, "Physical Address of user   virtual address %p is %p\n", uva, va2pa(uva));
  31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  38:	89 44 24 0c          	mov    %eax,0xc(%esp)
  3c:	e8 bf 04 00 00       	call   500 <printf>
  printf(1, "Physical Address of Kernel virtual address %p is %p\n", kva1, va2pa(kva1));
  41:	c7 04 24 00 04 10 80 	movl   $0x80100400,(%esp)
  48:	e8 c6 03 00 00       	call   413 <va2pa>
  4d:	b9 00 04 10 80       	mov    $0x80100400,%ecx
  52:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  56:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  5a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  61:	89 44 24 0c          	mov    %eax,0xc(%esp)
  65:	e8 96 04 00 00       	call   500 <printf>
  printf(1, "Physical Address of Kernel virtual address %p is %p\n", kva2, va2pa(kva2));
  6a:	c7 04 24 00 08 10 80 	movl   $0x80100800,(%esp)
  71:	e8 9d 03 00 00       	call   413 <va2pa>
  76:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  81:	b8 00 08 10 80       	mov    $0x80100800,%eax
  86:	89 44 24 08          	mov    %eax,0x8(%esp)
  8a:	b8 e0 08 00 00       	mov    $0x8e0,%eax
  8f:	89 44 24 04          	mov    %eax,0x4(%esp)
  93:	e8 68 04 00 00       	call   500 <printf>
  printf(1, "Physical Address of Kernel virtual address %p is %p\n", kva3, va2pa(kva3));
  98:	c7 04 24 00 10 10 80 	movl   $0x80101000,(%esp)
  9f:	e8 6f 03 00 00       	call   413 <va2pa>
  a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ab:	89 44 24 0c          	mov    %eax,0xc(%esp)
  af:	b8 00 10 10 80       	mov    $0x80101000,%eax
  b4:	89 44 24 08          	mov    %eax,0x8(%esp)
  b8:	b8 e0 08 00 00       	mov    $0x8e0,%eax
  bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  c1:	e8 3a 04 00 00       	call   500 <printf>
  printf(1, "Physical Address of Kernel virtual address %p is %p\n", kva4, va2pa(kva4));
  c6:	c7 04 24 48 14 10 80 	movl   $0x80101448,(%esp)
  cd:	e8 41 03 00 00       	call   413 <va2pa>
  d2:	ba e0 08 00 00       	mov    $0x8e0,%edx
  d7:	89 54 24 04          	mov    %edx,0x4(%esp)
  db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  e6:	b8 48 14 10 80       	mov    $0x80101448,%eax
  eb:	89 44 24 08          	mov    %eax,0x8(%esp)
  ef:	e8 0c 04 00 00       	call   500 <printf>

  exit();
  f4:	e8 4a 02 00 00       	call   343 <exit>
  f9:	66 90                	xchg   %ax,%ax
  fb:	66 90                	xchg   %ax,%ax
  fd:	66 90                	xchg   %ax,%ax
  ff:	90                   	nop

00000100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 100:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 101:	31 c0                	xor    %eax,%eax
{
 103:	89 e5                	mov    %esp,%ebp
 105:	53                   	push   %ebx
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 110:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 114:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 117:	40                   	inc    %eax
 118:	84 d2                	test   %dl,%dl
 11a:	75 f4                	jne    110 <strcpy+0x10>
    ;
  return os;
}
 11c:	5b                   	pop    %ebx
 11d:	89 c8                	mov    %ecx,%eax
 11f:	5d                   	pop    %ebp
 120:	c3                   	ret
 121:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 128:	00 
 129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	75 15                	jne    156 <strcmp+0x26>
 141:	eb 30                	jmp    173 <strcmp+0x43>
 143:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 148:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 14c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 14f:	42                   	inc    %edx
  while(*p && *p == *q)
 150:	84 c0                	test   %al,%al
 152:	74 14                	je     168 <strcmp+0x38>
 154:	89 cb                	mov    %ecx,%ebx
 156:	0f b6 0b             	movzbl (%ebx),%ecx
 159:	38 c1                	cmp    %al,%cl
 15b:	74 eb                	je     148 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 15d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 15e:	29 c8                	sub    %ecx,%eax
}
 160:	5d                   	pop    %ebp
 161:	c3                   	ret
 162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 168:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 16c:	31 c0                	xor    %eax,%eax
}
 16e:	5b                   	pop    %ebx
 16f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 170:	29 c8                	sub    %ecx,%eax
}
 172:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 173:	0f b6 0b             	movzbl (%ebx),%ecx
 176:	31 c0                	xor    %eax,%eax
 178:	eb e3                	jmp    15d <strcmp+0x2d>
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <strlen>:

uint
strlen(const char *s)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 186:	80 3a 00             	cmpb   $0x0,(%edx)
 189:	74 15                	je     1a0 <strlen+0x20>
 18b:	31 c0                	xor    %eax,%eax
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	40                   	inc    %eax
 191:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 195:	89 c1                	mov    %eax,%ecx
 197:	75 f7                	jne    190 <strlen+0x10>
    ;
  return n;
}
 199:	5d                   	pop    %ebp
 19a:	89 c8                	mov    %ecx,%eax
 19c:	c3                   	ret
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 1a1:	31 c9                	xor    %ecx,%ecx
}
 1a3:	89 c8                	mov    %ecx,%eax
 1a5:	c3                   	ret
 1a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ad:	00 
 1ae:	66 90                	xchg   %ax,%ax

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
 1b6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bd:	89 d7                	mov    %edx,%edi
 1bf:	fc                   	cld
 1c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1c2:	5f                   	pop    %edi
 1c3:	89 d0                	mov    %edx,%eax
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret
 1c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ce:	00 
 1cf:	90                   	nop

000001d0 <strchr>:

char*
strchr(const char *s, char c)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1da:	0f b6 10             	movzbl (%eax),%edx
 1dd:	84 d2                	test   %dl,%dl
 1df:	75 10                	jne    1f1 <strchr+0x21>
 1e1:	eb 1d                	jmp    200 <strchr+0x30>
 1e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1ec:	40                   	inc    %eax
 1ed:	84 d2                	test   %dl,%dl
 1ef:	74 0f                	je     200 <strchr+0x30>
    if(*s == c)
 1f1:	38 d1                	cmp    %dl,%cl
 1f3:	75 f3                	jne    1e8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret
 1f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1fe:	00 
 1ff:	90                   	nop
 200:	5d                   	pop    %ebp
  return 0;
 201:	31 c0                	xor    %eax,%eax
}
 203:	c3                   	ret
 204:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20b:	00 
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 215:	31 f6                	xor    %esi,%esi
{
 217:	53                   	push   %ebx
    cc = read(0, &c, 1);
 218:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 21b:	83 ec 3c             	sub    $0x3c,%esp
 21e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 221:	eb 32                	jmp    255 <gets+0x45>
 223:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 228:	89 7c 24 04          	mov    %edi,0x4(%esp)
 22c:	b8 01 00 00 00       	mov    $0x1,%eax
 231:	89 44 24 08          	mov    %eax,0x8(%esp)
 235:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 23c:	e8 1a 01 00 00       	call   35b <read>
    if(cc < 1)
 241:	85 c0                	test   %eax,%eax
 243:	7e 19                	jle    25e <gets+0x4e>
      break;
    buf[i++] = c;
 245:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 249:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 24d:	3c 0a                	cmp    $0xa,%al
 24f:	74 10                	je     261 <gets+0x51>
 251:	3c 0d                	cmp    $0xd,%al
 253:	74 0c                	je     261 <gets+0x51>
  for(i=0; i+1 < max; ){
 255:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 258:	46                   	inc    %esi
 259:	3b 75 0c             	cmp    0xc(%ebp),%esi
 25c:	7c ca                	jl     228 <gets+0x18>
 25e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 261:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 265:	83 c4 3c             	add    $0x3c,%esp
 268:	89 d8                	mov    %ebx,%eax
 26a:	5b                   	pop    %ebx
 26b:	5e                   	pop    %esi
 26c:	5f                   	pop    %edi
 26d:	5d                   	pop    %ebp
 26e:	c3                   	ret
 26f:	90                   	nop

00000270 <stat>:

int
stat(const char *n, struct stat *st)
{
 270:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 271:	31 c0                	xor    %eax,%eax
{
 273:	89 e5                	mov    %esp,%ebp
 275:	83 ec 18             	sub    $0x18,%esp
 278:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 27b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 27e:	89 44 24 04          	mov    %eax,0x4(%esp)
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	89 04 24             	mov    %eax,(%esp)
 288:	e8 f6 00 00 00       	call   383 <open>
  if(fd < 0)
 28d:	85 c0                	test   %eax,%eax
 28f:	78 2f                	js     2c0 <stat+0x50>
 291:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 293:	8b 45 0c             	mov    0xc(%ebp),%eax
 296:	89 1c 24             	mov    %ebx,(%esp)
 299:	89 44 24 04          	mov    %eax,0x4(%esp)
 29d:	e8 f9 00 00 00       	call   39b <fstat>
  close(fd);
 2a2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2a5:	89 c6                	mov    %eax,%esi
  close(fd);
 2a7:	e8 bf 00 00 00       	call   36b <close>
  return r;
}
 2ac:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2af:	89 f0                	mov    %esi,%eax
 2b1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2b4:	89 ec                	mov    %ebp,%esp
 2b6:	5d                   	pop    %ebp
 2b7:	c3                   	ret
 2b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2bf:	00 
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb e5                	jmp    2ac <stat+0x3c>
 2c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ce:	00 
 2cf:	90                   	nop

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 02             	movsbl (%edx),%eax
 2da:	88 c1                	mov    %al,%cl
 2dc:	80 e9 30             	sub    $0x30,%cl
 2df:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2e2:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2e7:	77 1c                	ja     305 <atoi+0x35>
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2f0:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2f3:	42                   	inc    %edx
 2f4:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2f8:	0f be 02             	movsbl (%edx),%eax
 2fb:	88 c3                	mov    %al,%bl
 2fd:	80 eb 30             	sub    $0x30,%bl
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
  return n;
}
 305:	5b                   	pop    %ebx
 306:	89 c8                	mov    %ecx,%eax
 308:	5d                   	pop    %ebp
 309:	c3                   	ret
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	8b 45 10             	mov    0x10(%ebp),%eax
 317:	56                   	push   %esi
 318:	8b 55 08             	mov    0x8(%ebp),%edx
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	85 c0                	test   %eax,%eax
 320:	7e 13                	jle    335 <memmove+0x25>
 322:	01 d0                	add    %edx,%eax
  dst = vdst;
 324:	89 d7                	mov    %edx,%edi
 326:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 32d:	00 
 32e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 330:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 331:	39 f8                	cmp    %edi,%eax
 333:	75 fb                	jne    330 <memmove+0x20>
  return vdst;
}
 335:	5e                   	pop    %esi
 336:	89 d0                	mov    %edx,%eax
 338:	5f                   	pop    %edi
 339:	5d                   	pop    %ebp
 33a:	c3                   	ret

0000033b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33b:	b8 01 00 00 00       	mov    $0x1,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <exit>:
SYSCALL(exit)
 343:	b8 02 00 00 00       	mov    $0x2,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <wait>:
SYSCALL(wait)
 34b:	b8 03 00 00 00       	mov    $0x3,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <pipe>:
SYSCALL(pipe)
 353:	b8 04 00 00 00       	mov    $0x4,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <read>:
SYSCALL(read)
 35b:	b8 05 00 00 00       	mov    $0x5,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <write>:
SYSCALL(write)
 363:	b8 10 00 00 00       	mov    $0x10,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <close>:
SYSCALL(close)
 36b:	b8 15 00 00 00       	mov    $0x15,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <kill>:
SYSCALL(kill)
 373:	b8 06 00 00 00       	mov    $0x6,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <exec>:
SYSCALL(exec)
 37b:	b8 07 00 00 00       	mov    $0x7,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <open>:
SYSCALL(open)
 383:	b8 0f 00 00 00       	mov    $0xf,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <mknod>:
SYSCALL(mknod)
 38b:	b8 11 00 00 00       	mov    $0x11,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <unlink>:
SYSCALL(unlink)
 393:	b8 12 00 00 00       	mov    $0x12,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <fstat>:
SYSCALL(fstat)
 39b:	b8 08 00 00 00       	mov    $0x8,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <link>:
SYSCALL(link)
 3a3:	b8 13 00 00 00       	mov    $0x13,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <mkdir>:
SYSCALL(mkdir)
 3ab:	b8 14 00 00 00       	mov    $0x14,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <chdir>:
SYSCALL(chdir)
 3b3:	b8 09 00 00 00       	mov    $0x9,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <dup>:
SYSCALL(dup)
 3bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <getpid>:
SYSCALL(getpid)
 3c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <sbrk>:
SYSCALL(sbrk)
 3cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <sleep>:
SYSCALL(sleep)
 3d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <uptime>:
SYSCALL(uptime)
 3db:	b8 0e 00 00 00       	mov    $0xe,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <worldpeace>:
SYSCALL(worldpeace)
 3e3:	b8 16 00 00 00       	mov    $0x16,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <numberofprocesses>:
SYSCALL(numberofprocesses)
 3eb:	b8 17 00 00 00       	mov    $0x17,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <whatsthestatus>:
SYSCALL(whatsthestatus)
 3f3:	b8 18 00 00 00       	mov    $0x18,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <get_sibling>:
SYSCALL(get_sibling)
 3fb:	b8 19 00 00 00       	mov    $0x19,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <spawn>:
SYSCALL(spawn)
 403:	b8 1a 00 00 00       	mov    $0x1a,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <getvasize>:
SYSCALL(getvasize)
 40b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <va2pa>:
SYSCALL(va2pa)
 413:	b8 1c 00 00 00       	mov    $0x1c,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 41b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 423:	b8 1e 00 00 00       	mov    $0x1e,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 42b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <getpasize>:
SYSCALL(getpasize)
 433:	b8 20 00 00 00       	mov    $0x20,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret
 43b:	66 90                	xchg   %ax,%ax
 43d:	66 90                	xchg   %ax,%ax
 43f:	90                   	nop

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	89 cb                	mov    %ecx,%ebx
 448:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 44b:	89 d1                	mov    %edx,%ecx
{
 44d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 450:	89 d0                	mov    %edx,%eax
 452:	c1 e8 1f             	shr    $0x1f,%eax
 455:	84 c0                	test   %al,%al
 457:	0f 84 93 00 00 00    	je     4f0 <printint+0xb0>
 45d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 461:	0f 84 89 00 00 00    	je     4f0 <printint+0xb0>
    x = -xx;
 467:	f7 d9                	neg    %ecx
    neg = 1;
 469:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 46e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 475:	8d 75 d7             	lea    -0x29(%ebp),%esi
 478:	89 45 b8             	mov    %eax,-0x48(%ebp)
 47b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 480:	89 c8                	mov    %ecx,%eax
 482:	31 d2                	xor    %edx,%edx
 484:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 487:	f7 f3                	div    %ebx
 489:	89 45 c0             	mov    %eax,-0x40(%ebp)
 48c:	0f b6 92 74 09 00 00 	movzbl 0x974(%edx),%edx
 493:	8d 47 01             	lea    0x1(%edi),%eax
 496:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 499:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 49d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 49f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 4a2:	39 da                	cmp    %ebx,%edx
 4a4:	73 da                	jae    480 <printint+0x40>
  if(neg)
 4a6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 4a9:	85 c0                	test   %eax,%eax
 4ab:	74 0a                	je     4b7 <printint+0x77>
    buf[i++] = '-';
 4ad:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4b0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 4b5:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 4b7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4ba:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 4be:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 4c0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4c3:	89 74 24 04          	mov    %esi,0x4(%esp)
 4c7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4ca:	b8 01 00 00 00       	mov    $0x1,%eax
 4cf:	89 44 24 08          	mov    %eax,0x8(%esp)
 4d3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 4d6:	89 04 24             	mov    %eax,(%esp)
 4d9:	e8 85 fe ff ff       	call   363 <write>
  while(--i >= 0)
 4de:	89 f8                	mov    %edi,%eax
 4e0:	4f                   	dec    %edi
 4e1:	39 d8                	cmp    %ebx,%eax
 4e3:	75 db                	jne    4c0 <printint+0x80>
}
 4e5:	83 c4 4c             	add    $0x4c,%esp
 4e8:	5b                   	pop    %ebx
 4e9:	5e                   	pop    %esi
 4ea:	5f                   	pop    %edi
 4eb:	5d                   	pop    %ebp
 4ec:	c3                   	ret
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 4f0:	31 c0                	xor    %eax,%eax
 4f2:	e9 77 ff ff ff       	jmp    46e <printint+0x2e>
 4f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4fe:	00 
 4ff:	90                   	nop

00000500 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 509:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 50c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 50f:	0f b6 13             	movzbl (%ebx),%edx
 512:	43                   	inc    %ebx
 513:	84 d2                	test   %dl,%dl
 515:	74 35                	je     54c <printf+0x4c>
 517:	8d 45 10             	lea    0x10(%ebp),%eax
 51a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 51d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 520:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 523:	83 f8 25             	cmp    $0x25,%eax
 526:	74 30                	je     558 <printf+0x58>
  write(fd, &c, 1);
 528:	89 34 24             	mov    %esi,(%esp)
 52b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 530:	43                   	inc    %ebx
  write(fd, &c, 1);
 531:	89 44 24 08          	mov    %eax,0x8(%esp)
 535:	8d 45 e7             	lea    -0x19(%ebp),%eax
 538:	89 44 24 04          	mov    %eax,0x4(%esp)
 53c:	88 55 e7             	mov    %dl,-0x19(%ebp)
 53f:	e8 1f fe ff ff       	call   363 <write>
  for(i = 0; fmt[i]; i++){
 544:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 548:	84 d2                	test   %dl,%dl
 54a:	75 d4                	jne    520 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 54c:	83 c4 3c             	add    $0x3c,%esp
 54f:	5b                   	pop    %ebx
 550:	5e                   	pop    %esi
 551:	5f                   	pop    %edi
 552:	5d                   	pop    %ebp
 553:	c3                   	ret
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 558:	0f b6 13             	movzbl (%ebx),%edx
 55b:	84 d2                	test   %dl,%dl
 55d:	74 ed                	je     54c <printf+0x4c>
    c = fmt[i] & 0xff;
 55f:	80 fa 25             	cmp    $0x25,%dl
 562:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 565:	0f 84 75 01 00 00    	je     6e0 <printf+0x1e0>
 56b:	83 e8 63             	sub    $0x63,%eax
 56e:	83 f8 15             	cmp    $0x15,%eax
 571:	77 0d                	ja     580 <printf+0x80>
 573:	ff 24 85 1c 09 00 00 	jmp    *0x91c(,%eax,4)
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 580:	89 34 24             	mov    %esi,(%esp)
 583:	8d 7d e7             	lea    -0x19(%ebp),%edi
 586:	b8 01 00 00 00       	mov    $0x1,%eax
 58b:	89 44 24 08          	mov    %eax,0x8(%esp)
 58f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 593:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 596:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 59a:	e8 c4 fd ff ff       	call   363 <write>
        putc(fd, c);
 59f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 5a3:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5a6:	ba 01 00 00 00       	mov    $0x1,%edx
 5ab:	89 54 24 08          	mov    %edx,0x8(%esp)
 5af:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 5b3:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 5b6:	89 34 24             	mov    %esi,(%esp)
 5b9:	e8 a5 fd ff ff       	call   363 <write>
  for(i = 0; fmt[i]; i++){
 5be:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5c2:	84 d2                	test   %dl,%dl
 5c4:	0f 85 56 ff ff ff    	jne    520 <printf+0x20>
}
 5ca:	83 c4 3c             	add    $0x3c,%esp
 5cd:	5b                   	pop    %ebx
 5ce:	5e                   	pop    %esi
 5cf:	5f                   	pop    %edi
 5d0:	5d                   	pop    %ebp
 5d1:	c3                   	ret
 5d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5d8:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5db:	b9 10 00 00 00       	mov    $0x10,%ecx
 5e0:	8b 17                	mov    (%edi),%edx
 5e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 5e9:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 5ec:	89 f0                	mov    %esi,%eax
 5ee:	e8 4d fe ff ff       	call   440 <printint>
  for(i = 0; fmt[i]; i++){
 5f3:	83 c3 02             	add    $0x2,%ebx
        ap++;
 5f6:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5f9:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5fd:	84 d2                	test   %dl,%dl
 5ff:	0f 85 1b ff ff ff    	jne    520 <printf+0x20>
}
 605:	83 c4 3c             	add    $0x3c,%esp
 608:	5b                   	pop    %ebx
 609:	5e                   	pop    %esi
 60a:	5f                   	pop    %edi
 60b:	5d                   	pop    %ebp
 60c:	c3                   	ret
 60d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 610:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 613:	8b 01                	mov    (%ecx),%eax
        ap++;
 615:	83 c1 04             	add    $0x4,%ecx
 618:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 61b:	85 c0                	test   %eax,%eax
 61d:	0f 84 d5 00 00 00    	je     6f8 <printf+0x1f8>
        while(*s != 0){
 623:	0f b6 10             	movzbl (%eax),%edx
 626:	84 d2                	test   %dl,%dl
 628:	74 39                	je     663 <printf+0x163>
 62a:	89 c7                	mov    %eax,%edi
 62c:	88 d0                	mov    %dl,%al
 62e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 631:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 634:	89 fb                	mov    %edi,%ebx
 636:	89 cf                	mov    %ecx,%edi
 638:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 63f:	00 
          putc(fd, *s);
 640:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 643:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 648:	43                   	inc    %ebx
  write(fd, &c, 1);
 649:	89 44 24 08          	mov    %eax,0x8(%esp)
 64d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 651:	89 34 24             	mov    %esi,(%esp)
 654:	e8 0a fd ff ff       	call   363 <write>
        while(*s != 0){
 659:	0f b6 03             	movzbl (%ebx),%eax
 65c:	84 c0                	test   %al,%al
 65e:	75 e0                	jne    640 <printf+0x140>
 660:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 663:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 667:	83 c3 02             	add    $0x2,%ebx
 66a:	84 d2                	test   %dl,%dl
 66c:	0f 85 ae fe ff ff    	jne    520 <printf+0x20>
 672:	e9 d5 fe ff ff       	jmp    54c <printf+0x4c>
 677:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 67e:	00 
 67f:	90                   	nop
        printint(fd, *ap, 10, 1);
 680:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 683:	b9 0a 00 00 00       	mov    $0xa,%ecx
 688:	8b 17                	mov    (%edi),%edx
 68a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 691:	e9 53 ff ff ff       	jmp    5e9 <printf+0xe9>
 696:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 69d:	00 
 69e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 6a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 6a3:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 6a8:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 6ab:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 6ad:	89 7c 24 08          	mov    %edi,0x8(%esp)
 6b1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 6b4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6b8:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 6bb:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 6be:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 6c2:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6c5:	e8 99 fc ff ff       	call   363 <write>
        ap++;
 6ca:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 6ce:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6d2:	84 d2                	test   %dl,%dl
 6d4:	0f 85 46 fe ff ff    	jne    520 <printf+0x20>
 6da:	e9 6d fe ff ff       	jmp    54c <printf+0x4c>
 6df:	90                   	nop
        putc(fd, c);
 6e0:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 6e3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 6e6:	b9 01 00 00 00       	mov    $0x1,%ecx
 6eb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 6ef:	e9 bb fe ff ff       	jmp    5af <printf+0xaf>
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 6f8:	bf 15 09 00 00       	mov    $0x915,%edi
 6fd:	b0 28                	mov    $0x28,%al
 6ff:	e9 2a ff ff ff       	jmp    62e <printf+0x12e>
 704:	66 90                	xchg   %ax,%ax
 706:	66 90                	xchg   %ax,%ax
 708:	66 90                	xchg   %ax,%ax
 70a:	66 90                	xchg   %ax,%ax
 70c:	66 90                	xchg   %ax,%ax
 70e:	66 90                	xchg   %ax,%ax

00000710 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 710:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	a1 88 09 00 00       	mov    0x988,%eax
{
 716:	89 e5                	mov    %esp,%ebp
 718:	57                   	push   %edi
 719:	56                   	push   %esi
 71a:	53                   	push   %ebx
 71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 71e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 728:	00 
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 730:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 732:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 734:	39 ca                	cmp    %ecx,%edx
 736:	73 30                	jae    768 <free+0x58>
 738:	39 c1                	cmp    %eax,%ecx
 73a:	72 04                	jb     740 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73c:	39 c2                	cmp    %eax,%edx
 73e:	72 f0                	jb     730 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 740:	8b 73 fc             	mov    -0x4(%ebx),%esi
 743:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 746:	39 f8                	cmp    %edi,%eax
 748:	74 36                	je     780 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 74a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 74d:	8b 42 04             	mov    0x4(%edx),%eax
 750:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 753:	39 f1                	cmp    %esi,%ecx
 755:	74 42                	je     799 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 757:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 759:	5b                   	pop    %ebx
  freep = p;
 75a:	89 15 88 09 00 00    	mov    %edx,0x988
}
 760:	5e                   	pop    %esi
 761:	5f                   	pop    %edi
 762:	5d                   	pop    %ebp
 763:	c3                   	ret
 764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 768:	39 c2                	cmp    %eax,%edx
 76a:	72 c4                	jb     730 <free+0x20>
 76c:	39 c1                	cmp    %eax,%ecx
 76e:	73 c0                	jae    730 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 770:	8b 73 fc             	mov    -0x4(%ebx),%esi
 773:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 776:	39 f8                	cmp    %edi,%eax
 778:	75 d0                	jne    74a <free+0x3a>
 77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 780:	8b 78 04             	mov    0x4(%eax),%edi
 783:	01 fe                	add    %edi,%esi
 785:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 788:	8b 02                	mov    (%edx),%eax
 78a:	8b 00                	mov    (%eax),%eax
 78c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 78f:	8b 42 04             	mov    0x4(%edx),%eax
 792:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 795:	39 f1                	cmp    %esi,%ecx
 797:	75 be                	jne    757 <free+0x47>
  freep = p;
 799:	89 15 88 09 00 00    	mov    %edx,0x988
    p->s.size += bp->s.size;
 79f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 7a2:	01 c8                	add    %ecx,%eax
 7a4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7a7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7aa:	89 0a                	mov    %ecx,(%edx)
}
 7ac:	5b                   	pop    %ebx
 7ad:	5e                   	pop    %esi
 7ae:	5f                   	pop    %edi
 7af:	5d                   	pop    %ebp
 7b0:	c3                   	ret
 7b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7b8:	00 
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7cc:	8b 15 88 09 00 00    	mov    0x988,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d2:	8d 78 07             	lea    0x7(%eax),%edi
 7d5:	c1 ef 03             	shr    $0x3,%edi
 7d8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 7d9:	85 d2                	test   %edx,%edx
 7db:	0f 84 8f 00 00 00    	je     870 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e1:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7e3:	8b 48 04             	mov    0x4(%eax),%ecx
 7e6:	39 f9                	cmp    %edi,%ecx
 7e8:	73 5e                	jae    848 <malloc+0x88>
  if(nu < 4096)
 7ea:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7ef:	39 df                	cmp    %ebx,%edi
 7f1:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7f4:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7fb:	eb 0c                	jmp    809 <malloc+0x49>
 7fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 800:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 802:	8b 48 04             	mov    0x4(%eax),%ecx
 805:	39 f9                	cmp    %edi,%ecx
 807:	73 3f                	jae    848 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 809:	39 05 88 09 00 00    	cmp    %eax,0x988
 80f:	89 c2                	mov    %eax,%edx
 811:	75 ed                	jne    800 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 813:	89 34 24             	mov    %esi,(%esp)
 816:	e8 b0 fb ff ff       	call   3cb <sbrk>
  if(p == (char*)-1)
 81b:	83 f8 ff             	cmp    $0xffffffff,%eax
 81e:	74 18                	je     838 <malloc+0x78>
  hp->s.size = nu;
 820:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 823:	83 c0 08             	add    $0x8,%eax
 826:	89 04 24             	mov    %eax,(%esp)
 829:	e8 e2 fe ff ff       	call   710 <free>
  return freep;
 82e:	8b 15 88 09 00 00    	mov    0x988,%edx
      if((p = morecore(nunits)) == 0)
 834:	85 d2                	test   %edx,%edx
 836:	75 c8                	jne    800 <malloc+0x40>
        return 0;
  }
}
 838:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 83b:	31 c0                	xor    %eax,%eax
}
 83d:	5b                   	pop    %ebx
 83e:	5e                   	pop    %esi
 83f:	5f                   	pop    %edi
 840:	5d                   	pop    %ebp
 841:	c3                   	ret
 842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 848:	39 cf                	cmp    %ecx,%edi
 84a:	74 54                	je     8a0 <malloc+0xe0>
        p->s.size -= nunits;
 84c:	29 f9                	sub    %edi,%ecx
 84e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 851:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 854:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 857:	89 15 88 09 00 00    	mov    %edx,0x988
}
 85d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 860:	83 c0 08             	add    $0x8,%eax
}
 863:	5b                   	pop    %ebx
 864:	5e                   	pop    %esi
 865:	5f                   	pop    %edi
 866:	5d                   	pop    %ebp
 867:	c3                   	ret
 868:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 86f:	00 
    base.s.ptr = freep = prevp = &base;
 870:	b8 8c 09 00 00       	mov    $0x98c,%eax
 875:	ba 8c 09 00 00       	mov    $0x98c,%edx
 87a:	a3 88 09 00 00       	mov    %eax,0x988
    base.s.size = 0;
 87f:	31 c9                	xor    %ecx,%ecx
 881:	b8 8c 09 00 00       	mov    $0x98c,%eax
    base.s.ptr = freep = prevp = &base;
 886:	89 15 8c 09 00 00    	mov    %edx,0x98c
    base.s.size = 0;
 88c:	89 0d 90 09 00 00    	mov    %ecx,0x990
    if(p->s.size >= nunits){
 892:	e9 53 ff ff ff       	jmp    7ea <malloc+0x2a>
 897:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 89e:	00 
 89f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 8a0:	8b 08                	mov    (%eax),%ecx
 8a2:	89 0a                	mov    %ecx,(%edx)
 8a4:	eb b1                	jmp    857 <malloc+0x97>
