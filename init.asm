
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   1:	b9 02 00 00 00       	mov    $0x2,%ecx
{
   6:	89 e5                	mov    %esp,%ebp
   8:	53                   	push   %ebx
   9:	83 e4 f0             	and    $0xfffffff0,%esp
   c:	83 ec 10             	sub    $0x10,%esp
  if(open("console", O_RDWR) < 0){
   f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  13:	c7 04 24 c8 08 00 00 	movl   $0x8c8,(%esp)
  1a:	e8 84 03 00 00       	call   3a3 <open>
  1f:	85 c0                	test   %eax,%eax
  21:	0f 88 ba 00 00 00    	js     e1 <main+0xe1>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  27:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  2e:	e8 a8 03 00 00       	call   3db <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 9c 03 00 00       	call   3db <dup>
  3f:	90                   	nop

  for(;;){
    printf(1, "init: starting sh\n");
  40:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  47:	ba d0 08 00 00       	mov    $0x8d0,%edx
  4c:	89 54 24 04          	mov    %edx,0x4(%esp)
  50:	e8 cb 04 00 00       	call   520 <printf>
    pid = fork();
  55:	e8 01 03 00 00       	call   35b <fork>
    if(pid < 0){
  5a:	85 c0                	test   %eax,%eax
    pid = fork();
  5c:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  5e:	78 3b                	js     9b <main+0x9b>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  60:	74 52                	je     b4 <main+0xb4>
  62:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  69:	00 
  6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 f6 02 00 00       	call   36b <wait>
  75:	89 c2                	mov    %eax,%edx
  77:	f7 d2                	not    %edx
  79:	c1 ea 1f             	shr    $0x1f,%edx
  7c:	84 d2                	test   %dl,%dl
  7e:	74 c0                	je     40 <main+0x40>
  80:	39 c3                	cmp    %eax,%ebx
  82:	74 bc                	je     40 <main+0x40>
      printf(1, "zombie!\n");
  84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  8b:	b8 0f 09 00 00       	mov    $0x90f,%eax
  90:	89 44 24 04          	mov    %eax,0x4(%esp)
  94:	e8 87 04 00 00       	call   520 <printf>
  99:	eb d5                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  9b:	c7 44 24 04 e3 08 00 	movl   $0x8e3,0x4(%esp)
  a2:	00 
  a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  aa:	e8 71 04 00 00       	call   520 <printf>
      exit();
  af:	e8 af 02 00 00       	call   363 <exit>
      exec("sh", argv);
  b4:	c7 44 24 04 8c 09 00 	movl   $0x98c,0x4(%esp)
  bb:	00 
  bc:	c7 04 24 f6 08 00 00 	movl   $0x8f6,(%esp)
  c3:	e8 d3 02 00 00       	call   39b <exec>
      printf(1, "init: exec sh failed\n");
  c8:	c7 44 24 04 f9 08 00 	movl   $0x8f9,0x4(%esp)
  cf:	00 
  d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d7:	e8 44 04 00 00       	call   520 <printf>
      exit();
  dc:	e8 82 02 00 00       	call   363 <exit>
    mknod("console", 1, 1);
  e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  e8:	00 
  e9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  f0:	00 
  f1:	c7 04 24 c8 08 00 00 	movl   $0x8c8,(%esp)
  f8:	e8 ae 02 00 00       	call   3ab <mknod>
    open("console", O_RDWR);
  fd:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
 104:	00 
 105:	c7 04 24 c8 08 00 00 	movl   $0x8c8,(%esp)
 10c:	e8 92 02 00 00       	call   3a3 <open>
 111:	e9 11 ff ff ff       	jmp    27 <main+0x27>
 116:	66 90                	xchg   %ax,%ax
 118:	66 90                	xchg   %ax,%ax
 11a:	66 90                	xchg   %ax,%ax
 11c:	66 90                	xchg   %ax,%ax
 11e:	66 90                	xchg   %ax,%ax

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 121:	31 c0                	xor    %eax,%eax
{
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	40                   	inc    %eax
 138:	84 d2                	test   %dl,%dl
 13a:	75 f4                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13c:	5b                   	pop    %ebx
 13d:	89 c8                	mov    %ecx,%eax
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret
 141:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 148:	00 
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 55 08             	mov    0x8(%ebp),%edx
 157:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 15a:	0f b6 02             	movzbl (%edx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 15                	jne    176 <strcmp+0x26>
 161:	eb 30                	jmp    193 <strcmp+0x43>
 163:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 168:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 16c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 16f:	42                   	inc    %edx
  while(*p && *p == *q)
 170:	84 c0                	test   %al,%al
 172:	74 14                	je     188 <strcmp+0x38>
 174:	89 cb                	mov    %ecx,%ebx
 176:	0f b6 0b             	movzbl (%ebx),%ecx
 179:	38 c1                	cmp    %al,%cl
 17b:	74 eb                	je     168 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 17d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 17e:	29 c8                	sub    %ecx,%eax
}
 180:	5d                   	pop    %ebp
 181:	c3                   	ret
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 188:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 18c:	31 c0                	xor    %eax,%eax
}
 18e:	5b                   	pop    %ebx
 18f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 190:	29 c8                	sub    %ecx,%eax
}
 192:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 193:	0f b6 0b             	movzbl (%ebx),%ecx
 196:	31 c0                	xor    %eax,%eax
 198:	eb e3                	jmp    17d <strcmp+0x2d>
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 3a 00             	cmpb   $0x0,(%edx)
 1a9:	74 15                	je     1c0 <strlen+0x20>
 1ab:	31 c0                	xor    %eax,%eax
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	40                   	inc    %eax
 1b1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1b5:	89 c1                	mov    %eax,%ecx
 1b7:	75 f7                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1b9:	5d                   	pop    %ebp
 1ba:	89 c8                	mov    %ecx,%eax
 1bc:	c3                   	ret
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 1c1:	31 c9                	xor    %ecx,%ecx
}
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret
 1c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cd:	00 
 1ce:	66 90                	xchg   %ax,%ax

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
 1d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	5f                   	pop    %edi
 1e3:	89 d0                	mov    %edx,%eax
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret
 1e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ee:	00 
 1ef:	90                   	nop

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 10                	jne    211 <strchr+0x21>
 201:	eb 1d                	jmp    220 <strchr+0x30>
 203:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 208:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 20c:	40                   	inc    %eax
 20d:	84 d2                	test   %dl,%dl
 20f:	74 0f                	je     220 <strchr+0x30>
    if(*s == c)
 211:	38 d1                	cmp    %dl,%cl
 213:	75 f3                	jne    208 <strchr+0x18>
      return (char*)s;
  return 0;
}
 215:	5d                   	pop    %ebp
 216:	c3                   	ret
 217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21e:	00 
 21f:	90                   	nop
 220:	5d                   	pop    %ebp
  return 0;
 221:	31 c0                	xor    %eax,%eax
}
 223:	c3                   	ret
 224:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22b:	00 
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 235:	31 f6                	xor    %esi,%esi
{
 237:	53                   	push   %ebx
    cc = read(0, &c, 1);
 238:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 23b:	83 ec 3c             	sub    $0x3c,%esp
 23e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 241:	eb 32                	jmp    275 <gets+0x45>
 243:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 248:	89 7c 24 04          	mov    %edi,0x4(%esp)
 24c:	b8 01 00 00 00       	mov    $0x1,%eax
 251:	89 44 24 08          	mov    %eax,0x8(%esp)
 255:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 25c:	e8 1a 01 00 00       	call   37b <read>
    if(cc < 1)
 261:	85 c0                	test   %eax,%eax
 263:	7e 19                	jle    27e <gets+0x4e>
      break;
    buf[i++] = c;
 265:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 269:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 26d:	3c 0a                	cmp    $0xa,%al
 26f:	74 10                	je     281 <gets+0x51>
 271:	3c 0d                	cmp    $0xd,%al
 273:	74 0c                	je     281 <gets+0x51>
  for(i=0; i+1 < max; ){
 275:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 278:	46                   	inc    %esi
 279:	3b 75 0c             	cmp    0xc(%ebp),%esi
 27c:	7c ca                	jl     248 <gets+0x18>
 27e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 281:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 285:	83 c4 3c             	add    $0x3c,%esp
 288:	89 d8                	mov    %ebx,%eax
 28a:	5b                   	pop    %ebx
 28b:	5e                   	pop    %esi
 28c:	5f                   	pop    %edi
 28d:	5d                   	pop    %ebp
 28e:	c3                   	ret
 28f:	90                   	nop

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 291:	31 c0                	xor    %eax,%eax
{
 293:	89 e5                	mov    %esp,%ebp
 295:	83 ec 18             	sub    $0x18,%esp
 298:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 29b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 29e:	89 44 24 04          	mov    %eax,0x4(%esp)
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
 2a5:	89 04 24             	mov    %eax,(%esp)
 2a8:	e8 f6 00 00 00       	call   3a3 <open>
  if(fd < 0)
 2ad:	85 c0                	test   %eax,%eax
 2af:	78 2f                	js     2e0 <stat+0x50>
 2b1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b6:	89 1c 24             	mov    %ebx,(%esp)
 2b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2bd:	e8 f9 00 00 00       	call   3bb <fstat>
  close(fd);
 2c2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2c5:	89 c6                	mov    %eax,%esi
  close(fd);
 2c7:	e8 bf 00 00 00       	call   38b <close>
  return r;
}
 2cc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2cf:	89 f0                	mov    %esi,%eax
 2d1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2d4:	89 ec                	mov    %ebp,%esp
 2d6:	5d                   	pop    %ebp
 2d7:	c3                   	ret
 2d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2df:	00 
    return -1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb e5                	jmp    2cc <stat+0x3c>
 2e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ee:	00 
 2ef:	90                   	nop

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 02             	movsbl (%edx),%eax
 2fa:	88 c1                	mov    %al,%cl
 2fc:	80 e9 30             	sub    $0x30,%cl
 2ff:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 302:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 307:	77 1c                	ja     325 <atoi+0x35>
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 310:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 313:	42                   	inc    %edx
 314:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 318:	0f be 02             	movsbl (%edx),%eax
 31b:	88 c3                	mov    %al,%bl
 31d:	80 eb 30             	sub    $0x30,%bl
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
  return n;
}
 325:	5b                   	pop    %ebx
 326:	89 c8                	mov    %ecx,%eax
 328:	5d                   	pop    %ebp
 329:	c3                   	ret
 32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	8b 45 10             	mov    0x10(%ebp),%eax
 337:	56                   	push   %esi
 338:	8b 55 08             	mov    0x8(%ebp),%edx
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 c0                	test   %eax,%eax
 340:	7e 13                	jle    355 <memmove+0x25>
 342:	01 d0                	add    %edx,%eax
  dst = vdst;
 344:	89 d7                	mov    %edx,%edi
 346:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34d:	00 
 34e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 350:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 351:	39 f8                	cmp    %edi,%eax
 353:	75 fb                	jne    350 <memmove+0x20>
  return vdst;
}
 355:	5e                   	pop    %esi
 356:	89 d0                	mov    %edx,%eax
 358:	5f                   	pop    %edi
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret

0000035b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35b:	b8 01 00 00 00       	mov    $0x1,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <exit>:
SYSCALL(exit)
 363:	b8 02 00 00 00       	mov    $0x2,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <wait>:
SYSCALL(wait)
 36b:	b8 03 00 00 00       	mov    $0x3,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <pipe>:
SYSCALL(pipe)
 373:	b8 04 00 00 00       	mov    $0x4,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <read>:
SYSCALL(read)
 37b:	b8 05 00 00 00       	mov    $0x5,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <write>:
SYSCALL(write)
 383:	b8 10 00 00 00       	mov    $0x10,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <close>:
SYSCALL(close)
 38b:	b8 15 00 00 00       	mov    $0x15,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <kill>:
SYSCALL(kill)
 393:	b8 06 00 00 00       	mov    $0x6,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <exec>:
SYSCALL(exec)
 39b:	b8 07 00 00 00       	mov    $0x7,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <open>:
SYSCALL(open)
 3a3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <mknod>:
SYSCALL(mknod)
 3ab:	b8 11 00 00 00       	mov    $0x11,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <unlink>:
SYSCALL(unlink)
 3b3:	b8 12 00 00 00       	mov    $0x12,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <fstat>:
SYSCALL(fstat)
 3bb:	b8 08 00 00 00       	mov    $0x8,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <link>:
SYSCALL(link)
 3c3:	b8 13 00 00 00       	mov    $0x13,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <mkdir>:
SYSCALL(mkdir)
 3cb:	b8 14 00 00 00       	mov    $0x14,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <chdir>:
SYSCALL(chdir)
 3d3:	b8 09 00 00 00       	mov    $0x9,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <dup>:
SYSCALL(dup)
 3db:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <getpid>:
SYSCALL(getpid)
 3e3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <sbrk>:
SYSCALL(sbrk)
 3eb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <sleep>:
SYSCALL(sleep)
 3f3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <uptime>:
SYSCALL(uptime)
 3fb:	b8 0e 00 00 00       	mov    $0xe,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <worldpeace>:
SYSCALL(worldpeace)
 403:	b8 16 00 00 00       	mov    $0x16,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <numberofprocesses>:
SYSCALL(numberofprocesses)
 40b:	b8 17 00 00 00       	mov    $0x17,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <whatsthestatus>:
SYSCALL(whatsthestatus)
 413:	b8 18 00 00 00       	mov    $0x18,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <get_sibling>:
SYSCALL(get_sibling)
 41b:	b8 19 00 00 00       	mov    $0x19,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <spawn>:
SYSCALL(spawn)
 423:	b8 1a 00 00 00       	mov    $0x1a,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <getvasize>:
SYSCALL(getvasize)
 42b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <va2pa>:
SYSCALL(va2pa)
 433:	b8 1c 00 00 00       	mov    $0x1c,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 43b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 443:	b8 1e 00 00 00       	mov    $0x1e,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 44b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <getpasize>:
SYSCALL(getpasize)
 453:	b8 20 00 00 00       	mov    $0x20,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret
 45b:	66 90                	xchg   %ax,%ax
 45d:	66 90                	xchg   %ax,%ax
 45f:	90                   	nop

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	89 cb                	mov    %ecx,%ebx
 468:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 46b:	89 d1                	mov    %edx,%ecx
{
 46d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 470:	89 d0                	mov    %edx,%eax
 472:	c1 e8 1f             	shr    $0x1f,%eax
 475:	84 c0                	test   %al,%al
 477:	0f 84 93 00 00 00    	je     510 <printint+0xb0>
 47d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 481:	0f 84 89 00 00 00    	je     510 <printint+0xb0>
    x = -xx;
 487:	f7 d9                	neg    %ecx
    neg = 1;
 489:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 48e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 495:	8d 75 d7             	lea    -0x29(%ebp),%esi
 498:	89 45 b8             	mov    %eax,-0x48(%ebp)
 49b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 4a0:	89 c8                	mov    %ecx,%eax
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 4a7:	f7 f3                	div    %ebx
 4a9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4ac:	0f b6 92 78 09 00 00 	movzbl 0x978(%edx),%edx
 4b3:	8d 47 01             	lea    0x1(%edi),%eax
 4b6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 4b9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 4bd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 4bf:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 4c2:	39 da                	cmp    %ebx,%edx
 4c4:	73 da                	jae    4a0 <printint+0x40>
  if(neg)
 4c6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 4c9:	85 c0                	test   %eax,%eax
 4cb:	74 0a                	je     4d7 <printint+0x77>
    buf[i++] = '-';
 4cd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4d0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 4d5:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 4d7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4da:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 4de:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 4e0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4e3:	89 74 24 04          	mov    %esi,0x4(%esp)
 4e7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4ea:	b8 01 00 00 00       	mov    $0x1,%eax
 4ef:	89 44 24 08          	mov    %eax,0x8(%esp)
 4f3:	8b 45 bc             	mov    -0x44(%ebp),%eax
 4f6:	89 04 24             	mov    %eax,(%esp)
 4f9:	e8 85 fe ff ff       	call   383 <write>
  while(--i >= 0)
 4fe:	89 f8                	mov    %edi,%eax
 500:	4f                   	dec    %edi
 501:	39 d8                	cmp    %ebx,%eax
 503:	75 db                	jne    4e0 <printint+0x80>
}
 505:	83 c4 4c             	add    $0x4c,%esp
 508:	5b                   	pop    %ebx
 509:	5e                   	pop    %esi
 50a:	5f                   	pop    %edi
 50b:	5d                   	pop    %ebp
 50c:	c3                   	ret
 50d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 510:	31 c0                	xor    %eax,%eax
 512:	e9 77 ff ff ff       	jmp    48e <printint+0x2e>
 517:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51e:	00 
 51f:	90                   	nop

00000520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 529:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 52c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 52f:	0f b6 13             	movzbl (%ebx),%edx
 532:	43                   	inc    %ebx
 533:	84 d2                	test   %dl,%dl
 535:	74 35                	je     56c <printf+0x4c>
 537:	8d 45 10             	lea    0x10(%ebp),%eax
 53a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 53d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 540:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 543:	83 f8 25             	cmp    $0x25,%eax
 546:	74 30                	je     578 <printf+0x58>
  write(fd, &c, 1);
 548:	89 34 24             	mov    %esi,(%esp)
 54b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 550:	43                   	inc    %ebx
  write(fd, &c, 1);
 551:	89 44 24 08          	mov    %eax,0x8(%esp)
 555:	8d 45 e7             	lea    -0x19(%ebp),%eax
 558:	89 44 24 04          	mov    %eax,0x4(%esp)
 55c:	88 55 e7             	mov    %dl,-0x19(%ebp)
 55f:	e8 1f fe ff ff       	call   383 <write>
  for(i = 0; fmt[i]; i++){
 564:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 568:	84 d2                	test   %dl,%dl
 56a:	75 d4                	jne    540 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 56c:	83 c4 3c             	add    $0x3c,%esp
 56f:	5b                   	pop    %ebx
 570:	5e                   	pop    %esi
 571:	5f                   	pop    %edi
 572:	5d                   	pop    %ebp
 573:	c3                   	ret
 574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 578:	0f b6 13             	movzbl (%ebx),%edx
 57b:	84 d2                	test   %dl,%dl
 57d:	74 ed                	je     56c <printf+0x4c>
    c = fmt[i] & 0xff;
 57f:	80 fa 25             	cmp    $0x25,%dl
 582:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 585:	0f 84 75 01 00 00    	je     700 <printf+0x1e0>
 58b:	83 e8 63             	sub    $0x63,%eax
 58e:	83 f8 15             	cmp    $0x15,%eax
 591:	77 0d                	ja     5a0 <printf+0x80>
 593:	ff 24 85 20 09 00 00 	jmp    *0x920(,%eax,4)
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5a0:	89 34 24             	mov    %esi,(%esp)
 5a3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5a6:	b8 01 00 00 00       	mov    $0x1,%eax
 5ab:	89 44 24 08          	mov    %eax,0x8(%esp)
 5af:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5b3:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 5b6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 5ba:	e8 c4 fd ff ff       	call   383 <write>
        putc(fd, c);
 5bf:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 5c3:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5c6:	ba 01 00 00 00       	mov    $0x1,%edx
 5cb:	89 54 24 08          	mov    %edx,0x8(%esp)
 5cf:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 5d3:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 5d6:	89 34 24             	mov    %esi,(%esp)
 5d9:	e8 a5 fd ff ff       	call   383 <write>
  for(i = 0; fmt[i]; i++){
 5de:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5e2:	84 d2                	test   %dl,%dl
 5e4:	0f 85 56 ff ff ff    	jne    540 <printf+0x20>
}
 5ea:	83 c4 3c             	add    $0x3c,%esp
 5ed:	5b                   	pop    %ebx
 5ee:	5e                   	pop    %esi
 5ef:	5f                   	pop    %edi
 5f0:	5d                   	pop    %ebp
 5f1:	c3                   	ret
 5f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5f8:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5fb:	b9 10 00 00 00       	mov    $0x10,%ecx
 600:	8b 17                	mov    (%edi),%edx
 602:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 609:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 60c:	89 f0                	mov    %esi,%eax
 60e:	e8 4d fe ff ff       	call   460 <printint>
  for(i = 0; fmt[i]; i++){
 613:	83 c3 02             	add    $0x2,%ebx
        ap++;
 616:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 619:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 61d:	84 d2                	test   %dl,%dl
 61f:	0f 85 1b ff ff ff    	jne    540 <printf+0x20>
}
 625:	83 c4 3c             	add    $0x3c,%esp
 628:	5b                   	pop    %ebx
 629:	5e                   	pop    %esi
 62a:	5f                   	pop    %edi
 62b:	5d                   	pop    %ebp
 62c:	c3                   	ret
 62d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 630:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 633:	8b 01                	mov    (%ecx),%eax
        ap++;
 635:	83 c1 04             	add    $0x4,%ecx
 638:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 63b:	85 c0                	test   %eax,%eax
 63d:	0f 84 d5 00 00 00    	je     718 <printf+0x1f8>
        while(*s != 0){
 643:	0f b6 10             	movzbl (%eax),%edx
 646:	84 d2                	test   %dl,%dl
 648:	74 39                	je     683 <printf+0x163>
 64a:	89 c7                	mov    %eax,%edi
 64c:	88 d0                	mov    %dl,%al
 64e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 651:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 654:	89 fb                	mov    %edi,%ebx
 656:	89 cf                	mov    %ecx,%edi
 658:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 65f:	00 
          putc(fd, *s);
 660:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 663:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 668:	43                   	inc    %ebx
  write(fd, &c, 1);
 669:	89 44 24 08          	mov    %eax,0x8(%esp)
 66d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 671:	89 34 24             	mov    %esi,(%esp)
 674:	e8 0a fd ff ff       	call   383 <write>
        while(*s != 0){
 679:	0f b6 03             	movzbl (%ebx),%eax
 67c:	84 c0                	test   %al,%al
 67e:	75 e0                	jne    660 <printf+0x140>
 680:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 683:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 687:	83 c3 02             	add    $0x2,%ebx
 68a:	84 d2                	test   %dl,%dl
 68c:	0f 85 ae fe ff ff    	jne    540 <printf+0x20>
 692:	e9 d5 fe ff ff       	jmp    56c <printf+0x4c>
 697:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 69e:	00 
 69f:	90                   	nop
        printint(fd, *ap, 10, 1);
 6a0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6a8:	8b 17                	mov    (%edi),%edx
 6aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6b1:	e9 53 ff ff ff       	jmp    609 <printf+0xe9>
 6b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bd:	00 
 6be:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 6c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 6c3:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 6c8:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 6cb:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 6cd:	89 7c 24 08          	mov    %edi,0x8(%esp)
 6d1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 6d4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6d8:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 6db:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 6de:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 6e2:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6e5:	e8 99 fc ff ff       	call   383 <write>
        ap++;
 6ea:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 6ee:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6f2:	84 d2                	test   %dl,%dl
 6f4:	0f 85 46 fe ff ff    	jne    540 <printf+0x20>
 6fa:	e9 6d fe ff ff       	jmp    56c <printf+0x4c>
 6ff:	90                   	nop
        putc(fd, c);
 700:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 703:	8d 7d e7             	lea    -0x19(%ebp),%edi
 706:	b9 01 00 00 00       	mov    $0x1,%ecx
 70b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 70f:	e9 bb fe ff ff       	jmp    5cf <printf+0xaf>
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 718:	bf 18 09 00 00       	mov    $0x918,%edi
 71d:	b0 28                	mov    $0x28,%al
 71f:	e9 2a ff ff ff       	jmp    64e <printf+0x12e>
 724:	66 90                	xchg   %ax,%ax
 726:	66 90                	xchg   %ax,%ax
 728:	66 90                	xchg   %ax,%ax
 72a:	66 90                	xchg   %ax,%ax
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax

00000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	a1 94 09 00 00       	mov    0x994,%eax
{
 736:	89 e5                	mov    %esp,%ebp
 738:	57                   	push   %edi
 739:	56                   	push   %esi
 73a:	53                   	push   %ebx
 73b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 73e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 748:	00 
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 750:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 752:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 754:	39 ca                	cmp    %ecx,%edx
 756:	73 30                	jae    788 <free+0x58>
 758:	39 c1                	cmp    %eax,%ecx
 75a:	72 04                	jb     760 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75c:	39 c2                	cmp    %eax,%edx
 75e:	72 f0                	jb     750 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 760:	8b 73 fc             	mov    -0x4(%ebx),%esi
 763:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 766:	39 f8                	cmp    %edi,%eax
 768:	74 36                	je     7a0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 76a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 76d:	8b 42 04             	mov    0x4(%edx),%eax
 770:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 773:	39 f1                	cmp    %esi,%ecx
 775:	74 42                	je     7b9 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 777:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 779:	5b                   	pop    %ebx
  freep = p;
 77a:	89 15 94 09 00 00    	mov    %edx,0x994
}
 780:	5e                   	pop    %esi
 781:	5f                   	pop    %edi
 782:	5d                   	pop    %ebp
 783:	c3                   	ret
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 788:	39 c2                	cmp    %eax,%edx
 78a:	72 c4                	jb     750 <free+0x20>
 78c:	39 c1                	cmp    %eax,%ecx
 78e:	73 c0                	jae    750 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 790:	8b 73 fc             	mov    -0x4(%ebx),%esi
 793:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 796:	39 f8                	cmp    %edi,%eax
 798:	75 d0                	jne    76a <free+0x3a>
 79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 7a0:	8b 78 04             	mov    0x4(%eax),%edi
 7a3:	01 fe                	add    %edi,%esi
 7a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a8:	8b 02                	mov    (%edx),%eax
 7aa:	8b 00                	mov    (%eax),%eax
 7ac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7af:	8b 42 04             	mov    0x4(%edx),%eax
 7b2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7b5:	39 f1                	cmp    %esi,%ecx
 7b7:	75 be                	jne    777 <free+0x47>
  freep = p;
 7b9:	89 15 94 09 00 00    	mov    %edx,0x994
    p->s.size += bp->s.size;
 7bf:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 7c2:	01 c8                	add    %ecx,%eax
 7c4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7c7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7ca:	89 0a                	mov    %ecx,(%edx)
}
 7cc:	5b                   	pop    %ebx
 7cd:	5e                   	pop    %esi
 7ce:	5f                   	pop    %edi
 7cf:	5d                   	pop    %ebp
 7d0:	c3                   	ret
 7d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7d8:	00 
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ec:	8b 15 94 09 00 00    	mov    0x994,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f2:	8d 78 07             	lea    0x7(%eax),%edi
 7f5:	c1 ef 03             	shr    $0x3,%edi
 7f8:	47                   	inc    %edi
  if((prevp = freep) == 0){
 7f9:	85 d2                	test   %edx,%edx
 7fb:	0f 84 8f 00 00 00    	je     890 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 801:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 803:	8b 48 04             	mov    0x4(%eax),%ecx
 806:	39 f9                	cmp    %edi,%ecx
 808:	73 5e                	jae    868 <malloc+0x88>
  if(nu < 4096)
 80a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 80f:	39 df                	cmp    %ebx,%edi
 811:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 814:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 81b:	eb 0c                	jmp    829 <malloc+0x49>
 81d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 820:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 822:	8b 48 04             	mov    0x4(%eax),%ecx
 825:	39 f9                	cmp    %edi,%ecx
 827:	73 3f                	jae    868 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 829:	39 05 94 09 00 00    	cmp    %eax,0x994
 82f:	89 c2                	mov    %eax,%edx
 831:	75 ed                	jne    820 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 833:	89 34 24             	mov    %esi,(%esp)
 836:	e8 b0 fb ff ff       	call   3eb <sbrk>
  if(p == (char*)-1)
 83b:	83 f8 ff             	cmp    $0xffffffff,%eax
 83e:	74 18                	je     858 <malloc+0x78>
  hp->s.size = nu;
 840:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 843:	83 c0 08             	add    $0x8,%eax
 846:	89 04 24             	mov    %eax,(%esp)
 849:	e8 e2 fe ff ff       	call   730 <free>
  return freep;
 84e:	8b 15 94 09 00 00    	mov    0x994,%edx
      if((p = morecore(nunits)) == 0)
 854:	85 d2                	test   %edx,%edx
 856:	75 c8                	jne    820 <malloc+0x40>
        return 0;
  }
}
 858:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 85b:	31 c0                	xor    %eax,%eax
}
 85d:	5b                   	pop    %ebx
 85e:	5e                   	pop    %esi
 85f:	5f                   	pop    %edi
 860:	5d                   	pop    %ebp
 861:	c3                   	ret
 862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 868:	39 cf                	cmp    %ecx,%edi
 86a:	74 54                	je     8c0 <malloc+0xe0>
        p->s.size -= nunits;
 86c:	29 f9                	sub    %edi,%ecx
 86e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 871:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 874:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 877:	89 15 94 09 00 00    	mov    %edx,0x994
}
 87d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 880:	83 c0 08             	add    $0x8,%eax
}
 883:	5b                   	pop    %ebx
 884:	5e                   	pop    %esi
 885:	5f                   	pop    %edi
 886:	5d                   	pop    %ebp
 887:	c3                   	ret
 888:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 88f:	00 
    base.s.ptr = freep = prevp = &base;
 890:	b8 98 09 00 00       	mov    $0x998,%eax
 895:	ba 98 09 00 00       	mov    $0x998,%edx
 89a:	a3 94 09 00 00       	mov    %eax,0x994
    base.s.size = 0;
 89f:	31 c9                	xor    %ecx,%ecx
 8a1:	b8 98 09 00 00       	mov    $0x998,%eax
    base.s.ptr = freep = prevp = &base;
 8a6:	89 15 98 09 00 00    	mov    %edx,0x998
    base.s.size = 0;
 8ac:	89 0d 9c 09 00 00    	mov    %ecx,0x99c
    if(p->s.size >= nunits){
 8b2:	e9 53 ff ff ff       	jmp    80a <malloc+0x2a>
 8b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8be:	00 
 8bf:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 08                	mov    (%eax),%ecx
 8c2:	89 0a                	mov    %ecx,(%edx)
 8c4:	eb b1                	jmp    877 <malloc+0x97>
