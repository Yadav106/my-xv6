
_numps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
            free(a);
         } // Simulate some busy work
    }
}

int main(void) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp
    int pid1 = fork();
   c:	e8 ba 03 00 00       	call   3cb <fork>
    if (pid1 == 0)
  11:	85 c0                	test   %eax,%eax
  13:	75 11                	jne    26 <main+0x26>
    {
        // Child process 1

        busy_loop1(SHORT_LOOP); 
  15:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  1c:	e8 8f 00 00 00       	call   b0 <busy_loop1>
        exit();
  21:	e8 ad 03 00 00       	call   3d3 <exit>
    }
    else if(fork()==0)
  26:	e8 a0 03 00 00       	call   3cb <fork>
  2b:	85 c0                	test   %eax,%eax
  2d:	8d 76 00             	lea    0x0(%esi),%esi
  30:	75 11                	jne    43 <main+0x43>
    {
        // Child process 2
        busy_loop2(LONG_LOOP); 
  32:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
  39:	e8 72 00 00 00       	call   b0 <busy_loop1>
        exit();
  3e:	e8 90 03 00 00       	call   3d3 <exit>
    }

    // Parent process
    int n1 = numberofprocesses();
  43:	e8 33 04 00 00       	call   47b <numberofprocesses>
  48:	89 c7                	mov    %eax,%edi

    wait(); // Wait for child 1
  4a:	e8 8c 03 00 00       	call   3db <wait>
    int n2 = numberofprocesses();
  4f:	e8 27 04 00 00       	call   47b <numberofprocesses>
  54:	89 c6                	mov    %eax,%esi

    wait(); // Wait for child 2
  56:	e8 80 03 00 00       	call   3db <wait>
    int n3= numberofprocesses();
  5b:	e8 1b 04 00 00       	call   47b <numberofprocesses>

    printf(1, "ready processes: %d\n", n1);
  60:	89 7c 24 08          	mov    %edi,0x8(%esp)
  64:	c7 44 24 04 38 09 00 	movl   $0x938,0x4(%esp)
  6b:	00 
  6c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    int n3= numberofprocesses();
  73:	89 c3                	mov    %eax,%ebx
    printf(1, "ready processes: %d\n", n1);
  75:	e8 16 05 00 00       	call   590 <printf>
    printf(1, "ready processes: %d\n", n2);
  7a:	89 74 24 08          	mov    %esi,0x8(%esp)
  7e:	c7 44 24 04 38 09 00 	movl   $0x938,0x4(%esp)
  85:	00 
  86:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  8d:	e8 fe 04 00 00       	call   590 <printf>
    printf(1, "ready processes: %d\n", n3);
  92:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  96:	c7 44 24 04 38 09 00 	movl   $0x938,0x4(%esp)
  9d:	00 
  9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a5:	e8 e6 04 00 00       	call   590 <printf>



    exit();
  aa:	e8 24 03 00 00       	call   3d3 <exit>
  af:	90                   	nop

000000b0 <busy_loop1>:
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	31 f6                	xor    %esi,%esi
  b7:	53                   	push   %ebx
  b8:	83 ec 1c             	sub    $0x1c,%esp
    for (i = 0; i < n; i++) {
  bb:	8b 45 08             	mov    0x8(%ebp),%eax
  be:	85 c0                	test   %eax,%eax
  c0:	7e 4e                	jle    110 <busy_loop1+0x60>
  c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  c9:	00 
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  d0:	31 db                	xor    %ebx,%ebx
        for (int j = 0; j < n; j++)
  d2:	31 ff                	xor    %edi,%edi
  d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  db:	00 
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    	    int*a =malloc(sizeof(int));
  e0:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  e7:	e8 64 07 00 00       	call   850 <malloc>
            *a=i*j;
  ec:	89 18                	mov    %ebx,(%eax)
        for (int j = 0; j < n; j++)
  ee:	01 f3                	add    %esi,%ebx
            free(a);
  f0:	89 04 24             	mov    %eax,(%esp)
  f3:	e8 a8 06 00 00       	call   7a0 <free>
        for (int j = 0; j < n; j++)
  f8:	89 f8                	mov    %edi,%eax
  fa:	47                   	inc    %edi
  fb:	39 7d 08             	cmp    %edi,0x8(%ebp)
  fe:	75 e0                	jne    e0 <busy_loop1+0x30>
    for (i = 0; i < n; i++) {
 100:	8d 56 01             	lea    0x1(%esi),%edx
 103:	39 c6                	cmp    %eax,%esi
 105:	74 09                	je     110 <busy_loop1+0x60>
 107:	89 d6                	mov    %edx,%esi
 109:	eb c5                	jmp    d0 <busy_loop1+0x20>
 10b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
 110:	83 c4 1c             	add    $0x1c,%esp
 113:	5b                   	pop    %ebx
 114:	5e                   	pop    %esi
 115:	5f                   	pop    %edi
 116:	5d                   	pop    %ebp
 117:	c3                   	ret
 118:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11f:	00 

00000120 <busy_loop2>:
void busy_loop2(int n)
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
 125:	31 f6                	xor    %esi,%esi
 127:	53                   	push   %ebx
 128:	83 ec 1c             	sub    $0x1c,%esp
 12b:	8b 45 08             	mov    0x8(%ebp),%eax
 12e:	85 c0                	test   %eax,%eax
 130:	7e 4e                	jle    180 <busy_loop2+0x60>
 132:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 139:	00 
 13a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 140:	31 db                	xor    %ebx,%ebx
 142:	31 ff                	xor    %edi,%edi
 144:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14b:	00 
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
 157:	e8 f4 06 00 00       	call   850 <malloc>
 15c:	89 18                	mov    %ebx,(%eax)
 15e:	01 f3                	add    %esi,%ebx
 160:	89 04 24             	mov    %eax,(%esp)
 163:	e8 38 06 00 00       	call   7a0 <free>
 168:	89 f8                	mov    %edi,%eax
 16a:	47                   	inc    %edi
 16b:	39 7d 08             	cmp    %edi,0x8(%ebp)
 16e:	75 e0                	jne    150 <busy_loop2+0x30>
 170:	8d 56 01             	lea    0x1(%esi),%edx
 173:	39 c6                	cmp    %eax,%esi
 175:	74 09                	je     180 <busy_loop2+0x60>
 177:	89 d6                	mov    %edx,%esi
 179:	eb c5                	jmp    140 <busy_loop2+0x20>
 17b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 180:	83 c4 1c             	add    $0x1c,%esp
 183:	5b                   	pop    %ebx
 184:	5e                   	pop    %esi
 185:	5f                   	pop    %edi
 186:	5d                   	pop    %ebp
 187:	c3                   	ret
 188:	66 90                	xchg   %ax,%ax
 18a:	66 90                	xchg   %ax,%ax
 18c:	66 90                	xchg   %ax,%ax
 18e:	66 90                	xchg   %ax,%ax

00000190 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 190:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 191:	31 c0                	xor    %eax,%eax
{
 193:	89 e5                	mov    %esp,%ebp
 195:	53                   	push   %ebx
 196:	8b 4d 08             	mov    0x8(%ebp),%ecx
 199:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1a7:	40                   	inc    %eax
 1a8:	84 d2                	test   %dl,%dl
 1aa:	75 f4                	jne    1a0 <strcpy+0x10>
    ;
  return os;
}
 1ac:	5b                   	pop    %ebx
 1ad:	89 c8                	mov    %ecx,%eax
 1af:	5d                   	pop    %ebp
 1b0:	c3                   	ret
 1b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1b8:	00 
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 55 08             	mov    0x8(%ebp),%edx
 1c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 1ca:	0f b6 02             	movzbl (%edx),%eax
 1cd:	84 c0                	test   %al,%al
 1cf:	75 15                	jne    1e6 <strcmp+0x26>
 1d1:	eb 30                	jmp    203 <strcmp+0x43>
 1d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1d8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1dc:	8d 4b 01             	lea    0x1(%ebx),%ecx
 1df:	42                   	inc    %edx
  while(*p && *p == *q)
 1e0:	84 c0                	test   %al,%al
 1e2:	74 14                	je     1f8 <strcmp+0x38>
 1e4:	89 cb                	mov    %ecx,%ebx
 1e6:	0f b6 0b             	movzbl (%ebx),%ecx
 1e9:	38 c1                	cmp    %al,%cl
 1eb:	74 eb                	je     1d8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 1ed:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 1ee:	29 c8                	sub    %ecx,%eax
}
 1f0:	5d                   	pop    %ebp
 1f1:	c3                   	ret
 1f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 1f8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 1fc:	31 c0                	xor    %eax,%eax
}
 1fe:	5b                   	pop    %ebx
 1ff:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 200:	29 c8                	sub    %ecx,%eax
}
 202:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 203:	0f b6 0b             	movzbl (%ebx),%ecx
 206:	31 c0                	xor    %eax,%eax
 208:	eb e3                	jmp    1ed <strcmp+0x2d>
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000210 <strlen>:

uint
strlen(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 3a 00             	cmpb   $0x0,(%edx)
 219:	74 15                	je     230 <strlen+0x20>
 21b:	31 c0                	xor    %eax,%eax
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	40                   	inc    %eax
 221:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 225:	89 c1                	mov    %eax,%ecx
 227:	75 f7                	jne    220 <strlen+0x10>
    ;
  return n;
}
 229:	5d                   	pop    %ebp
 22a:	89 c8                	mov    %ecx,%eax
 22c:	c3                   	ret
 22d:	8d 76 00             	lea    0x0(%esi),%esi
 230:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 231:	31 c9                	xor    %ecx,%ecx
}
 233:	89 c8                	mov    %ecx,%eax
 235:	c3                   	ret
 236:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23d:	00 
 23e:	66 90                	xchg   %ax,%ax

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 55 08             	mov    0x8(%ebp),%edx
 246:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	5f                   	pop    %edi
 253:	89 d0                	mov    %edx,%eax
 255:	5d                   	pop    %ebp
 256:	c3                   	ret
 257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25e:	00 
 25f:	90                   	nop

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	75 10                	jne    281 <strchr+0x21>
 271:	eb 1d                	jmp    290 <strchr+0x30>
 273:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 27c:	40                   	inc    %eax
 27d:	84 d2                	test   %dl,%dl
 27f:	74 0f                	je     290 <strchr+0x30>
    if(*s == c)
 281:	38 d1                	cmp    %dl,%cl
 283:	75 f3                	jne    278 <strchr+0x18>
      return (char*)s;
  return 0;
}
 285:	5d                   	pop    %ebp
 286:	c3                   	ret
 287:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28e:	00 
 28f:	90                   	nop
 290:	5d                   	pop    %ebp
  return 0;
 291:	31 c0                	xor    %eax,%eax
}
 293:	c3                   	ret
 294:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29b:	00 
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a5:	31 f6                	xor    %esi,%esi
{
 2a7:	53                   	push   %ebx
    cc = read(0, &c, 1);
 2a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 2ab:	83 ec 3c             	sub    $0x3c,%esp
 2ae:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 2b1:	eb 32                	jmp    2e5 <gets+0x45>
 2b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 2b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2bc:	b8 01 00 00 00       	mov    $0x1,%eax
 2c1:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2cc:	e8 1a 01 00 00       	call   3eb <read>
    if(cc < 1)
 2d1:	85 c0                	test   %eax,%eax
 2d3:	7e 19                	jle    2ee <gets+0x4e>
      break;
    buf[i++] = c;
 2d5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2d9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 2dd:	3c 0a                	cmp    $0xa,%al
 2df:	74 10                	je     2f1 <gets+0x51>
 2e1:	3c 0d                	cmp    $0xd,%al
 2e3:	74 0c                	je     2f1 <gets+0x51>
  for(i=0; i+1 < max; ){
 2e5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2e8:	46                   	inc    %esi
 2e9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2ec:	7c ca                	jl     2b8 <gets+0x18>
 2ee:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 2f1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 2f5:	83 c4 3c             	add    $0x3c,%esp
 2f8:	89 d8                	mov    %ebx,%eax
 2fa:	5b                   	pop    %ebx
 2fb:	5e                   	pop    %esi
 2fc:	5f                   	pop    %edi
 2fd:	5d                   	pop    %ebp
 2fe:	c3                   	ret
 2ff:	90                   	nop

00000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 301:	31 c0                	xor    %eax,%eax
{
 303:	89 e5                	mov    %esp,%ebp
 305:	83 ec 18             	sub    $0x18,%esp
 308:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 30b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 30e:	89 44 24 04          	mov    %eax,0x4(%esp)
 312:	8b 45 08             	mov    0x8(%ebp),%eax
 315:	89 04 24             	mov    %eax,(%esp)
 318:	e8 f6 00 00 00       	call   413 <open>
  if(fd < 0)
 31d:	85 c0                	test   %eax,%eax
 31f:	78 2f                	js     350 <stat+0x50>
 321:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 323:	8b 45 0c             	mov    0xc(%ebp),%eax
 326:	89 1c 24             	mov    %ebx,(%esp)
 329:	89 44 24 04          	mov    %eax,0x4(%esp)
 32d:	e8 f9 00 00 00       	call   42b <fstat>
  close(fd);
 332:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 335:	89 c6                	mov    %eax,%esi
  close(fd);
 337:	e8 bf 00 00 00       	call   3fb <close>
  return r;
}
 33c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 33f:	89 f0                	mov    %esi,%eax
 341:	8b 75 fc             	mov    -0x4(%ebp),%esi
 344:	89 ec                	mov    %ebp,%esp
 346:	5d                   	pop    %ebp
 347:	c3                   	ret
 348:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34f:	00 
    return -1;
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb e5                	jmp    33c <stat+0x3c>
 357:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35e:	00 
 35f:	90                   	nop

00000360 <atoi>:

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 367:	0f be 02             	movsbl (%edx),%eax
 36a:	88 c1                	mov    %al,%cl
 36c:	80 e9 30             	sub    $0x30,%cl
 36f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 372:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 377:	77 1c                	ja     395 <atoi+0x35>
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 380:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 383:	42                   	inc    %edx
 384:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 388:	0f be 02             	movsbl (%edx),%eax
 38b:	88 c3                	mov    %al,%bl
 38d:	80 eb 30             	sub    $0x30,%bl
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
  return n;
}
 395:	5b                   	pop    %ebx
 396:	89 c8                	mov    %ecx,%eax
 398:	5d                   	pop    %ebp
 399:	c3                   	ret
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	8b 45 10             	mov    0x10(%ebp),%eax
 3a7:	56                   	push   %esi
 3a8:	8b 55 08             	mov    0x8(%ebp),%edx
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	85 c0                	test   %eax,%eax
 3b0:	7e 13                	jle    3c5 <memmove+0x25>
 3b2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3b4:	89 d7                	mov    %edx,%edi
 3b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bd:	00 
 3be:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 3c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3c1:	39 f8                	cmp    %edi,%eax
 3c3:	75 fb                	jne    3c0 <memmove+0x20>
  return vdst;
}
 3c5:	5e                   	pop    %esi
 3c6:	89 d0                	mov    %edx,%eax
 3c8:	5f                   	pop    %edi
 3c9:	5d                   	pop    %ebp
 3ca:	c3                   	ret

000003cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3cb:	b8 01 00 00 00       	mov    $0x1,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <exit>:
SYSCALL(exit)
 3d3:	b8 02 00 00 00       	mov    $0x2,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <wait>:
SYSCALL(wait)
 3db:	b8 03 00 00 00       	mov    $0x3,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <pipe>:
SYSCALL(pipe)
 3e3:	b8 04 00 00 00       	mov    $0x4,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <read>:
SYSCALL(read)
 3eb:	b8 05 00 00 00       	mov    $0x5,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <write>:
SYSCALL(write)
 3f3:	b8 10 00 00 00       	mov    $0x10,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <close>:
SYSCALL(close)
 3fb:	b8 15 00 00 00       	mov    $0x15,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <kill>:
SYSCALL(kill)
 403:	b8 06 00 00 00       	mov    $0x6,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <exec>:
SYSCALL(exec)
 40b:	b8 07 00 00 00       	mov    $0x7,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <open>:
SYSCALL(open)
 413:	b8 0f 00 00 00       	mov    $0xf,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <mknod>:
SYSCALL(mknod)
 41b:	b8 11 00 00 00       	mov    $0x11,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <unlink>:
SYSCALL(unlink)
 423:	b8 12 00 00 00       	mov    $0x12,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <fstat>:
SYSCALL(fstat)
 42b:	b8 08 00 00 00       	mov    $0x8,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <link>:
SYSCALL(link)
 433:	b8 13 00 00 00       	mov    $0x13,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <mkdir>:
SYSCALL(mkdir)
 43b:	b8 14 00 00 00       	mov    $0x14,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <chdir>:
SYSCALL(chdir)
 443:	b8 09 00 00 00       	mov    $0x9,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <dup>:
SYSCALL(dup)
 44b:	b8 0a 00 00 00       	mov    $0xa,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <getpid>:
SYSCALL(getpid)
 453:	b8 0b 00 00 00       	mov    $0xb,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <sbrk>:
SYSCALL(sbrk)
 45b:	b8 0c 00 00 00       	mov    $0xc,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <sleep>:
SYSCALL(sleep)
 463:	b8 0d 00 00 00       	mov    $0xd,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <uptime>:
SYSCALL(uptime)
 46b:	b8 0e 00 00 00       	mov    $0xe,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <worldpeace>:
SYSCALL(worldpeace)
 473:	b8 16 00 00 00       	mov    $0x16,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <numberofprocesses>:
SYSCALL(numberofprocesses)
 47b:	b8 17 00 00 00       	mov    $0x17,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <whatsthestatus>:
SYSCALL(whatsthestatus)
 483:	b8 18 00 00 00       	mov    $0x18,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <get_sibling>:
SYSCALL(get_sibling)
 48b:	b8 19 00 00 00       	mov    $0x19,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <spawn>:
SYSCALL(spawn)
 493:	b8 1a 00 00 00       	mov    $0x1a,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <getvasize>:
SYSCALL(getvasize)
 49b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

000004a3 <va2pa>:
SYSCALL(va2pa)
 4a3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

000004ab <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 4ab:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

000004b3 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 4b3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

000004bb <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 4bb:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret

000004c3 <getpasize>:
SYSCALL(getpasize)
 4c3:	b8 20 00 00 00       	mov    $0x20,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret
 4cb:	66 90                	xchg   %ax,%ax
 4cd:	66 90                	xchg   %ax,%ax
 4cf:	90                   	nop

000004d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	89 cb                	mov    %ecx,%ebx
 4d8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4db:	89 d1                	mov    %edx,%ecx
{
 4dd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 4e0:	89 d0                	mov    %edx,%eax
 4e2:	c1 e8 1f             	shr    $0x1f,%eax
 4e5:	84 c0                	test   %al,%al
 4e7:	0f 84 93 00 00 00    	je     580 <printint+0xb0>
 4ed:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4f1:	0f 84 89 00 00 00    	je     580 <printint+0xb0>
    x = -xx;
 4f7:	f7 d9                	neg    %ecx
    neg = 1;
 4f9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4fe:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 505:	8d 75 d7             	lea    -0x29(%ebp),%esi
 508:	89 45 b8             	mov    %eax,-0x48(%ebp)
 50b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 510:	89 c8                	mov    %ecx,%eax
 512:	31 d2                	xor    %edx,%edx
 514:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 517:	f7 f3                	div    %ebx
 519:	89 45 c0             	mov    %eax,-0x40(%ebp)
 51c:	0f b6 92 ac 09 00 00 	movzbl 0x9ac(%edx),%edx
 523:	8d 47 01             	lea    0x1(%edi),%eax
 526:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 529:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 52d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 52f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 532:	39 da                	cmp    %ebx,%edx
 534:	73 da                	jae    510 <printint+0x40>
  if(neg)
 536:	8b 45 b8             	mov    -0x48(%ebp),%eax
 539:	85 c0                	test   %eax,%eax
 53b:	74 0a                	je     547 <printint+0x77>
    buf[i++] = '-';
 53d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 540:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 545:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 547:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 54a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 54e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 550:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 553:	89 74 24 04          	mov    %esi,0x4(%esp)
 557:	88 45 d7             	mov    %al,-0x29(%ebp)
 55a:	b8 01 00 00 00       	mov    $0x1,%eax
 55f:	89 44 24 08          	mov    %eax,0x8(%esp)
 563:	8b 45 bc             	mov    -0x44(%ebp),%eax
 566:	89 04 24             	mov    %eax,(%esp)
 569:	e8 85 fe ff ff       	call   3f3 <write>
  while(--i >= 0)
 56e:	89 f8                	mov    %edi,%eax
 570:	4f                   	dec    %edi
 571:	39 d8                	cmp    %ebx,%eax
 573:	75 db                	jne    550 <printint+0x80>
}
 575:	83 c4 4c             	add    $0x4c,%esp
 578:	5b                   	pop    %ebx
 579:	5e                   	pop    %esi
 57a:	5f                   	pop    %edi
 57b:	5d                   	pop    %ebp
 57c:	c3                   	ret
 57d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 580:	31 c0                	xor    %eax,%eax
 582:	e9 77 ff ff ff       	jmp    4fe <printint+0x2e>
 587:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 58e:	00 
 58f:	90                   	nop

00000590 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 599:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 59c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 59f:	0f b6 13             	movzbl (%ebx),%edx
 5a2:	43                   	inc    %ebx
 5a3:	84 d2                	test   %dl,%dl
 5a5:	74 35                	je     5dc <printf+0x4c>
 5a7:	8d 45 10             	lea    0x10(%ebp),%eax
 5aa:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 5b0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 5b3:	83 f8 25             	cmp    $0x25,%eax
 5b6:	74 30                	je     5e8 <printf+0x58>
  write(fd, &c, 1);
 5b8:	89 34 24             	mov    %esi,(%esp)
 5bb:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 5c0:	43                   	inc    %ebx
  write(fd, &c, 1);
 5c1:	89 44 24 08          	mov    %eax,0x8(%esp)
 5c5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cc:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5cf:	e8 1f fe ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 5d4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5d8:	84 d2                	test   %dl,%dl
 5da:	75 d4                	jne    5b0 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5dc:	83 c4 3c             	add    $0x3c,%esp
 5df:	5b                   	pop    %ebx
 5e0:	5e                   	pop    %esi
 5e1:	5f                   	pop    %edi
 5e2:	5d                   	pop    %ebp
 5e3:	c3                   	ret
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 5e8:	0f b6 13             	movzbl (%ebx),%edx
 5eb:	84 d2                	test   %dl,%dl
 5ed:	74 ed                	je     5dc <printf+0x4c>
    c = fmt[i] & 0xff;
 5ef:	80 fa 25             	cmp    $0x25,%dl
 5f2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 5f5:	0f 84 75 01 00 00    	je     770 <printf+0x1e0>
 5fb:	83 e8 63             	sub    $0x63,%eax
 5fe:	83 f8 15             	cmp    $0x15,%eax
 601:	77 0d                	ja     610 <printf+0x80>
 603:	ff 24 85 54 09 00 00 	jmp    *0x954(,%eax,4)
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 610:	89 34 24             	mov    %esi,(%esp)
 613:	8d 7d e7             	lea    -0x19(%ebp),%edi
 616:	b8 01 00 00 00       	mov    $0x1,%eax
 61b:	89 44 24 08          	mov    %eax,0x8(%esp)
 61f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 623:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 626:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 62a:	e8 c4 fd ff ff       	call   3f3 <write>
        putc(fd, c);
 62f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 633:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 636:	ba 01 00 00 00       	mov    $0x1,%edx
 63b:	89 54 24 08          	mov    %edx,0x8(%esp)
 63f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 643:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 646:	89 34 24             	mov    %esi,(%esp)
 649:	e8 a5 fd ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 64e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 652:	84 d2                	test   %dl,%dl
 654:	0f 85 56 ff ff ff    	jne    5b0 <printf+0x20>
}
 65a:	83 c4 3c             	add    $0x3c,%esp
 65d:	5b                   	pop    %ebx
 65e:	5e                   	pop    %esi
 65f:	5f                   	pop    %edi
 660:	5d                   	pop    %ebp
 661:	c3                   	ret
 662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 668:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 66b:	b9 10 00 00 00       	mov    $0x10,%ecx
 670:	8b 17                	mov    (%edi),%edx
 672:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 679:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 67c:	89 f0                	mov    %esi,%eax
 67e:	e8 4d fe ff ff       	call   4d0 <printint>
  for(i = 0; fmt[i]; i++){
 683:	83 c3 02             	add    $0x2,%ebx
        ap++;
 686:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 689:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 68d:	84 d2                	test   %dl,%dl
 68f:	0f 85 1b ff ff ff    	jne    5b0 <printf+0x20>
}
 695:	83 c4 3c             	add    $0x3c,%esp
 698:	5b                   	pop    %ebx
 699:	5e                   	pop    %esi
 69a:	5f                   	pop    %edi
 69b:	5d                   	pop    %ebp
 69c:	c3                   	ret
 69d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 6a0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 6a3:	8b 01                	mov    (%ecx),%eax
        ap++;
 6a5:	83 c1 04             	add    $0x4,%ecx
 6a8:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 6ab:	85 c0                	test   %eax,%eax
 6ad:	0f 84 d5 00 00 00    	je     788 <printf+0x1f8>
        while(*s != 0){
 6b3:	0f b6 10             	movzbl (%eax),%edx
 6b6:	84 d2                	test   %dl,%dl
 6b8:	74 39                	je     6f3 <printf+0x163>
 6ba:	89 c7                	mov    %eax,%edi
 6bc:	88 d0                	mov    %dl,%al
 6be:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6c1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6c4:	89 fb                	mov    %edi,%ebx
 6c6:	89 cf                	mov    %ecx,%edi
 6c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6cf:	00 
          putc(fd, *s);
 6d0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6d3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 6d8:	43                   	inc    %ebx
  write(fd, &c, 1);
 6d9:	89 44 24 08          	mov    %eax,0x8(%esp)
 6dd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6e1:	89 34 24             	mov    %esi,(%esp)
 6e4:	e8 0a fd ff ff       	call   3f3 <write>
        while(*s != 0){
 6e9:	0f b6 03             	movzbl (%ebx),%eax
 6ec:	84 c0                	test   %al,%al
 6ee:	75 e0                	jne    6d0 <printf+0x140>
 6f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 6f3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 6f7:	83 c3 02             	add    $0x2,%ebx
 6fa:	84 d2                	test   %dl,%dl
 6fc:	0f 85 ae fe ff ff    	jne    5b0 <printf+0x20>
 702:	e9 d5 fe ff ff       	jmp    5dc <printf+0x4c>
 707:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 70e:	00 
 70f:	90                   	nop
        printint(fd, *ap, 10, 1);
 710:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 713:	b9 0a 00 00 00       	mov    $0xa,%ecx
 718:	8b 17                	mov    (%edi),%edx
 71a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 721:	e9 53 ff ff ff       	jmp    679 <printf+0xe9>
 726:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 72d:	00 
 72e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 730:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 733:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 738:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 73b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 73d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 741:	8d 7d e7             	lea    -0x19(%ebp),%edi
 744:	89 7c 24 04          	mov    %edi,0x4(%esp)
 748:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 74b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 74e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 752:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 755:	e8 99 fc ff ff       	call   3f3 <write>
        ap++;
 75a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 75e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 762:	84 d2                	test   %dl,%dl
 764:	0f 85 46 fe ff ff    	jne    5b0 <printf+0x20>
 76a:	e9 6d fe ff ff       	jmp    5dc <printf+0x4c>
 76f:	90                   	nop
        putc(fd, c);
 770:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 773:	8d 7d e7             	lea    -0x19(%ebp),%edi
 776:	b9 01 00 00 00       	mov    $0x1,%ecx
 77b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 77f:	e9 bb fe ff ff       	jmp    63f <printf+0xaf>
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 788:	bf 4d 09 00 00       	mov    $0x94d,%edi
 78d:	b0 28                	mov    $0x28,%al
 78f:	e9 2a ff ff ff       	jmp    6be <printf+0x12e>
 794:	66 90                	xchg   %ax,%ax
 796:	66 90                	xchg   %ax,%ax
 798:	66 90                	xchg   %ax,%ax
 79a:	66 90                	xchg   %ax,%ax
 79c:	66 90                	xchg   %ax,%ax
 79e:	66 90                	xchg   %ax,%ax

000007a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a1:	a1 c0 09 00 00       	mov    0x9c0,%eax
{
 7a6:	89 e5                	mov    %esp,%ebp
 7a8:	57                   	push   %edi
 7a9:	56                   	push   %esi
 7aa:	53                   	push   %ebx
 7ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 7ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7b8:	00 
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7c0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c4:	39 ca                	cmp    %ecx,%edx
 7c6:	73 30                	jae    7f8 <free+0x58>
 7c8:	39 c1                	cmp    %eax,%ecx
 7ca:	72 04                	jb     7d0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7cc:	39 c2                	cmp    %eax,%edx
 7ce:	72 f0                	jb     7c0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7d6:	39 f8                	cmp    %edi,%eax
 7d8:	74 36                	je     810 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7dd:	8b 42 04             	mov    0x4(%edx),%eax
 7e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7e3:	39 f1                	cmp    %esi,%ecx
 7e5:	74 42                	je     829 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7e7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7e9:	5b                   	pop    %ebx
  freep = p;
 7ea:	89 15 c0 09 00 00    	mov    %edx,0x9c0
}
 7f0:	5e                   	pop    %esi
 7f1:	5f                   	pop    %edi
 7f2:	5d                   	pop    %ebp
 7f3:	c3                   	ret
 7f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f8:	39 c2                	cmp    %eax,%edx
 7fa:	72 c4                	jb     7c0 <free+0x20>
 7fc:	39 c1                	cmp    %eax,%ecx
 7fe:	73 c0                	jae    7c0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 800:	8b 73 fc             	mov    -0x4(%ebx),%esi
 803:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 806:	39 f8                	cmp    %edi,%eax
 808:	75 d0                	jne    7da <free+0x3a>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 810:	8b 78 04             	mov    0x4(%eax),%edi
 813:	01 fe                	add    %edi,%esi
 815:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 818:	8b 02                	mov    (%edx),%eax
 81a:	8b 00                	mov    (%eax),%eax
 81c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 81f:	8b 42 04             	mov    0x4(%edx),%eax
 822:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 825:	39 f1                	cmp    %esi,%ecx
 827:	75 be                	jne    7e7 <free+0x47>
  freep = p;
 829:	89 15 c0 09 00 00    	mov    %edx,0x9c0
    p->s.size += bp->s.size;
 82f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 832:	01 c8                	add    %ecx,%eax
 834:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 837:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 83a:	89 0a                	mov    %ecx,(%edx)
}
 83c:	5b                   	pop    %ebx
 83d:	5e                   	pop    %esi
 83e:	5f                   	pop    %edi
 83f:	5d                   	pop    %ebp
 840:	c3                   	ret
 841:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 848:	00 
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000850 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	57                   	push   %edi
 854:	56                   	push   %esi
 855:	53                   	push   %ebx
 856:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 859:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 85c:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 862:	8d 78 07             	lea    0x7(%eax),%edi
 865:	c1 ef 03             	shr    $0x3,%edi
 868:	47                   	inc    %edi
  if((prevp = freep) == 0){
 869:	85 d2                	test   %edx,%edx
 86b:	0f 84 8f 00 00 00    	je     900 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 871:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 873:	8b 48 04             	mov    0x4(%eax),%ecx
 876:	39 f9                	cmp    %edi,%ecx
 878:	73 5e                	jae    8d8 <malloc+0x88>
  if(nu < 4096)
 87a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 87f:	39 df                	cmp    %ebx,%edi
 881:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 884:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 88b:	eb 0c                	jmp    899 <malloc+0x49>
 88d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 890:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 892:	8b 48 04             	mov    0x4(%eax),%ecx
 895:	39 f9                	cmp    %edi,%ecx
 897:	73 3f                	jae    8d8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 899:	39 05 c0 09 00 00    	cmp    %eax,0x9c0
 89f:	89 c2                	mov    %eax,%edx
 8a1:	75 ed                	jne    890 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 8a3:	89 34 24             	mov    %esi,(%esp)
 8a6:	e8 b0 fb ff ff       	call   45b <sbrk>
  if(p == (char*)-1)
 8ab:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ae:	74 18                	je     8c8 <malloc+0x78>
  hp->s.size = nu;
 8b0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 8b3:	83 c0 08             	add    $0x8,%eax
 8b6:	89 04 24             	mov    %eax,(%esp)
 8b9:	e8 e2 fe ff ff       	call   7a0 <free>
  return freep;
 8be:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
      if((p = morecore(nunits)) == 0)
 8c4:	85 d2                	test   %edx,%edx
 8c6:	75 c8                	jne    890 <malloc+0x40>
        return 0;
  }
}
 8c8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 8cb:	31 c0                	xor    %eax,%eax
}
 8cd:	5b                   	pop    %ebx
 8ce:	5e                   	pop    %esi
 8cf:	5f                   	pop    %edi
 8d0:	5d                   	pop    %ebp
 8d1:	c3                   	ret
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8d8:	39 cf                	cmp    %ecx,%edi
 8da:	74 54                	je     930 <malloc+0xe0>
        p->s.size -= nunits;
 8dc:	29 f9                	sub    %edi,%ecx
 8de:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8e1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8e4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8e7:	89 15 c0 09 00 00    	mov    %edx,0x9c0
}
 8ed:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 8f0:	83 c0 08             	add    $0x8,%eax
}
 8f3:	5b                   	pop    %ebx
 8f4:	5e                   	pop    %esi
 8f5:	5f                   	pop    %edi
 8f6:	5d                   	pop    %ebp
 8f7:	c3                   	ret
 8f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8ff:	00 
    base.s.ptr = freep = prevp = &base;
 900:	b8 c4 09 00 00       	mov    $0x9c4,%eax
 905:	ba c4 09 00 00       	mov    $0x9c4,%edx
 90a:	a3 c0 09 00 00       	mov    %eax,0x9c0
    base.s.size = 0;
 90f:	31 c9                	xor    %ecx,%ecx
 911:	b8 c4 09 00 00       	mov    $0x9c4,%eax
    base.s.ptr = freep = prevp = &base;
 916:	89 15 c4 09 00 00    	mov    %edx,0x9c4
    base.s.size = 0;
 91c:	89 0d c8 09 00 00    	mov    %ecx,0x9c8
    if(p->s.size >= nunits){
 922:	e9 53 ff ff ff       	jmp    87a <malloc+0x2a>
 927:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 92e:	00 
 92f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 930:	8b 08                	mov    (%eax),%ecx
 932:	89 0a                	mov    %ecx,(%edx)
 934:	eb b1                	jmp    8e7 <malloc+0x97>
