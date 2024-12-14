
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	bf 01 00 00 00       	mov    $0x1,%edi
   9:	56                   	push   %esi
   a:	53                   	push   %ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  int fd, i;

  if(argc <= 1){
  11:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
{
  15:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(argc <= 1){
  18:	7e 5c                	jle    76 <main+0x76>
  1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	31 c0                	xor    %eax,%eax
  22:	89 44 24 04          	mov    %eax,0x4(%esp)
  26:	8b 04 be             	mov    (%esi,%edi,4),%eax
  29:	89 04 24             	mov    %eax,(%esp)
  2c:	e8 f2 03 00 00       	call   423 <open>
  31:	89 c3                	mov    %eax,%ebx
      printf(1, "wc: cannot open %s\n", argv[i]);
  33:	8b 04 be             	mov    (%esi,%edi,4),%eax
    if((fd = open(argv[i], 0)) < 0){
  36:	85 db                	test   %ebx,%ebx
  38:	78 1f                	js     59 <main+0x59>
      exit();
    }
    wc(fd, argv[i]);
  3a:	89 44 24 04          	mov    %eax,0x4(%esp)
  for(i = 1; i < argc; i++){
  3e:	47                   	inc    %edi
    wc(fd, argv[i]);
  3f:	89 1c 24             	mov    %ebx,(%esp)
  42:	e8 49 00 00 00       	call   90 <wc>
    close(fd);
  47:	89 1c 24             	mov    %ebx,(%esp)
  4a:	e8 bc 03 00 00       	call   40b <close>
  for(i = 1; i < argc; i++){
  4f:	39 7d 08             	cmp    %edi,0x8(%ebp)
  52:	75 cc                	jne    20 <main+0x20>
  }
  exit();
  54:	e8 8a 03 00 00       	call   3e3 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  59:	89 44 24 08          	mov    %eax,0x8(%esp)
  5d:	c7 44 24 04 6b 09 00 	movl   $0x96b,0x4(%esp)
  64:	00 
  65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6c:	e8 2f 05 00 00       	call   5a0 <printf>
      exit();
  71:	e8 6d 03 00 00       	call   3e3 <exit>
    wc(0, "");
  76:	c7 44 24 04 5d 09 00 	movl   $0x95d,0x4(%esp)
  7d:	00 
  7e:	31 d2                	xor    %edx,%edx
  80:	89 14 24             	mov    %edx,(%esp)
  83:	e8 08 00 00 00       	call   90 <wc>
    exit();
  88:	e8 56 03 00 00       	call   3e3 <exit>
  8d:	66 90                	xchg   %ax,%ax
  8f:	90                   	nop

00000090 <wc>:
{
  90:	55                   	push   %ebp
  l = w = c = 0;
  91:	31 d2                	xor    %edx,%edx
{
  93:	89 e5                	mov    %esp,%ebp
  95:	57                   	push   %edi
  96:	56                   	push   %esi
  97:	53                   	push   %ebx
  l = w = c = 0;
  98:	31 db                	xor    %ebx,%ebx
{
  9a:	83 ec 3c             	sub    $0x3c,%esp
  inword = 0;
  9d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  a4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  ab:	89 55 dc             	mov    %edx,-0x24(%ebp)
  ae:	66 90                	xchg   %ax,%ax
  while((n = read(fd, buf, sizeof(buf))) > 0){
  b0:	8b 45 08             	mov    0x8(%ebp),%eax
  b3:	ba 00 02 00 00       	mov    $0x200,%edx
  b8:	b9 00 0a 00 00       	mov    $0xa00,%ecx
  bd:	89 54 24 08          	mov    %edx,0x8(%esp)
  c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  c5:	89 04 24             	mov    %eax,(%esp)
  c8:	e8 2e 03 00 00       	call   3fb <read>
  cd:	85 c0                	test   %eax,%eax
  cf:	89 c6                	mov    %eax,%esi
  d1:	7e 6d                	jle    140 <wc+0xb0>
    for(i=0; i<n; i++){
  d3:	31 ff                	xor    %edi,%edi
  d5:	eb 15                	jmp    ec <wc+0x5c>
  d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  de:	00 
  df:	90                   	nop
        inword = 0;
  e0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
  e7:	47                   	inc    %edi
  e8:	39 fe                	cmp    %edi,%esi
  ea:	74 44                	je     130 <wc+0xa0>
      if(buf[i] == '\n')
  ec:	0f be 87 00 0a 00 00 	movsbl 0xa00(%edi),%eax
        l++;
  f3:	31 c9                	xor    %ecx,%ecx
      if(strchr(" \r\t\n\v", buf[i]))
  f5:	c7 04 24 48 09 00 00 	movl   $0x948,(%esp)
  fc:	89 44 24 04          	mov    %eax,0x4(%esp)
        l++;
 100:	3c 0a                	cmp    $0xa,%al
 102:	0f 94 c1             	sete   %cl
 105:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 107:	e8 64 01 00 00       	call   270 <strchr>
 10c:	85 c0                	test   %eax,%eax
 10e:	75 d0                	jne    e0 <wc+0x50>
      else if(!inword){
 110:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 113:	85 c0                	test   %eax,%eax
 115:	75 d0                	jne    e7 <wc+0x57>
        w++;
 117:	ff 45 e0             	incl   -0x20(%ebp)
    for(i=0; i<n; i++){
 11a:	47                   	inc    %edi
 11b:	39 fe                	cmp    %edi,%esi
        inword = 1;
 11d:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
 124:	75 c6                	jne    ec <wc+0x5c>
 126:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12d:	00 
 12e:	66 90                	xchg   %ax,%ax
 130:	01 75 dc             	add    %esi,-0x24(%ebp)
 133:	e9 78 ff ff ff       	jmp    b0 <wc+0x20>
 138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13f:	00 
  if(n < 0){
 140:	8b 55 dc             	mov    -0x24(%ebp),%edx
 143:	75 33                	jne    178 <wc+0xe8>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 145:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 149:	8b 45 0c             	mov    0xc(%ebp),%eax
 14c:	89 54 24 10          	mov    %edx,0x10(%esp)
 150:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 157:	89 44 24 14          	mov    %eax,0x14(%esp)
 15b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 15e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 162:	b8 5e 09 00 00       	mov    $0x95e,%eax
 167:	89 44 24 04          	mov    %eax,0x4(%esp)
 16b:	e8 30 04 00 00       	call   5a0 <printf>
}
 170:	83 c4 3c             	add    $0x3c,%esp
 173:	5b                   	pop    %ebx
 174:	5e                   	pop    %esi
 175:	5f                   	pop    %edi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret
    printf(1, "wc: read error\n");
 178:	c7 44 24 04 4e 09 00 	movl   $0x94e,0x4(%esp)
 17f:	00 
 180:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 187:	e8 14 04 00 00       	call   5a0 <printf>
    exit();
 18c:	e8 52 02 00 00       	call   3e3 <exit>
 191:	66 90                	xchg   %ax,%ax
 193:	66 90                	xchg   %ax,%ax
 195:	66 90                	xchg   %ax,%ax
 197:	66 90                	xchg   %ax,%ax
 199:	66 90                	xchg   %ax,%ax
 19b:	66 90                	xchg   %ax,%ax
 19d:	66 90                	xchg   %ax,%ax
 19f:	90                   	nop

000001a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a1:	31 c0                	xor    %eax,%eax
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	53                   	push   %ebx
 1a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1b7:	40                   	inc    %eax
 1b8:	84 d2                	test   %dl,%dl
 1ba:	75 f4                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1bc:	5b                   	pop    %ebx
 1bd:	89 c8                	mov    %ecx,%eax
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret
 1c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1c8:	00 
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx
 1d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1da:	0f b6 02             	movzbl (%edx),%eax
 1dd:	84 c0                	test   %al,%al
 1df:	75 15                	jne    1f6 <strcmp+0x26>
 1e1:	eb 30                	jmp    213 <strcmp+0x43>
 1e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1ec:	8d 4b 01             	lea    0x1(%ebx),%ecx
 1ef:	42                   	inc    %edx
  while(*p && *p == *q)
 1f0:	84 c0                	test   %al,%al
 1f2:	74 14                	je     208 <strcmp+0x38>
 1f4:	89 cb                	mov    %ecx,%ebx
 1f6:	0f b6 0b             	movzbl (%ebx),%ecx
 1f9:	38 c1                	cmp    %al,%cl
 1fb:	74 eb                	je     1e8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 1fd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 1fe:	29 c8                	sub    %ecx,%eax
}
 200:	5d                   	pop    %ebp
 201:	c3                   	ret
 202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 208:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 20c:	31 c0                	xor    %eax,%eax
}
 20e:	5b                   	pop    %ebx
 20f:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 210:	29 c8                	sub    %ecx,%eax
}
 212:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 213:	0f b6 0b             	movzbl (%ebx),%ecx
 216:	31 c0                	xor    %eax,%eax
 218:	eb e3                	jmp    1fd <strcmp+0x2d>
 21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000220 <strlen>:

uint
strlen(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 226:	80 3a 00             	cmpb   $0x0,(%edx)
 229:	74 15                	je     240 <strlen+0x20>
 22b:	31 c0                	xor    %eax,%eax
 22d:	8d 76 00             	lea    0x0(%esi),%esi
 230:	40                   	inc    %eax
 231:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 235:	89 c1                	mov    %eax,%ecx
 237:	75 f7                	jne    230 <strlen+0x10>
    ;
  return n;
}
 239:	5d                   	pop    %ebp
 23a:	89 c8                	mov    %ecx,%eax
 23c:	c3                   	ret
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 241:	31 c9                	xor    %ecx,%ecx
}
 243:	89 c8                	mov    %ecx,%eax
 245:	c3                   	ret
 246:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24d:	00 
 24e:	66 90                	xchg   %ax,%ax

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 55 08             	mov    0x8(%ebp),%edx
 256:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 257:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	89 d7                	mov    %edx,%edi
 25f:	fc                   	cld
 260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 262:	5f                   	pop    %edi
 263:	89 d0                	mov    %edx,%eax
 265:	5d                   	pop    %ebp
 266:	c3                   	ret
 267:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26e:	00 
 26f:	90                   	nop

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	75 10                	jne    291 <strchr+0x21>
 281:	eb 1d                	jmp    2a0 <strchr+0x30>
 283:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 288:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 28c:	40                   	inc    %eax
 28d:	84 d2                	test   %dl,%dl
 28f:	74 0f                	je     2a0 <strchr+0x30>
    if(*s == c)
 291:	38 d1                	cmp    %dl,%cl
 293:	75 f3                	jne    288 <strchr+0x18>
      return (char*)s;
  return 0;
}
 295:	5d                   	pop    %ebp
 296:	c3                   	ret
 297:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29e:	00 
 29f:	90                   	nop
 2a0:	5d                   	pop    %ebp
  return 0;
 2a1:	31 c0                	xor    %eax,%eax
}
 2a3:	c3                   	ret
 2a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ab:	00 
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b5:	31 f6                	xor    %esi,%esi
{
 2b7:	53                   	push   %ebx
    cc = read(0, &c, 1);
 2b8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 2bb:	83 ec 3c             	sub    $0x3c,%esp
 2be:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 2c1:	eb 32                	jmp    2f5 <gets+0x45>
 2c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 2c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2cc:	b8 01 00 00 00       	mov    $0x1,%eax
 2d1:	89 44 24 08          	mov    %eax,0x8(%esp)
 2d5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2dc:	e8 1a 01 00 00       	call   3fb <read>
    if(cc < 1)
 2e1:	85 c0                	test   %eax,%eax
 2e3:	7e 19                	jle    2fe <gets+0x4e>
      break;
    buf[i++] = c;
 2e5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2e9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 2ed:	3c 0a                	cmp    $0xa,%al
 2ef:	74 10                	je     301 <gets+0x51>
 2f1:	3c 0d                	cmp    $0xd,%al
 2f3:	74 0c                	je     301 <gets+0x51>
  for(i=0; i+1 < max; ){
 2f5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2f8:	46                   	inc    %esi
 2f9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2fc:	7c ca                	jl     2c8 <gets+0x18>
 2fe:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 301:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 305:	83 c4 3c             	add    $0x3c,%esp
 308:	89 d8                	mov    %ebx,%eax
 30a:	5b                   	pop    %ebx
 30b:	5e                   	pop    %esi
 30c:	5f                   	pop    %edi
 30d:	5d                   	pop    %ebp
 30e:	c3                   	ret
 30f:	90                   	nop

00000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 311:	31 c0                	xor    %eax,%eax
{
 313:	89 e5                	mov    %esp,%ebp
 315:	83 ec 18             	sub    $0x18,%esp
 318:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 31b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 31e:	89 44 24 04          	mov    %eax,0x4(%esp)
 322:	8b 45 08             	mov    0x8(%ebp),%eax
 325:	89 04 24             	mov    %eax,(%esp)
 328:	e8 f6 00 00 00       	call   423 <open>
  if(fd < 0)
 32d:	85 c0                	test   %eax,%eax
 32f:	78 2f                	js     360 <stat+0x50>
 331:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 333:	8b 45 0c             	mov    0xc(%ebp),%eax
 336:	89 1c 24             	mov    %ebx,(%esp)
 339:	89 44 24 04          	mov    %eax,0x4(%esp)
 33d:	e8 f9 00 00 00       	call   43b <fstat>
  close(fd);
 342:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 345:	89 c6                	mov    %eax,%esi
  close(fd);
 347:	e8 bf 00 00 00       	call   40b <close>
  return r;
}
 34c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 34f:	89 f0                	mov    %esi,%eax
 351:	8b 75 fc             	mov    -0x4(%ebp),%esi
 354:	89 ec                	mov    %ebp,%esp
 356:	5d                   	pop    %ebp
 357:	c3                   	ret
 358:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35f:	00 
    return -1;
 360:	be ff ff ff ff       	mov    $0xffffffff,%esi
 365:	eb e5                	jmp    34c <stat+0x3c>
 367:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 36e:	00 
 36f:	90                   	nop

00000370 <atoi>:

int
atoi(const char *s)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 377:	0f be 02             	movsbl (%edx),%eax
 37a:	88 c1                	mov    %al,%cl
 37c:	80 e9 30             	sub    $0x30,%cl
 37f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 382:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 387:	77 1c                	ja     3a5 <atoi+0x35>
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 390:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 393:	42                   	inc    %edx
 394:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 398:	0f be 02             	movsbl (%edx),%eax
 39b:	88 c3                	mov    %al,%bl
 39d:	80 eb 30             	sub    $0x30,%bl
 3a0:	80 fb 09             	cmp    $0x9,%bl
 3a3:	76 eb                	jbe    390 <atoi+0x20>
  return n;
}
 3a5:	5b                   	pop    %ebx
 3a6:	89 c8                	mov    %ecx,%eax
 3a8:	5d                   	pop    %ebp
 3a9:	c3                   	ret
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	8b 45 10             	mov    0x10(%ebp),%eax
 3b7:	56                   	push   %esi
 3b8:	8b 55 08             	mov    0x8(%ebp),%edx
 3bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3be:	85 c0                	test   %eax,%eax
 3c0:	7e 13                	jle    3d5 <memmove+0x25>
 3c2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3c4:	89 d7                	mov    %edx,%edi
 3c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3cd:	00 
 3ce:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 3d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3d1:	39 f8                	cmp    %edi,%eax
 3d3:	75 fb                	jne    3d0 <memmove+0x20>
  return vdst;
}
 3d5:	5e                   	pop    %esi
 3d6:	89 d0                	mov    %edx,%eax
 3d8:	5f                   	pop    %edi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret

000003db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3db:	b8 01 00 00 00       	mov    $0x1,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <exit>:
SYSCALL(exit)
 3e3:	b8 02 00 00 00       	mov    $0x2,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <wait>:
SYSCALL(wait)
 3eb:	b8 03 00 00 00       	mov    $0x3,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <pipe>:
SYSCALL(pipe)
 3f3:	b8 04 00 00 00       	mov    $0x4,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <read>:
SYSCALL(read)
 3fb:	b8 05 00 00 00       	mov    $0x5,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <write>:
SYSCALL(write)
 403:	b8 10 00 00 00       	mov    $0x10,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <close>:
SYSCALL(close)
 40b:	b8 15 00 00 00       	mov    $0x15,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <kill>:
SYSCALL(kill)
 413:	b8 06 00 00 00       	mov    $0x6,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <exec>:
SYSCALL(exec)
 41b:	b8 07 00 00 00       	mov    $0x7,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <open>:
SYSCALL(open)
 423:	b8 0f 00 00 00       	mov    $0xf,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <mknod>:
SYSCALL(mknod)
 42b:	b8 11 00 00 00       	mov    $0x11,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <unlink>:
SYSCALL(unlink)
 433:	b8 12 00 00 00       	mov    $0x12,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <fstat>:
SYSCALL(fstat)
 43b:	b8 08 00 00 00       	mov    $0x8,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <link>:
SYSCALL(link)
 443:	b8 13 00 00 00       	mov    $0x13,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <mkdir>:
SYSCALL(mkdir)
 44b:	b8 14 00 00 00       	mov    $0x14,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <chdir>:
SYSCALL(chdir)
 453:	b8 09 00 00 00       	mov    $0x9,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <dup>:
SYSCALL(dup)
 45b:	b8 0a 00 00 00       	mov    $0xa,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <getpid>:
SYSCALL(getpid)
 463:	b8 0b 00 00 00       	mov    $0xb,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <sbrk>:
SYSCALL(sbrk)
 46b:	b8 0c 00 00 00       	mov    $0xc,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <sleep>:
SYSCALL(sleep)
 473:	b8 0d 00 00 00       	mov    $0xd,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <uptime>:
SYSCALL(uptime)
 47b:	b8 0e 00 00 00       	mov    $0xe,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <worldpeace>:
SYSCALL(worldpeace)
 483:	b8 16 00 00 00       	mov    $0x16,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <numberofprocesses>:
SYSCALL(numberofprocesses)
 48b:	b8 17 00 00 00       	mov    $0x17,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <whatsthestatus>:
SYSCALL(whatsthestatus)
 493:	b8 18 00 00 00       	mov    $0x18,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <get_sibling>:
SYSCALL(get_sibling)
 49b:	b8 19 00 00 00       	mov    $0x19,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

000004a3 <spawn>:
SYSCALL(spawn)
 4a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

000004ab <getvasize>:
SYSCALL(getvasize)
 4ab:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

000004b3 <va2pa>:
SYSCALL(va2pa)
 4b3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

000004bb <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 4bb:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret

000004c3 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 4c3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret

000004cb <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 4cb:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret

000004d3 <getpasize>:
SYSCALL(getpasize)
 4d3:	b8 20 00 00 00       	mov    $0x20,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret
 4db:	66 90                	xchg   %ax,%ax
 4dd:	66 90                	xchg   %ax,%ax
 4df:	90                   	nop

000004e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	89 cb                	mov    %ecx,%ebx
 4e8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4eb:	89 d1                	mov    %edx,%ecx
{
 4ed:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 4f0:	89 d0                	mov    %edx,%eax
 4f2:	c1 e8 1f             	shr    $0x1f,%eax
 4f5:	84 c0                	test   %al,%al
 4f7:	0f 84 93 00 00 00    	je     590 <printint+0xb0>
 4fd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 501:	0f 84 89 00 00 00    	je     590 <printint+0xb0>
    x = -xx;
 507:	f7 d9                	neg    %ecx
    neg = 1;
 509:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 50e:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 515:	8d 75 d7             	lea    -0x29(%ebp),%esi
 518:	89 45 b8             	mov    %eax,-0x48(%ebp)
 51b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 520:	89 c8                	mov    %ecx,%eax
 522:	31 d2                	xor    %edx,%edx
 524:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 527:	f7 f3                	div    %ebx
 529:	89 45 c0             	mov    %eax,-0x40(%ebp)
 52c:	0f b6 92 e0 09 00 00 	movzbl 0x9e0(%edx),%edx
 533:	8d 47 01             	lea    0x1(%edi),%eax
 536:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 539:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 53d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 53f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 542:	39 da                	cmp    %ebx,%edx
 544:	73 da                	jae    520 <printint+0x40>
  if(neg)
 546:	8b 45 b8             	mov    -0x48(%ebp),%eax
 549:	85 c0                	test   %eax,%eax
 54b:	74 0a                	je     557 <printint+0x77>
    buf[i++] = '-';
 54d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 550:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 555:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 557:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 55a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 55e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 560:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 563:	89 74 24 04          	mov    %esi,0x4(%esp)
 567:	88 45 d7             	mov    %al,-0x29(%ebp)
 56a:	b8 01 00 00 00       	mov    $0x1,%eax
 56f:	89 44 24 08          	mov    %eax,0x8(%esp)
 573:	8b 45 bc             	mov    -0x44(%ebp),%eax
 576:	89 04 24             	mov    %eax,(%esp)
 579:	e8 85 fe ff ff       	call   403 <write>
  while(--i >= 0)
 57e:	89 f8                	mov    %edi,%eax
 580:	4f                   	dec    %edi
 581:	39 d8                	cmp    %ebx,%eax
 583:	75 db                	jne    560 <printint+0x80>
}
 585:	83 c4 4c             	add    $0x4c,%esp
 588:	5b                   	pop    %ebx
 589:	5e                   	pop    %esi
 58a:	5f                   	pop    %edi
 58b:	5d                   	pop    %ebp
 58c:	c3                   	ret
 58d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 590:	31 c0                	xor    %eax,%eax
 592:	e9 77 ff ff ff       	jmp    50e <printint+0x2e>
 597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59e:	00 
 59f:	90                   	nop

000005a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 5ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 5af:	0f b6 13             	movzbl (%ebx),%edx
 5b2:	43                   	inc    %ebx
 5b3:	84 d2                	test   %dl,%dl
 5b5:	74 35                	je     5ec <printf+0x4c>
 5b7:	8d 45 10             	lea    0x10(%ebp),%eax
 5ba:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 5c0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 5c3:	83 f8 25             	cmp    $0x25,%eax
 5c6:	74 30                	je     5f8 <printf+0x58>
  write(fd, &c, 1);
 5c8:	89 34 24             	mov    %esi,(%esp)
 5cb:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 5d0:	43                   	inc    %ebx
  write(fd, &c, 1);
 5d1:	89 44 24 08          	mov    %eax,0x8(%esp)
 5d5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5d8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5dc:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5df:	e8 1f fe ff ff       	call   403 <write>
  for(i = 0; fmt[i]; i++){
 5e4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5e8:	84 d2                	test   %dl,%dl
 5ea:	75 d4                	jne    5c0 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5ec:	83 c4 3c             	add    $0x3c,%esp
 5ef:	5b                   	pop    %ebx
 5f0:	5e                   	pop    %esi
 5f1:	5f                   	pop    %edi
 5f2:	5d                   	pop    %ebp
 5f3:	c3                   	ret
 5f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 5f8:	0f b6 13             	movzbl (%ebx),%edx
 5fb:	84 d2                	test   %dl,%dl
 5fd:	74 ed                	je     5ec <printf+0x4c>
    c = fmt[i] & 0xff;
 5ff:	80 fa 25             	cmp    $0x25,%dl
 602:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 605:	0f 84 75 01 00 00    	je     780 <printf+0x1e0>
 60b:	83 e8 63             	sub    $0x63,%eax
 60e:	83 f8 15             	cmp    $0x15,%eax
 611:	77 0d                	ja     620 <printf+0x80>
 613:	ff 24 85 88 09 00 00 	jmp    *0x988(,%eax,4)
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 620:	89 34 24             	mov    %esi,(%esp)
 623:	8d 7d e7             	lea    -0x19(%ebp),%edi
 626:	b8 01 00 00 00       	mov    $0x1,%eax
 62b:	89 44 24 08          	mov    %eax,0x8(%esp)
 62f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 633:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 636:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 63a:	e8 c4 fd ff ff       	call   403 <write>
        putc(fd, c);
 63f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 643:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 646:	ba 01 00 00 00       	mov    $0x1,%edx
 64b:	89 54 24 08          	mov    %edx,0x8(%esp)
 64f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 653:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 656:	89 34 24             	mov    %esi,(%esp)
 659:	e8 a5 fd ff ff       	call   403 <write>
  for(i = 0; fmt[i]; i++){
 65e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 662:	84 d2                	test   %dl,%dl
 664:	0f 85 56 ff ff ff    	jne    5c0 <printf+0x20>
}
 66a:	83 c4 3c             	add    $0x3c,%esp
 66d:	5b                   	pop    %ebx
 66e:	5e                   	pop    %esi
 66f:	5f                   	pop    %edi
 670:	5d                   	pop    %ebp
 671:	c3                   	ret
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 678:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 67b:	b9 10 00 00 00       	mov    $0x10,%ecx
 680:	8b 17                	mov    (%edi),%edx
 682:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 689:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 68c:	89 f0                	mov    %esi,%eax
 68e:	e8 4d fe ff ff       	call   4e0 <printint>
  for(i = 0; fmt[i]; i++){
 693:	83 c3 02             	add    $0x2,%ebx
        ap++;
 696:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 699:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 69d:	84 d2                	test   %dl,%dl
 69f:	0f 85 1b ff ff ff    	jne    5c0 <printf+0x20>
}
 6a5:	83 c4 3c             	add    $0x3c,%esp
 6a8:	5b                   	pop    %ebx
 6a9:	5e                   	pop    %esi
 6aa:	5f                   	pop    %edi
 6ab:	5d                   	pop    %ebp
 6ac:	c3                   	ret
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 6b0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 6b3:	8b 01                	mov    (%ecx),%eax
        ap++;
 6b5:	83 c1 04             	add    $0x4,%ecx
 6b8:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 6bb:	85 c0                	test   %eax,%eax
 6bd:	0f 84 d5 00 00 00    	je     798 <printf+0x1f8>
        while(*s != 0){
 6c3:	0f b6 10             	movzbl (%eax),%edx
 6c6:	84 d2                	test   %dl,%dl
 6c8:	74 39                	je     703 <printf+0x163>
 6ca:	89 c7                	mov    %eax,%edi
 6cc:	88 d0                	mov    %dl,%al
 6ce:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6d1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6d4:	89 fb                	mov    %edi,%ebx
 6d6:	89 cf                	mov    %ecx,%edi
 6d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6df:	00 
          putc(fd, *s);
 6e0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6e3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 6e8:	43                   	inc    %ebx
  write(fd, &c, 1);
 6e9:	89 44 24 08          	mov    %eax,0x8(%esp)
 6ed:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6f1:	89 34 24             	mov    %esi,(%esp)
 6f4:	e8 0a fd ff ff       	call   403 <write>
        while(*s != 0){
 6f9:	0f b6 03             	movzbl (%ebx),%eax
 6fc:	84 c0                	test   %al,%al
 6fe:	75 e0                	jne    6e0 <printf+0x140>
 700:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 703:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 707:	83 c3 02             	add    $0x2,%ebx
 70a:	84 d2                	test   %dl,%dl
 70c:	0f 85 ae fe ff ff    	jne    5c0 <printf+0x20>
 712:	e9 d5 fe ff ff       	jmp    5ec <printf+0x4c>
 717:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 71e:	00 
 71f:	90                   	nop
        printint(fd, *ap, 10, 1);
 720:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 723:	b9 0a 00 00 00       	mov    $0xa,%ecx
 728:	8b 17                	mov    (%edi),%edx
 72a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 731:	e9 53 ff ff ff       	jmp    689 <printf+0xe9>
 736:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73d:	00 
 73e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 740:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 743:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 748:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 74b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 74d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 751:	8d 7d e7             	lea    -0x19(%ebp),%edi
 754:	89 7c 24 04          	mov    %edi,0x4(%esp)
 758:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 75b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 75e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 762:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 765:	e8 99 fc ff ff       	call   403 <write>
        ap++;
 76a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 76e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 772:	84 d2                	test   %dl,%dl
 774:	0f 85 46 fe ff ff    	jne    5c0 <printf+0x20>
 77a:	e9 6d fe ff ff       	jmp    5ec <printf+0x4c>
 77f:	90                   	nop
        putc(fd, c);
 780:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 783:	8d 7d e7             	lea    -0x19(%ebp),%edi
 786:	b9 01 00 00 00       	mov    $0x1,%ecx
 78b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 78f:	e9 bb fe ff ff       	jmp    64f <printf+0xaf>
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 798:	bf 7f 09 00 00       	mov    $0x97f,%edi
 79d:	b0 28                	mov    $0x28,%al
 79f:	e9 2a ff ff ff       	jmp    6ce <printf+0x12e>
 7a4:	66 90                	xchg   %ax,%ax
 7a6:	66 90                	xchg   %ax,%ax
 7a8:	66 90                	xchg   %ax,%ax
 7aa:	66 90                	xchg   %ax,%ax
 7ac:	66 90                	xchg   %ax,%ax
 7ae:	66 90                	xchg   %ax,%ax

000007b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b1:	a1 00 0c 00 00       	mov    0xc00,%eax
{
 7b6:	89 e5                	mov    %esp,%ebp
 7b8:	57                   	push   %edi
 7b9:	56                   	push   %esi
 7ba:	53                   	push   %ebx
 7bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 7be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7c8:	00 
 7c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7d0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d4:	39 ca                	cmp    %ecx,%edx
 7d6:	73 30                	jae    808 <free+0x58>
 7d8:	39 c1                	cmp    %eax,%ecx
 7da:	72 04                	jb     7e0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7dc:	39 c2                	cmp    %eax,%edx
 7de:	72 f0                	jb     7d0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7e6:	39 f8                	cmp    %edi,%eax
 7e8:	74 36                	je     820 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7ea:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7ed:	8b 42 04             	mov    0x4(%edx),%eax
 7f0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7f3:	39 f1                	cmp    %esi,%ecx
 7f5:	74 42                	je     839 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7f7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7f9:	5b                   	pop    %ebx
  freep = p;
 7fa:	89 15 00 0c 00 00    	mov    %edx,0xc00
}
 800:	5e                   	pop    %esi
 801:	5f                   	pop    %edi
 802:	5d                   	pop    %ebp
 803:	c3                   	ret
 804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 808:	39 c2                	cmp    %eax,%edx
 80a:	72 c4                	jb     7d0 <free+0x20>
 80c:	39 c1                	cmp    %eax,%ecx
 80e:	73 c0                	jae    7d0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 810:	8b 73 fc             	mov    -0x4(%ebx),%esi
 813:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 816:	39 f8                	cmp    %edi,%eax
 818:	75 d0                	jne    7ea <free+0x3a>
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 820:	8b 78 04             	mov    0x4(%eax),%edi
 823:	01 fe                	add    %edi,%esi
 825:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 828:	8b 02                	mov    (%edx),%eax
 82a:	8b 00                	mov    (%eax),%eax
 82c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 82f:	8b 42 04             	mov    0x4(%edx),%eax
 832:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 835:	39 f1                	cmp    %esi,%ecx
 837:	75 be                	jne    7f7 <free+0x47>
  freep = p;
 839:	89 15 00 0c 00 00    	mov    %edx,0xc00
    p->s.size += bp->s.size;
 83f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 842:	01 c8                	add    %ecx,%eax
 844:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 847:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 84a:	89 0a                	mov    %ecx,(%edx)
}
 84c:	5b                   	pop    %ebx
 84d:	5e                   	pop    %esi
 84e:	5f                   	pop    %edi
 84f:	5d                   	pop    %ebp
 850:	c3                   	ret
 851:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 858:	00 
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000860 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	57                   	push   %edi
 864:	56                   	push   %esi
 865:	53                   	push   %ebx
 866:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 869:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 86c:	8b 15 00 0c 00 00    	mov    0xc00,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 872:	8d 78 07             	lea    0x7(%eax),%edi
 875:	c1 ef 03             	shr    $0x3,%edi
 878:	47                   	inc    %edi
  if((prevp = freep) == 0){
 879:	85 d2                	test   %edx,%edx
 87b:	0f 84 8f 00 00 00    	je     910 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 881:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 883:	8b 48 04             	mov    0x4(%eax),%ecx
 886:	39 f9                	cmp    %edi,%ecx
 888:	73 5e                	jae    8e8 <malloc+0x88>
  if(nu < 4096)
 88a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 88f:	39 df                	cmp    %ebx,%edi
 891:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 894:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 89b:	eb 0c                	jmp    8a9 <malloc+0x49>
 89d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8a2:	8b 48 04             	mov    0x4(%eax),%ecx
 8a5:	39 f9                	cmp    %edi,%ecx
 8a7:	73 3f                	jae    8e8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8a9:	39 05 00 0c 00 00    	cmp    %eax,0xc00
 8af:	89 c2                	mov    %eax,%edx
 8b1:	75 ed                	jne    8a0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 8b3:	89 34 24             	mov    %esi,(%esp)
 8b6:	e8 b0 fb ff ff       	call   46b <sbrk>
  if(p == (char*)-1)
 8bb:	83 f8 ff             	cmp    $0xffffffff,%eax
 8be:	74 18                	je     8d8 <malloc+0x78>
  hp->s.size = nu;
 8c0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 8c3:	83 c0 08             	add    $0x8,%eax
 8c6:	89 04 24             	mov    %eax,(%esp)
 8c9:	e8 e2 fe ff ff       	call   7b0 <free>
  return freep;
 8ce:	8b 15 00 0c 00 00    	mov    0xc00,%edx
      if((p = morecore(nunits)) == 0)
 8d4:	85 d2                	test   %edx,%edx
 8d6:	75 c8                	jne    8a0 <malloc+0x40>
        return 0;
  }
}
 8d8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 8db:	31 c0                	xor    %eax,%eax
}
 8dd:	5b                   	pop    %ebx
 8de:	5e                   	pop    %esi
 8df:	5f                   	pop    %edi
 8e0:	5d                   	pop    %ebp
 8e1:	c3                   	ret
 8e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8e8:	39 cf                	cmp    %ecx,%edi
 8ea:	74 54                	je     940 <malloc+0xe0>
        p->s.size -= nunits;
 8ec:	29 f9                	sub    %edi,%ecx
 8ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8f4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8f7:	89 15 00 0c 00 00    	mov    %edx,0xc00
}
 8fd:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 900:	83 c0 08             	add    $0x8,%eax
}
 903:	5b                   	pop    %ebx
 904:	5e                   	pop    %esi
 905:	5f                   	pop    %edi
 906:	5d                   	pop    %ebp
 907:	c3                   	ret
 908:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 90f:	00 
    base.s.ptr = freep = prevp = &base;
 910:	b8 04 0c 00 00       	mov    $0xc04,%eax
 915:	ba 04 0c 00 00       	mov    $0xc04,%edx
 91a:	a3 00 0c 00 00       	mov    %eax,0xc00
    base.s.size = 0;
 91f:	31 c9                	xor    %ecx,%ecx
 921:	b8 04 0c 00 00       	mov    $0xc04,%eax
    base.s.ptr = freep = prevp = &base;
 926:	89 15 04 0c 00 00    	mov    %edx,0xc04
    base.s.size = 0;
 92c:	89 0d 08 0c 00 00    	mov    %ecx,0xc08
    if(p->s.size >= nunits){
 932:	e9 53 ff ff ff       	jmp    88a <malloc+0x2a>
 937:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 93e:	00 
 93f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 940:	8b 08                	mov    (%eax),%ecx
 942:	89 0a                	mov    %ecx,(%edx)
 944:	eb b1                	jmp    8f7 <malloc+0x97>
