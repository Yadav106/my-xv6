
_status:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"

#define MAX_SZ 1000

int main(int argc, const char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 28             	sub    $0x28,%esp
  14:	8b 49 04             	mov    0x4(%ecx),%ecx
    int n;
    n = atoi(argv[1]);
  17:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  1a:	8b 41 04             	mov    0x4(%ecx),%eax
  1d:	89 04 24             	mov    %eax,(%esp)
  20:	e8 fb 02 00 00       	call   320 <atoi>
  25:	89 45 dc             	mov    %eax,-0x24(%ebp)
  28:	89 c1                	mov    %eax,%ecx
    int procType[n];
  2a:	8d 04 85 0f 00 00 00 	lea    0xf(,%eax,4),%eax
  31:	c1 e8 04             	shr    $0x4,%eax
  34:	c1 e0 04             	shl    $0x4,%eax
  37:	29 c4                	sub    %eax,%esp
  39:	8d 54 24 04          	lea    0x4(%esp),%edx
    int pids[n];
  3d:	29 c4                	sub    %eax,%esp
    int procType[n];
  3f:	89 55 e0             	mov    %edx,-0x20(%ebp)
    int i;
    // Set the Process types
    for (i = 0; i < n; i++)
  42:	85 c9                	test   %ecx,%ecx
  44:	0f 8e f8 00 00 00    	jle    142 <main+0x142>
  4a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  4d:	8d 74 24 04          	lea    0x4(%esp),%esi
  51:	31 ff                	xor    %edi,%edi
  53:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  5a:	00 
  5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    {
        procType[i] = atoi(argv[i + 2]);
  60:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  63:	8b 44 b9 08          	mov    0x8(%ecx,%edi,4),%eax
  67:	89 fb                	mov    %edi,%ebx
  69:	89 04 24             	mov    %eax,(%esp)
  6c:	e8 af 02 00 00       	call   320 <atoi>
  71:	8b 55 e0             	mov    -0x20(%ebp),%edx
    for (i = 0; i < n; i++)
  74:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
        procType[i] = atoi(argv[i + 2]);
  77:	89 04 ba             	mov    %eax,(%edx,%edi,4)
    for (i = 0; i < n; i++)
  7a:	8d 7f 01             	lea    0x1(%edi),%edi
  7d:	39 7d dc             	cmp    %edi,-0x24(%ebp)
  80:	75 de                	jne    60 <main+0x60>
    }
    // Execute the children programmes
    for (i = 0; i < n; i++)
  82:	31 ff                	xor    %edi,%edi
  84:	eb 18                	jmp    9e <main+0x9e>
  86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  8d:	00 
  8e:	66 90                	xchg   %ax,%ax
                }
            }
            exit();
        }

        else if (ret > 0)
  90:	7e 03                	jle    95 <main+0x95>
            pids[i] = ret;
  92:	89 04 be             	mov    %eax,(%esi,%edi,4)
    for (i = 0; i < n; i++)
  95:	8d 47 01             	lea    0x1(%edi),%eax
  98:	39 fb                	cmp    %edi,%ebx
  9a:	74 1a                	je     b6 <main+0xb6>
  9c:	89 c7                	mov    %eax,%edi
        ret = fork();
  9e:	e8 e8 02 00 00       	call   38b <fork>
        if (ret == 0)
  a3:	85 c0                	test   %eax,%eax
  a5:	75 e9                	jne    90 <main+0x90>
            if (procType[i] == 0)
  a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  aa:	8b 04 b8             	mov    (%eax,%edi,4),%eax
  ad:	85 c0                	test   %eax,%eax
  af:	74 70                	je     121 <main+0x121>
            else if (procType[i] == 1)
  b1:	48                   	dec    %eax
  b2:	75 68                	jne    11c <main+0x11c>
                while (1)
  b4:	eb fe                	jmp    b4 <main+0xb4>
    }

    sleep(50);
  b6:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
    for (i = 0; i < n; i++)
  bd:	31 ff                	xor    %edi,%edi
    sleep(50);
  bf:	e8 5f 03 00 00       	call   423 <sleep>
    for (i = 0; i < n; i++)
  c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  cb:	00 
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {
        whatsthestatus(pids[i]);
  d0:	8b 04 be             	mov    (%esi,%edi,4),%eax
  d3:	89 04 24             	mov    %eax,(%esp)
  d6:	e8 68 03 00 00       	call   443 <whatsthestatus>
    for (i = 0; i < n; i++)
  db:	89 f8                	mov    %edi,%eax
  dd:	47                   	inc    %edi
  de:	39 c3                	cmp    %eax,%ebx
  e0:	75 ee                	jne    d0 <main+0xd0>
    }

    for (i = 0; i < n; i++)
  e2:	31 ff                	xor    %edi,%edi
  e4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  eb:	00 
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {
        kill(pids[i]);
  f0:	8b 04 be             	mov    (%esi,%edi,4),%eax
  f3:	89 04 24             	mov    %eax,(%esp)
  f6:	e8 c8 02 00 00       	call   3c3 <kill>
    for (i = 0; i < n; i++)
  fb:	89 f8                	mov    %edi,%eax
  fd:	47                   	inc    %edi
  fe:	39 c3                	cmp    %eax,%ebx
 100:	75 ee                	jne    f0 <main+0xf0>
    }

    for (i = 0; i < n; i++)
 102:	31 f6                	xor    %esi,%esi
 104:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10b:	00 
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        wait();
 110:	e8 86 02 00 00       	call   39b <wait>
    for (i = 0; i < n; i++)
 115:	89 f0                	mov    %esi,%eax
 117:	46                   	inc    %esi
 118:	39 c3                	cmp    %eax,%ebx
 11a:	75 f4                	jne    110 <main+0x110>
                exit();
 11c:	e8 72 02 00 00       	call   393 <exit>
                int id=fork();
 121:	e8 65 02 00 00       	call   38b <fork>
                if(id==0)
 126:	85 c0                	test   %eax,%eax
 128:	75 0e                	jne    138 <main+0x138>
                    sleep(100);
 12a:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
 131:	e8 ed 02 00 00       	call   423 <sleep>
 136:	eb e4                	jmp    11c <main+0x11c>
                    wait();
 138:	e8 5e 02 00 00       	call   39b <wait>
 13d:	8d 76 00             	lea    0x0(%esi),%esi
 140:	eb da                	jmp    11c <main+0x11c>
    sleep(50);
 142:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
 149:	e8 d5 02 00 00       	call   423 <sleep>
    for (i = 0; i < n; i++)
 14e:	eb cc                	jmp    11c <main+0x11c>

00000150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 150:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 151:	31 c0                	xor    %eax,%eax
{
 153:	89 e5                	mov    %esp,%ebp
 155:	53                   	push   %ebx
 156:	8b 4d 08             	mov    0x8(%ebp),%ecx
 159:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 160:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 164:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 167:	40                   	inc    %eax
 168:	84 d2                	test   %dl,%dl
 16a:	75 f4                	jne    160 <strcpy+0x10>
    ;
  return os;
}
 16c:	5b                   	pop    %ebx
 16d:	89 c8                	mov    %ecx,%eax
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret
 171:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 178:	00 
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 55 08             	mov    0x8(%ebp),%edx
 187:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 18a:	0f b6 02             	movzbl (%edx),%eax
 18d:	84 c0                	test   %al,%al
 18f:	75 15                	jne    1a6 <strcmp+0x26>
 191:	eb 30                	jmp    1c3 <strcmp+0x43>
 193:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 198:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 19c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 19f:	42                   	inc    %edx
  while(*p && *p == *q)
 1a0:	84 c0                	test   %al,%al
 1a2:	74 14                	je     1b8 <strcmp+0x38>
 1a4:	89 cb                	mov    %ecx,%ebx
 1a6:	0f b6 0b             	movzbl (%ebx),%ecx
 1a9:	38 c1                	cmp    %al,%cl
 1ab:	74 eb                	je     198 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 1ad:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 1ae:	29 c8                	sub    %ecx,%eax
}
 1b0:	5d                   	pop    %ebp
 1b1:	c3                   	ret
 1b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 1b8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 1bc:	31 c0                	xor    %eax,%eax
}
 1be:	5b                   	pop    %ebx
 1bf:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 1c0:	29 c8                	sub    %ecx,%eax
}
 1c2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1c3:	0f b6 0b             	movzbl (%ebx),%ecx
 1c6:	31 c0                	xor    %eax,%eax
 1c8:	eb e3                	jmp    1ad <strcmp+0x2d>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001d0 <strlen>:

uint
strlen(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1d6:	80 3a 00             	cmpb   $0x0,(%edx)
 1d9:	74 15                	je     1f0 <strlen+0x20>
 1db:	31 c0                	xor    %eax,%eax
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	40                   	inc    %eax
 1e1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1e5:	89 c1                	mov    %eax,%ecx
 1e7:	75 f7                	jne    1e0 <strlen+0x10>
    ;
  return n;
}
 1e9:	5d                   	pop    %ebp
 1ea:	89 c8                	mov    %ecx,%eax
 1ec:	c3                   	ret
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 1f1:	31 c9                	xor    %ecx,%ecx
}
 1f3:	89 c8                	mov    %ecx,%eax
 1f5:	c3                   	ret
 1f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1fd:	00 
 1fe:	66 90                	xchg   %ax,%ax

00000200 <memset>:

void*
memset(void *dst, int c, uint n)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 55 08             	mov    0x8(%ebp),%edx
 206:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 207:	8b 4d 10             	mov    0x10(%ebp),%ecx
 20a:	8b 45 0c             	mov    0xc(%ebp),%eax
 20d:	89 d7                	mov    %edx,%edi
 20f:	fc                   	cld
 210:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 212:	5f                   	pop    %edi
 213:	89 d0                	mov    %edx,%eax
 215:	5d                   	pop    %ebp
 216:	c3                   	ret
 217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21e:	00 
 21f:	90                   	nop

00000220 <strchr>:

char*
strchr(const char *s, char c)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 22a:	0f b6 10             	movzbl (%eax),%edx
 22d:	84 d2                	test   %dl,%dl
 22f:	75 10                	jne    241 <strchr+0x21>
 231:	eb 1d                	jmp    250 <strchr+0x30>
 233:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 238:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 23c:	40                   	inc    %eax
 23d:	84 d2                	test   %dl,%dl
 23f:	74 0f                	je     250 <strchr+0x30>
    if(*s == c)
 241:	38 d1                	cmp    %dl,%cl
 243:	75 f3                	jne    238 <strchr+0x18>
      return (char*)s;
  return 0;
}
 245:	5d                   	pop    %ebp
 246:	c3                   	ret
 247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24e:	00 
 24f:	90                   	nop
 250:	5d                   	pop    %ebp
  return 0;
 251:	31 c0                	xor    %eax,%eax
}
 253:	c3                   	ret
 254:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25b:	00 
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000260 <gets>:

char*
gets(char *buf, int max)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 265:	31 f6                	xor    %esi,%esi
{
 267:	53                   	push   %ebx
    cc = read(0, &c, 1);
 268:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 26b:	83 ec 3c             	sub    $0x3c,%esp
 26e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 271:	eb 32                	jmp    2a5 <gets+0x45>
 273:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 278:	89 7c 24 04          	mov    %edi,0x4(%esp)
 27c:	b8 01 00 00 00       	mov    $0x1,%eax
 281:	89 44 24 08          	mov    %eax,0x8(%esp)
 285:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 28c:	e8 1a 01 00 00       	call   3ab <read>
    if(cc < 1)
 291:	85 c0                	test   %eax,%eax
 293:	7e 19                	jle    2ae <gets+0x4e>
      break;
    buf[i++] = c;
 295:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 299:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 29d:	3c 0a                	cmp    $0xa,%al
 29f:	74 10                	je     2b1 <gets+0x51>
 2a1:	3c 0d                	cmp    $0xd,%al
 2a3:	74 0c                	je     2b1 <gets+0x51>
  for(i=0; i+1 < max; ){
 2a5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2a8:	46                   	inc    %esi
 2a9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2ac:	7c ca                	jl     278 <gets+0x18>
 2ae:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 2b1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 2b5:	83 c4 3c             	add    $0x3c,%esp
 2b8:	89 d8                	mov    %ebx,%eax
 2ba:	5b                   	pop    %ebx
 2bb:	5e                   	pop    %esi
 2bc:	5f                   	pop    %edi
 2bd:	5d                   	pop    %ebp
 2be:	c3                   	ret
 2bf:	90                   	nop

000002c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2c0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c1:	31 c0                	xor    %eax,%eax
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	83 ec 18             	sub    $0x18,%esp
 2c8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2cb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2ce:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d2:	8b 45 08             	mov    0x8(%ebp),%eax
 2d5:	89 04 24             	mov    %eax,(%esp)
 2d8:	e8 f6 00 00 00       	call   3d3 <open>
  if(fd < 0)
 2dd:	85 c0                	test   %eax,%eax
 2df:	78 2f                	js     310 <stat+0x50>
 2e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e6:	89 1c 24             	mov    %ebx,(%esp)
 2e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ed:	e8 f9 00 00 00       	call   3eb <fstat>
  close(fd);
 2f2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2f5:	89 c6                	mov    %eax,%esi
  close(fd);
 2f7:	e8 bf 00 00 00       	call   3bb <close>
  return r;
}
 2fc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2ff:	89 f0                	mov    %esi,%eax
 301:	8b 75 fc             	mov    -0x4(%ebp),%esi
 304:	89 ec                	mov    %ebp,%esp
 306:	5d                   	pop    %ebp
 307:	c3                   	ret
 308:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 30f:	00 
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb e5                	jmp    2fc <stat+0x3c>
 317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31e:	00 
 31f:	90                   	nop

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 02             	movsbl (%edx),%eax
 32a:	88 c1                	mov    %al,%cl
 32c:	80 e9 30             	sub    $0x30,%cl
 32f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 332:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 337:	77 1c                	ja     355 <atoi+0x35>
 339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 340:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 343:	42                   	inc    %edx
 344:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 348:	0f be 02             	movsbl (%edx),%eax
 34b:	88 c3                	mov    %al,%bl
 34d:	80 eb 30             	sub    $0x30,%bl
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	5b                   	pop    %ebx
 356:	89 c8                	mov    %ecx,%eax
 358:	5d                   	pop    %ebp
 359:	c3                   	ret
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	8b 45 10             	mov    0x10(%ebp),%eax
 367:	56                   	push   %esi
 368:	8b 55 08             	mov    0x8(%ebp),%edx
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 c0                	test   %eax,%eax
 370:	7e 13                	jle    385 <memmove+0x25>
 372:	01 d0                	add    %edx,%eax
  dst = vdst;
 374:	89 d7                	mov    %edx,%edi
 376:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37d:	00 
 37e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 380:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 381:	39 f8                	cmp    %edi,%eax
 383:	75 fb                	jne    380 <memmove+0x20>
  return vdst;
}
 385:	5e                   	pop    %esi
 386:	89 d0                	mov    %edx,%eax
 388:	5f                   	pop    %edi
 389:	5d                   	pop    %ebp
 38a:	c3                   	ret

0000038b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38b:	b8 01 00 00 00       	mov    $0x1,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <exit>:
SYSCALL(exit)
 393:	b8 02 00 00 00       	mov    $0x2,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <wait>:
SYSCALL(wait)
 39b:	b8 03 00 00 00       	mov    $0x3,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <pipe>:
SYSCALL(pipe)
 3a3:	b8 04 00 00 00       	mov    $0x4,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <read>:
SYSCALL(read)
 3ab:	b8 05 00 00 00       	mov    $0x5,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <write>:
SYSCALL(write)
 3b3:	b8 10 00 00 00       	mov    $0x10,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <close>:
SYSCALL(close)
 3bb:	b8 15 00 00 00       	mov    $0x15,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <kill>:
SYSCALL(kill)
 3c3:	b8 06 00 00 00       	mov    $0x6,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <exec>:
SYSCALL(exec)
 3cb:	b8 07 00 00 00       	mov    $0x7,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <open>:
SYSCALL(open)
 3d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <mknod>:
SYSCALL(mknod)
 3db:	b8 11 00 00 00       	mov    $0x11,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <unlink>:
SYSCALL(unlink)
 3e3:	b8 12 00 00 00       	mov    $0x12,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <fstat>:
SYSCALL(fstat)
 3eb:	b8 08 00 00 00       	mov    $0x8,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <link>:
SYSCALL(link)
 3f3:	b8 13 00 00 00       	mov    $0x13,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <mkdir>:
SYSCALL(mkdir)
 3fb:	b8 14 00 00 00       	mov    $0x14,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <chdir>:
SYSCALL(chdir)
 403:	b8 09 00 00 00       	mov    $0x9,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <dup>:
SYSCALL(dup)
 40b:	b8 0a 00 00 00       	mov    $0xa,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <getpid>:
SYSCALL(getpid)
 413:	b8 0b 00 00 00       	mov    $0xb,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <sbrk>:
SYSCALL(sbrk)
 41b:	b8 0c 00 00 00       	mov    $0xc,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <sleep>:
SYSCALL(sleep)
 423:	b8 0d 00 00 00       	mov    $0xd,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <uptime>:
SYSCALL(uptime)
 42b:	b8 0e 00 00 00       	mov    $0xe,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <worldpeace>:
SYSCALL(worldpeace)
 433:	b8 16 00 00 00       	mov    $0x16,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <numberofprocesses>:
SYSCALL(numberofprocesses)
 43b:	b8 17 00 00 00       	mov    $0x17,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <whatsthestatus>:
SYSCALL(whatsthestatus)
 443:	b8 18 00 00 00       	mov    $0x18,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <get_sibling>:
SYSCALL(get_sibling)
 44b:	b8 19 00 00 00       	mov    $0x19,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <spawn>:
SYSCALL(spawn)
 453:	b8 1a 00 00 00       	mov    $0x1a,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <getvasize>:
SYSCALL(getvasize)
 45b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <va2pa>:
SYSCALL(va2pa)
 463:	b8 1c 00 00 00       	mov    $0x1c,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 46b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 473:	b8 1e 00 00 00       	mov    $0x1e,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 47b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <getpasize>:
SYSCALL(getpasize)
 483:	b8 20 00 00 00       	mov    $0x20,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret
 48b:	66 90                	xchg   %ax,%ax
 48d:	66 90                	xchg   %ax,%ax
 48f:	90                   	nop

00000490 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	89 cb                	mov    %ecx,%ebx
 498:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 49b:	89 d1                	mov    %edx,%ecx
{
 49d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 4a0:	89 d0                	mov    %edx,%eax
 4a2:	c1 e8 1f             	shr    $0x1f,%eax
 4a5:	84 c0                	test   %al,%al
 4a7:	0f 84 93 00 00 00    	je     540 <printint+0xb0>
 4ad:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4b1:	0f 84 89 00 00 00    	je     540 <printint+0xb0>
    x = -xx;
 4b7:	f7 d9                	neg    %ecx
    neg = 1;
 4b9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4be:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4c5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4c8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 4cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 4d0:	89 c8                	mov    %ecx,%eax
 4d2:	31 d2                	xor    %edx,%edx
 4d4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 4d7:	f7 f3                	div    %ebx
 4d9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4dc:	0f b6 92 58 09 00 00 	movzbl 0x958(%edx),%edx
 4e3:	8d 47 01             	lea    0x1(%edi),%eax
 4e6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 4e9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 4ed:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 4ef:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 4f2:	39 da                	cmp    %ebx,%edx
 4f4:	73 da                	jae    4d0 <printint+0x40>
  if(neg)
 4f6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 4f9:	85 c0                	test   %eax,%eax
 4fb:	74 0a                	je     507 <printint+0x77>
    buf[i++] = '-';
 4fd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 500:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 505:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 507:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 50a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 50e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 510:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 513:	89 74 24 04          	mov    %esi,0x4(%esp)
 517:	88 45 d7             	mov    %al,-0x29(%ebp)
 51a:	b8 01 00 00 00       	mov    $0x1,%eax
 51f:	89 44 24 08          	mov    %eax,0x8(%esp)
 523:	8b 45 bc             	mov    -0x44(%ebp),%eax
 526:	89 04 24             	mov    %eax,(%esp)
 529:	e8 85 fe ff ff       	call   3b3 <write>
  while(--i >= 0)
 52e:	89 f8                	mov    %edi,%eax
 530:	4f                   	dec    %edi
 531:	39 d8                	cmp    %ebx,%eax
 533:	75 db                	jne    510 <printint+0x80>
}
 535:	83 c4 4c             	add    $0x4c,%esp
 538:	5b                   	pop    %ebx
 539:	5e                   	pop    %esi
 53a:	5f                   	pop    %edi
 53b:	5d                   	pop    %ebp
 53c:	c3                   	ret
 53d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 540:	31 c0                	xor    %eax,%eax
 542:	e9 77 ff ff ff       	jmp    4be <printint+0x2e>
 547:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 54e:	00 
 54f:	90                   	nop

00000550 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	56                   	push   %esi
 555:	53                   	push   %ebx
 556:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 559:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 55c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 55f:	0f b6 13             	movzbl (%ebx),%edx
 562:	43                   	inc    %ebx
 563:	84 d2                	test   %dl,%dl
 565:	74 35                	je     59c <printf+0x4c>
 567:	8d 45 10             	lea    0x10(%ebp),%eax
 56a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 56d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 570:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 573:	83 f8 25             	cmp    $0x25,%eax
 576:	74 30                	je     5a8 <printf+0x58>
  write(fd, &c, 1);
 578:	89 34 24             	mov    %esi,(%esp)
 57b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 580:	43                   	inc    %ebx
  write(fd, &c, 1);
 581:	89 44 24 08          	mov    %eax,0x8(%esp)
 585:	8d 45 e7             	lea    -0x19(%ebp),%eax
 588:	89 44 24 04          	mov    %eax,0x4(%esp)
 58c:	88 55 e7             	mov    %dl,-0x19(%ebp)
 58f:	e8 1f fe ff ff       	call   3b3 <write>
  for(i = 0; fmt[i]; i++){
 594:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 598:	84 d2                	test   %dl,%dl
 59a:	75 d4                	jne    570 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 59c:	83 c4 3c             	add    $0x3c,%esp
 59f:	5b                   	pop    %ebx
 5a0:	5e                   	pop    %esi
 5a1:	5f                   	pop    %edi
 5a2:	5d                   	pop    %ebp
 5a3:	c3                   	ret
 5a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 5a8:	0f b6 13             	movzbl (%ebx),%edx
 5ab:	84 d2                	test   %dl,%dl
 5ad:	74 ed                	je     59c <printf+0x4c>
    c = fmt[i] & 0xff;
 5af:	80 fa 25             	cmp    $0x25,%dl
 5b2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 5b5:	0f 84 75 01 00 00    	je     730 <printf+0x1e0>
 5bb:	83 e8 63             	sub    $0x63,%eax
 5be:	83 f8 15             	cmp    $0x15,%eax
 5c1:	77 0d                	ja     5d0 <printf+0x80>
 5c3:	ff 24 85 00 09 00 00 	jmp    *0x900(,%eax,4)
 5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5d0:	89 34 24             	mov    %esi,(%esp)
 5d3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5d6:	b8 01 00 00 00       	mov    $0x1,%eax
 5db:	89 44 24 08          	mov    %eax,0x8(%esp)
 5df:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5e3:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 5e6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 5ea:	e8 c4 fd ff ff       	call   3b3 <write>
        putc(fd, c);
 5ef:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 5f3:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5f6:	ba 01 00 00 00       	mov    $0x1,%edx
 5fb:	89 54 24 08          	mov    %edx,0x8(%esp)
 5ff:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 603:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 606:	89 34 24             	mov    %esi,(%esp)
 609:	e8 a5 fd ff ff       	call   3b3 <write>
  for(i = 0; fmt[i]; i++){
 60e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 612:	84 d2                	test   %dl,%dl
 614:	0f 85 56 ff ff ff    	jne    570 <printf+0x20>
}
 61a:	83 c4 3c             	add    $0x3c,%esp
 61d:	5b                   	pop    %ebx
 61e:	5e                   	pop    %esi
 61f:	5f                   	pop    %edi
 620:	5d                   	pop    %ebp
 621:	c3                   	ret
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 628:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 62b:	b9 10 00 00 00       	mov    $0x10,%ecx
 630:	8b 17                	mov    (%edi),%edx
 632:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 639:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 63c:	89 f0                	mov    %esi,%eax
 63e:	e8 4d fe ff ff       	call   490 <printint>
  for(i = 0; fmt[i]; i++){
 643:	83 c3 02             	add    $0x2,%ebx
        ap++;
 646:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 649:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 64d:	84 d2                	test   %dl,%dl
 64f:	0f 85 1b ff ff ff    	jne    570 <printf+0x20>
}
 655:	83 c4 3c             	add    $0x3c,%esp
 658:	5b                   	pop    %ebx
 659:	5e                   	pop    %esi
 65a:	5f                   	pop    %edi
 65b:	5d                   	pop    %ebp
 65c:	c3                   	ret
 65d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 660:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 663:	8b 01                	mov    (%ecx),%eax
        ap++;
 665:	83 c1 04             	add    $0x4,%ecx
 668:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 66b:	85 c0                	test   %eax,%eax
 66d:	0f 84 d5 00 00 00    	je     748 <printf+0x1f8>
        while(*s != 0){
 673:	0f b6 10             	movzbl (%eax),%edx
 676:	84 d2                	test   %dl,%dl
 678:	74 39                	je     6b3 <printf+0x163>
 67a:	89 c7                	mov    %eax,%edi
 67c:	88 d0                	mov    %dl,%al
 67e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 681:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 684:	89 fb                	mov    %edi,%ebx
 686:	89 cf                	mov    %ecx,%edi
 688:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 68f:	00 
          putc(fd, *s);
 690:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 693:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 698:	43                   	inc    %ebx
  write(fd, &c, 1);
 699:	89 44 24 08          	mov    %eax,0x8(%esp)
 69d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6a1:	89 34 24             	mov    %esi,(%esp)
 6a4:	e8 0a fd ff ff       	call   3b3 <write>
        while(*s != 0){
 6a9:	0f b6 03             	movzbl (%ebx),%eax
 6ac:	84 c0                	test   %al,%al
 6ae:	75 e0                	jne    690 <printf+0x140>
 6b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 6b3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 6b7:	83 c3 02             	add    $0x2,%ebx
 6ba:	84 d2                	test   %dl,%dl
 6bc:	0f 85 ae fe ff ff    	jne    570 <printf+0x20>
 6c2:	e9 d5 fe ff ff       	jmp    59c <printf+0x4c>
 6c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6ce:	00 
 6cf:	90                   	nop
        printint(fd, *ap, 10, 1);
 6d0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6d8:	8b 17                	mov    (%edi),%edx
 6da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6e1:	e9 53 ff ff ff       	jmp    639 <printf+0xe9>
 6e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6ed:	00 
 6ee:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 6f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 6f3:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 6f8:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 6fb:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 6fd:	89 7c 24 08          	mov    %edi,0x8(%esp)
 701:	8d 7d e7             	lea    -0x19(%ebp),%edi
 704:	89 7c 24 04          	mov    %edi,0x4(%esp)
 708:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 70b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 70e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 712:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 715:	e8 99 fc ff ff       	call   3b3 <write>
        ap++;
 71a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 71e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 722:	84 d2                	test   %dl,%dl
 724:	0f 85 46 fe ff ff    	jne    570 <printf+0x20>
 72a:	e9 6d fe ff ff       	jmp    59c <printf+0x4c>
 72f:	90                   	nop
        putc(fd, c);
 730:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 733:	8d 7d e7             	lea    -0x19(%ebp),%edi
 736:	b9 01 00 00 00       	mov    $0x1,%ecx
 73b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 73f:	e9 bb fe ff ff       	jmp    5ff <printf+0xaf>
 744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 748:	bf f8 08 00 00       	mov    $0x8f8,%edi
 74d:	b0 28                	mov    $0x28,%al
 74f:	e9 2a ff ff ff       	jmp    67e <printf+0x12e>
 754:	66 90                	xchg   %ax,%ax
 756:	66 90                	xchg   %ax,%ax
 758:	66 90                	xchg   %ax,%ax
 75a:	66 90                	xchg   %ax,%ax
 75c:	66 90                	xchg   %ax,%ax
 75e:	66 90                	xchg   %ax,%ax

00000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 761:	a1 6c 09 00 00       	mov    0x96c,%eax
{
 766:	89 e5                	mov    %esp,%ebp
 768:	57                   	push   %edi
 769:	56                   	push   %esi
 76a:	53                   	push   %ebx
 76b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 76e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 778:	00 
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 780:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 782:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	39 ca                	cmp    %ecx,%edx
 786:	73 30                	jae    7b8 <free+0x58>
 788:	39 c1                	cmp    %eax,%ecx
 78a:	72 04                	jb     790 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78c:	39 c2                	cmp    %eax,%edx
 78e:	72 f0                	jb     780 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 790:	8b 73 fc             	mov    -0x4(%ebx),%esi
 793:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 796:	39 f8                	cmp    %edi,%eax
 798:	74 36                	je     7d0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 79a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 79d:	8b 42 04             	mov    0x4(%edx),%eax
 7a0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	74 42                	je     7e9 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7a7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7a9:	5b                   	pop    %ebx
  freep = p;
 7aa:	89 15 6c 09 00 00    	mov    %edx,0x96c
}
 7b0:	5e                   	pop    %esi
 7b1:	5f                   	pop    %edi
 7b2:	5d                   	pop    %ebp
 7b3:	c3                   	ret
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b8:	39 c2                	cmp    %eax,%edx
 7ba:	72 c4                	jb     780 <free+0x20>
 7bc:	39 c1                	cmp    %eax,%ecx
 7be:	73 c0                	jae    780 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 7c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7c6:	39 f8                	cmp    %edi,%eax
 7c8:	75 d0                	jne    79a <free+0x3a>
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 7d0:	8b 78 04             	mov    0x4(%eax),%edi
 7d3:	01 fe                	add    %edi,%esi
 7d5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d8:	8b 02                	mov    (%edx),%eax
 7da:	8b 00                	mov    (%eax),%eax
 7dc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7df:	8b 42 04             	mov    0x4(%edx),%eax
 7e2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7e5:	39 f1                	cmp    %esi,%ecx
 7e7:	75 be                	jne    7a7 <free+0x47>
  freep = p;
 7e9:	89 15 6c 09 00 00    	mov    %edx,0x96c
    p->s.size += bp->s.size;
 7ef:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 7f2:	01 c8                	add    %ecx,%eax
 7f4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7f7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7fa:	89 0a                	mov    %ecx,(%edx)
}
 7fc:	5b                   	pop    %ebx
 7fd:	5e                   	pop    %esi
 7fe:	5f                   	pop    %edi
 7ff:	5d                   	pop    %ebp
 800:	c3                   	ret
 801:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 808:	00 
 809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000810 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 819:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 81c:	8b 15 6c 09 00 00    	mov    0x96c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 822:	8d 78 07             	lea    0x7(%eax),%edi
 825:	c1 ef 03             	shr    $0x3,%edi
 828:	47                   	inc    %edi
  if((prevp = freep) == 0){
 829:	85 d2                	test   %edx,%edx
 82b:	0f 84 8f 00 00 00    	je     8c0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 831:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 833:	8b 48 04             	mov    0x4(%eax),%ecx
 836:	39 f9                	cmp    %edi,%ecx
 838:	73 5e                	jae    898 <malloc+0x88>
  if(nu < 4096)
 83a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 83f:	39 df                	cmp    %ebx,%edi
 841:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 844:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 84b:	eb 0c                	jmp    859 <malloc+0x49>
 84d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 850:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 852:	8b 48 04             	mov    0x4(%eax),%ecx
 855:	39 f9                	cmp    %edi,%ecx
 857:	73 3f                	jae    898 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 859:	39 05 6c 09 00 00    	cmp    %eax,0x96c
 85f:	89 c2                	mov    %eax,%edx
 861:	75 ed                	jne    850 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 863:	89 34 24             	mov    %esi,(%esp)
 866:	e8 b0 fb ff ff       	call   41b <sbrk>
  if(p == (char*)-1)
 86b:	83 f8 ff             	cmp    $0xffffffff,%eax
 86e:	74 18                	je     888 <malloc+0x78>
  hp->s.size = nu;
 870:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 873:	83 c0 08             	add    $0x8,%eax
 876:	89 04 24             	mov    %eax,(%esp)
 879:	e8 e2 fe ff ff       	call   760 <free>
  return freep;
 87e:	8b 15 6c 09 00 00    	mov    0x96c,%edx
      if((p = morecore(nunits)) == 0)
 884:	85 d2                	test   %edx,%edx
 886:	75 c8                	jne    850 <malloc+0x40>
        return 0;
  }
}
 888:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 88b:	31 c0                	xor    %eax,%eax
}
 88d:	5b                   	pop    %ebx
 88e:	5e                   	pop    %esi
 88f:	5f                   	pop    %edi
 890:	5d                   	pop    %ebp
 891:	c3                   	ret
 892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 898:	39 cf                	cmp    %ecx,%edi
 89a:	74 54                	je     8f0 <malloc+0xe0>
        p->s.size -= nunits;
 89c:	29 f9                	sub    %edi,%ecx
 89e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8a4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8a7:	89 15 6c 09 00 00    	mov    %edx,0x96c
}
 8ad:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 8b0:	83 c0 08             	add    $0x8,%eax
}
 8b3:	5b                   	pop    %ebx
 8b4:	5e                   	pop    %esi
 8b5:	5f                   	pop    %edi
 8b6:	5d                   	pop    %ebp
 8b7:	c3                   	ret
 8b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8bf:	00 
    base.s.ptr = freep = prevp = &base;
 8c0:	b8 70 09 00 00       	mov    $0x970,%eax
 8c5:	ba 70 09 00 00       	mov    $0x970,%edx
 8ca:	a3 6c 09 00 00       	mov    %eax,0x96c
    base.s.size = 0;
 8cf:	31 c9                	xor    %ecx,%ecx
 8d1:	b8 70 09 00 00       	mov    $0x970,%eax
    base.s.ptr = freep = prevp = &base;
 8d6:	89 15 70 09 00 00    	mov    %edx,0x970
    base.s.size = 0;
 8dc:	89 0d 74 09 00 00    	mov    %ecx,0x974
    if(p->s.size >= nunits){
 8e2:	e9 53 ff ff ff       	jmp    83a <malloc+0x2a>
 8e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8ee:	00 
 8ef:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 8f0:	8b 08                	mov    (%eax),%ecx
 8f2:	89 0a                	mov    %ecx,(%edx)
 8f4:	eb b1                	jmp    8a7 <malloc+0x97>
