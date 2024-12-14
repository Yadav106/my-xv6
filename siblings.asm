
_siblings:     file format elf32-i386


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
  14:	8b 79 04             	mov    0x4(%ecx),%edi
	int n;
	n = atoi(argv[1]);
  17:	8b 47 04             	mov    0x4(%edi),%eax
  1a:	89 04 24             	mov    %eax,(%esp)
  1d:	e8 ee 02 00 00       	call   310 <atoi>
  22:	89 45 e0             	mov    %eax,-0x20(%ebp)
  25:	89 c1                	mov    %eax,%ecx
	int procType[n];
  27:	8d 04 85 0f 00 00 00 	lea    0xf(,%eax,4),%eax
  2e:	c1 e8 04             	shr    $0x4,%eax
  31:	c1 e0 04             	shl    $0x4,%eax
  34:	29 c4                	sub    %eax,%esp
  36:	8d 54 24 04          	lea    0x4(%esp),%edx
	int pids[n];
  3a:	29 c4                	sub    %eax,%esp
	int procType[n];
  3c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	int pids[n];
  3f:	8d 44 24 04          	lea    0x4(%esp),%eax
	int i;
	// Set the Process types
	for(i=0; i<n; i++)
  43:	85 c9                	test   %ecx,%ecx
	int pids[n];
  45:	89 45 dc             	mov    %eax,-0x24(%ebp)
	for(i=0; i<n; i++)
  48:	7e 4f                	jle    99 <main+0x99>
  4a:	31 db                	xor    %ebx,%ebx
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	{
		procType[i] = atoi(argv[i+2]);
  50:	8b 44 9f 08          	mov    0x8(%edi,%ebx,4),%eax
  54:	89 de                	mov    %ebx,%esi
  56:	89 04 24             	mov    %eax,(%esp)
  59:	e8 b2 02 00 00       	call   310 <atoi>
  5e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  61:	89 04 9a             	mov    %eax,(%edx,%ebx,4)
	for(i=0; i<n; i++)
  64:	8d 5b 01             	lea    0x1(%ebx),%ebx
  67:	39 5d e0             	cmp    %ebx,-0x20(%ebp)
  6a:	75 e4                	jne    50 <main+0x50>
	}
	// Execute the children programmes
	for(i=0;i<n;i++)
  6c:	31 db                	xor    %ebx,%ebx
  6e:	eb 11                	jmp    81 <main+0x81>
				while(1){}
			}
			exit();
		}

		else if(ret>0) 
  70:	7e 06                	jle    78 <main+0x78>
            pids[i] = ret;
  72:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  75:	89 04 99             	mov    %eax,(%ecx,%ebx,4)
	for(i=0;i<n;i++)
  78:	8d 43 01             	lea    0x1(%ebx),%eax
  7b:	39 de                	cmp    %ebx,%esi
  7d:	74 40                	je     bf <main+0xbf>
  7f:	89 c3                	mov    %eax,%ebx
		ret = fork();
  81:	e8 f5 02 00 00       	call   37b <fork>
		if(ret == 0)
  86:	85 c0                	test   %eax,%eax
  88:	75 e6                	jne    70 <main+0x70>
			if(procType[i] == 0)
  8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8d:	8b 04 98             	mov    (%eax,%ebx,4),%eax
  90:	85 c0                	test   %eax,%eax
  92:	74 7a                	je     10e <main+0x10e>
			else if (procType[i] == 1)
  94:	48                   	dec    %eax
  95:	75 23                	jne    ba <main+0xba>
				while(1){}
  97:	eb fe                	jmp    97 <main+0x97>
	}

	int ret;
	ret = fork();
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a0:	e8 d6 02 00 00       	call   37b <fork>
	if(ret == 0)
  a5:	85 c0                	test   %eax,%eax
  a7:	75 7e                	jne    127 <main+0x127>
	{
		sleep(100);
  a9:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  b0:	e8 5e 03 00 00       	call   413 <sleep>
		get_sibling();
  b5:	e8 81 03 00 00       	call   43b <get_sibling>
		exit();
  ba:	e8 c4 02 00 00       	call   383 <exit>
	ret = fork();
  bf:	90                   	nop
  c0:	e8 b6 02 00 00       	call   37b <fork>
	if(ret == 0)
  c5:	85 c0                	test   %eax,%eax
  c7:	74 e0                	je     a9 <main+0xa9>
	}

	// Wait for the last child
	sleep(150);
  c9:	c7 04 24 96 00 00 00 	movl   $0x96,(%esp)
	wait();

	for (i = 0; i < n; i++)
  d0:	31 db                	xor    %ebx,%ebx
	sleep(150);
  d2:	e8 3c 03 00 00       	call   413 <sleep>
	wait();
  d7:	e8 af 02 00 00       	call   38b <wait>
	for (i = 0; i < n; i++)
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	{
		kill(pids[i]);
  e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  e3:	8b 04 98             	mov    (%eax,%ebx,4),%eax
  e6:	89 04 24             	mov    %eax,(%esp)
  e9:	e8 c5 02 00 00       	call   3b3 <kill>
	for (i = 0; i < n; i++)
  ee:	89 d8                	mov    %ebx,%eax
  f0:	43                   	inc    %ebx
  f1:	39 c6                	cmp    %eax,%esi
  f3:	75 eb                	jne    e0 <main+0xe0>
	}

	for(i = 0; i< n; i++)
  f5:	31 db                	xor    %ebx,%ebx
  f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fe:	00 
  ff:	90                   	nop
		wait();
 100:	e8 86 02 00 00       	call   38b <wait>
	for(i = 0; i< n; i++)
 105:	89 d8                	mov    %ebx,%eax
 107:	43                   	inc    %ebx
 108:	39 c6                	cmp    %eax,%esi
 10a:	75 f4                	jne    100 <main+0x100>
 10c:	eb ac                	jmp    ba <main+0xba>
				int id = fork();
 10e:	66 90                	xchg   %ax,%ax
 110:	e8 66 02 00 00       	call   37b <fork>
				if(id==0){
 115:	85 c0                	test   %eax,%eax
 117:	75 1a                	jne    133 <main+0x133>
					sleep(200);
 119:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
 120:	e8 ee 02 00 00       	call   413 <sleep>
 125:	eb 93                	jmp    ba <main+0xba>
	sleep(150);
 127:	c7 04 24 96 00 00 00 	movl   $0x96,(%esp)
 12e:	e8 e0 02 00 00       	call   413 <sleep>
	wait();
 133:	e8 53 02 00 00       	call   38b <wait>
	for(i = 0; i< n; i++)
 138:	eb 80                	jmp    ba <main+0xba>
 13a:	66 90                	xchg   %ax,%ax
 13c:	66 90                	xchg   %ax,%ax
 13e:	66 90                	xchg   %ax,%ax

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 141:	31 c0                	xor    %eax,%eax
{
 143:	89 e5                	mov    %esp,%ebp
 145:	53                   	push   %ebx
 146:	8b 4d 08             	mov    0x8(%ebp),%ecx
 149:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 150:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 154:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 157:	40                   	inc    %eax
 158:	84 d2                	test   %dl,%dl
 15a:	75 f4                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 15c:	5b                   	pop    %ebx
 15d:	89 c8                	mov    %ecx,%eax
 15f:	5d                   	pop    %ebp
 160:	c3                   	ret
 161:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 168:	00 
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 55 08             	mov    0x8(%ebp),%edx
 177:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	84 c0                	test   %al,%al
 17f:	75 15                	jne    196 <strcmp+0x26>
 181:	eb 30                	jmp    1b3 <strcmp+0x43>
 183:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 188:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 18c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 18f:	42                   	inc    %edx
  while(*p && *p == *q)
 190:	84 c0                	test   %al,%al
 192:	74 14                	je     1a8 <strcmp+0x38>
 194:	89 cb                	mov    %ecx,%ebx
 196:	0f b6 0b             	movzbl (%ebx),%ecx
 199:	38 c1                	cmp    %al,%cl
 19b:	74 eb                	je     188 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 19d:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 19e:	29 c8                	sub    %ecx,%eax
}
 1a0:	5d                   	pop    %ebp
 1a1:	c3                   	ret
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 1a8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 1ac:	31 c0                	xor    %eax,%eax
}
 1ae:	5b                   	pop    %ebx
 1af:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 1b0:	29 c8                	sub    %ecx,%eax
}
 1b2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1b3:	0f b6 0b             	movzbl (%ebx),%ecx
 1b6:	31 c0                	xor    %eax,%eax
 1b8:	eb e3                	jmp    19d <strcmp+0x2d>
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1c6:	80 3a 00             	cmpb   $0x0,(%edx)
 1c9:	74 15                	je     1e0 <strlen+0x20>
 1cb:	31 c0                	xor    %eax,%eax
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	40                   	inc    %eax
 1d1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1d5:	89 c1                	mov    %eax,%ecx
 1d7:	75 f7                	jne    1d0 <strlen+0x10>
    ;
  return n;
}
 1d9:	5d                   	pop    %ebp
 1da:	89 c8                	mov    %ecx,%eax
 1dc:	c3                   	ret
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 1e1:	31 c9                	xor    %ecx,%ecx
}
 1e3:	89 c8                	mov    %ecx,%eax
 1e5:	c3                   	ret
 1e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ed:	00 
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
 1f6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	5f                   	pop    %edi
 203:	89 d0                	mov    %edx,%eax
 205:	5d                   	pop    %ebp
 206:	c3                   	ret
 207:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20e:	00 
 20f:	90                   	nop

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	75 10                	jne    231 <strchr+0x21>
 221:	eb 1d                	jmp    240 <strchr+0x30>
 223:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 228:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 22c:	40                   	inc    %eax
 22d:	84 d2                	test   %dl,%dl
 22f:	74 0f                	je     240 <strchr+0x30>
    if(*s == c)
 231:	38 d1                	cmp    %dl,%cl
 233:	75 f3                	jne    228 <strchr+0x18>
      return (char*)s;
  return 0;
}
 235:	5d                   	pop    %ebp
 236:	c3                   	ret
 237:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23e:	00 
 23f:	90                   	nop
 240:	5d                   	pop    %ebp
  return 0;
 241:	31 c0                	xor    %eax,%eax
}
 243:	c3                   	ret
 244:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24b:	00 
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 255:	31 f6                	xor    %esi,%esi
{
 257:	53                   	push   %ebx
    cc = read(0, &c, 1);
 258:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 25b:	83 ec 3c             	sub    $0x3c,%esp
 25e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 261:	eb 32                	jmp    295 <gets+0x45>
 263:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 268:	89 7c 24 04          	mov    %edi,0x4(%esp)
 26c:	b8 01 00 00 00       	mov    $0x1,%eax
 271:	89 44 24 08          	mov    %eax,0x8(%esp)
 275:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 27c:	e8 1a 01 00 00       	call   39b <read>
    if(cc < 1)
 281:	85 c0                	test   %eax,%eax
 283:	7e 19                	jle    29e <gets+0x4e>
      break;
    buf[i++] = c;
 285:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 289:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 28d:	3c 0a                	cmp    $0xa,%al
 28f:	74 10                	je     2a1 <gets+0x51>
 291:	3c 0d                	cmp    $0xd,%al
 293:	74 0c                	je     2a1 <gets+0x51>
  for(i=0; i+1 < max; ){
 295:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 298:	46                   	inc    %esi
 299:	3b 75 0c             	cmp    0xc(%ebp),%esi
 29c:	7c ca                	jl     268 <gets+0x18>
 29e:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 2a1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 2a5:	83 c4 3c             	add    $0x3c,%esp
 2a8:	89 d8                	mov    %ebx,%eax
 2aa:	5b                   	pop    %ebx
 2ab:	5e                   	pop    %esi
 2ac:	5f                   	pop    %edi
 2ad:	5d                   	pop    %ebp
 2ae:	c3                   	ret
 2af:	90                   	nop

000002b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b1:	31 c0                	xor    %eax,%eax
{
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	83 ec 18             	sub    $0x18,%esp
 2b8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2bb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2be:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
 2c5:	89 04 24             	mov    %eax,(%esp)
 2c8:	e8 f6 00 00 00       	call   3c3 <open>
  if(fd < 0)
 2cd:	85 c0                	test   %eax,%eax
 2cf:	78 2f                	js     300 <stat+0x50>
 2d1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2d3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d6:	89 1c 24             	mov    %ebx,(%esp)
 2d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2dd:	e8 f9 00 00 00       	call   3db <fstat>
  close(fd);
 2e2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2e5:	89 c6                	mov    %eax,%esi
  close(fd);
 2e7:	e8 bf 00 00 00       	call   3ab <close>
  return r;
}
 2ec:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2ef:	89 f0                	mov    %esi,%eax
 2f1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2f4:	89 ec                	mov    %ebp,%esp
 2f6:	5d                   	pop    %ebp
 2f7:	c3                   	ret
 2f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ff:	00 
    return -1;
 300:	be ff ff ff ff       	mov    $0xffffffff,%esi
 305:	eb e5                	jmp    2ec <stat+0x3c>
 307:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 30e:	00 
 30f:	90                   	nop

00000310 <atoi>:

int
atoi(const char *s)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	53                   	push   %ebx
 314:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 317:	0f be 02             	movsbl (%edx),%eax
 31a:	88 c1                	mov    %al,%cl
 31c:	80 e9 30             	sub    $0x30,%cl
 31f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 322:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 327:	77 1c                	ja     345 <atoi+0x35>
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 330:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 333:	42                   	inc    %edx
 334:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 338:	0f be 02             	movsbl (%edx),%eax
 33b:	88 c3                	mov    %al,%bl
 33d:	80 eb 30             	sub    $0x30,%bl
 340:	80 fb 09             	cmp    $0x9,%bl
 343:	76 eb                	jbe    330 <atoi+0x20>
  return n;
}
 345:	5b                   	pop    %ebx
 346:	89 c8                	mov    %ecx,%eax
 348:	5d                   	pop    %ebp
 349:	c3                   	ret
 34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000350 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	8b 45 10             	mov    0x10(%ebp),%eax
 357:	56                   	push   %esi
 358:	8b 55 08             	mov    0x8(%ebp),%edx
 35b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35e:	85 c0                	test   %eax,%eax
 360:	7e 13                	jle    375 <memmove+0x25>
 362:	01 d0                	add    %edx,%eax
  dst = vdst;
 364:	89 d7                	mov    %edx,%edi
 366:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 36d:	00 
 36e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 370:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 371:	39 f8                	cmp    %edi,%eax
 373:	75 fb                	jne    370 <memmove+0x20>
  return vdst;
}
 375:	5e                   	pop    %esi
 376:	89 d0                	mov    %edx,%eax
 378:	5f                   	pop    %edi
 379:	5d                   	pop    %ebp
 37a:	c3                   	ret

0000037b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 37b:	b8 01 00 00 00       	mov    $0x1,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <exit>:
SYSCALL(exit)
 383:	b8 02 00 00 00       	mov    $0x2,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <wait>:
SYSCALL(wait)
 38b:	b8 03 00 00 00       	mov    $0x3,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <pipe>:
SYSCALL(pipe)
 393:	b8 04 00 00 00       	mov    $0x4,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <read>:
SYSCALL(read)
 39b:	b8 05 00 00 00       	mov    $0x5,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <write>:
SYSCALL(write)
 3a3:	b8 10 00 00 00       	mov    $0x10,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <close>:
SYSCALL(close)
 3ab:	b8 15 00 00 00       	mov    $0x15,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <kill>:
SYSCALL(kill)
 3b3:	b8 06 00 00 00       	mov    $0x6,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <exec>:
SYSCALL(exec)
 3bb:	b8 07 00 00 00       	mov    $0x7,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <open>:
SYSCALL(open)
 3c3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <mknod>:
SYSCALL(mknod)
 3cb:	b8 11 00 00 00       	mov    $0x11,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <unlink>:
SYSCALL(unlink)
 3d3:	b8 12 00 00 00       	mov    $0x12,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <fstat>:
SYSCALL(fstat)
 3db:	b8 08 00 00 00       	mov    $0x8,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <link>:
SYSCALL(link)
 3e3:	b8 13 00 00 00       	mov    $0x13,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <mkdir>:
SYSCALL(mkdir)
 3eb:	b8 14 00 00 00       	mov    $0x14,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <chdir>:
SYSCALL(chdir)
 3f3:	b8 09 00 00 00       	mov    $0x9,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <dup>:
SYSCALL(dup)
 3fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <getpid>:
SYSCALL(getpid)
 403:	b8 0b 00 00 00       	mov    $0xb,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <sbrk>:
SYSCALL(sbrk)
 40b:	b8 0c 00 00 00       	mov    $0xc,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <sleep>:
SYSCALL(sleep)
 413:	b8 0d 00 00 00       	mov    $0xd,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <uptime>:
SYSCALL(uptime)
 41b:	b8 0e 00 00 00       	mov    $0xe,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <worldpeace>:
SYSCALL(worldpeace)
 423:	b8 16 00 00 00       	mov    $0x16,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <numberofprocesses>:
SYSCALL(numberofprocesses)
 42b:	b8 17 00 00 00       	mov    $0x17,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <whatsthestatus>:
SYSCALL(whatsthestatus)
 433:	b8 18 00 00 00       	mov    $0x18,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <get_sibling>:
SYSCALL(get_sibling)
 43b:	b8 19 00 00 00       	mov    $0x19,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <spawn>:
SYSCALL(spawn)
 443:	b8 1a 00 00 00       	mov    $0x1a,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <getvasize>:
SYSCALL(getvasize)
 44b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <va2pa>:
SYSCALL(va2pa)
 453:	b8 1c 00 00 00       	mov    $0x1c,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 45b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 463:	b8 1e 00 00 00       	mov    $0x1e,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 46b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <getpasize>:
SYSCALL(getpasize)
 473:	b8 20 00 00 00       	mov    $0x20,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret
 47b:	66 90                	xchg   %ax,%ax
 47d:	66 90                	xchg   %ax,%ax
 47f:	90                   	nop

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	89 cb                	mov    %ecx,%ebx
 488:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 48b:	89 d1                	mov    %edx,%ecx
{
 48d:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 490:	89 d0                	mov    %edx,%eax
 492:	c1 e8 1f             	shr    $0x1f,%eax
 495:	84 c0                	test   %al,%al
 497:	0f 84 93 00 00 00    	je     530 <printint+0xb0>
 49d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4a1:	0f 84 89 00 00 00    	je     530 <printint+0xb0>
    x = -xx;
 4a7:	f7 d9                	neg    %ecx
    neg = 1;
 4a9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4ae:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4b5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4b8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 4bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 4c0:	89 c8                	mov    %ecx,%eax
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 4c7:	f7 f3                	div    %ebx
 4c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4cc:	0f b6 92 48 09 00 00 	movzbl 0x948(%edx),%edx
 4d3:	8d 47 01             	lea    0x1(%edi),%eax
 4d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 4d9:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 4dd:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 4df:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 4e2:	39 da                	cmp    %ebx,%edx
 4e4:	73 da                	jae    4c0 <printint+0x40>
  if(neg)
 4e6:	8b 45 b8             	mov    -0x48(%ebp),%eax
 4e9:	85 c0                	test   %eax,%eax
 4eb:	74 0a                	je     4f7 <printint+0x77>
    buf[i++] = '-';
 4ed:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4f0:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 4f5:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 4f7:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4fa:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 4fe:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 500:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 503:	89 74 24 04          	mov    %esi,0x4(%esp)
 507:	88 45 d7             	mov    %al,-0x29(%ebp)
 50a:	b8 01 00 00 00       	mov    $0x1,%eax
 50f:	89 44 24 08          	mov    %eax,0x8(%esp)
 513:	8b 45 bc             	mov    -0x44(%ebp),%eax
 516:	89 04 24             	mov    %eax,(%esp)
 519:	e8 85 fe ff ff       	call   3a3 <write>
  while(--i >= 0)
 51e:	89 f8                	mov    %edi,%eax
 520:	4f                   	dec    %edi
 521:	39 d8                	cmp    %ebx,%eax
 523:	75 db                	jne    500 <printint+0x80>
}
 525:	83 c4 4c             	add    $0x4c,%esp
 528:	5b                   	pop    %ebx
 529:	5e                   	pop    %esi
 52a:	5f                   	pop    %edi
 52b:	5d                   	pop    %ebp
 52c:	c3                   	ret
 52d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 530:	31 c0                	xor    %eax,%eax
 532:	e9 77 ff ff ff       	jmp    4ae <printint+0x2e>
 537:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53e:	00 
 53f:	90                   	nop

00000540 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 549:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 54c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 54f:	0f b6 13             	movzbl (%ebx),%edx
 552:	43                   	inc    %ebx
 553:	84 d2                	test   %dl,%dl
 555:	74 35                	je     58c <printf+0x4c>
 557:	8d 45 10             	lea    0x10(%ebp),%eax
 55a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 55d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 560:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 563:	83 f8 25             	cmp    $0x25,%eax
 566:	74 30                	je     598 <printf+0x58>
  write(fd, &c, 1);
 568:	89 34 24             	mov    %esi,(%esp)
 56b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 570:	43                   	inc    %ebx
  write(fd, &c, 1);
 571:	89 44 24 08          	mov    %eax,0x8(%esp)
 575:	8d 45 e7             	lea    -0x19(%ebp),%eax
 578:	89 44 24 04          	mov    %eax,0x4(%esp)
 57c:	88 55 e7             	mov    %dl,-0x19(%ebp)
 57f:	e8 1f fe ff ff       	call   3a3 <write>
  for(i = 0; fmt[i]; i++){
 584:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 588:	84 d2                	test   %dl,%dl
 58a:	75 d4                	jne    560 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 58c:	83 c4 3c             	add    $0x3c,%esp
 58f:	5b                   	pop    %ebx
 590:	5e                   	pop    %esi
 591:	5f                   	pop    %edi
 592:	5d                   	pop    %ebp
 593:	c3                   	ret
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 598:	0f b6 13             	movzbl (%ebx),%edx
 59b:	84 d2                	test   %dl,%dl
 59d:	74 ed                	je     58c <printf+0x4c>
    c = fmt[i] & 0xff;
 59f:	80 fa 25             	cmp    $0x25,%dl
 5a2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 5a5:	0f 84 75 01 00 00    	je     720 <printf+0x1e0>
 5ab:	83 e8 63             	sub    $0x63,%eax
 5ae:	83 f8 15             	cmp    $0x15,%eax
 5b1:	77 0d                	ja     5c0 <printf+0x80>
 5b3:	ff 24 85 f0 08 00 00 	jmp    *0x8f0(,%eax,4)
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5c0:	89 34 24             	mov    %esi,(%esp)
 5c3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5c6:	b8 01 00 00 00       	mov    $0x1,%eax
 5cb:	89 44 24 08          	mov    %eax,0x8(%esp)
 5cf:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5d3:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 5d6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 5da:	e8 c4 fd ff ff       	call   3a3 <write>
        putc(fd, c);
 5df:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 5e3:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5e6:	ba 01 00 00 00       	mov    $0x1,%edx
 5eb:	89 54 24 08          	mov    %edx,0x8(%esp)
 5ef:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 5f3:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 5f6:	89 34 24             	mov    %esi,(%esp)
 5f9:	e8 a5 fd ff ff       	call   3a3 <write>
  for(i = 0; fmt[i]; i++){
 5fe:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 602:	84 d2                	test   %dl,%dl
 604:	0f 85 56 ff ff ff    	jne    560 <printf+0x20>
}
 60a:	83 c4 3c             	add    $0x3c,%esp
 60d:	5b                   	pop    %ebx
 60e:	5e                   	pop    %esi
 60f:	5f                   	pop    %edi
 610:	5d                   	pop    %ebp
 611:	c3                   	ret
 612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 618:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 61b:	b9 10 00 00 00       	mov    $0x10,%ecx
 620:	8b 17                	mov    (%edi),%edx
 622:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 629:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 62c:	89 f0                	mov    %esi,%eax
 62e:	e8 4d fe ff ff       	call   480 <printint>
  for(i = 0; fmt[i]; i++){
 633:	83 c3 02             	add    $0x2,%ebx
        ap++;
 636:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 639:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 63d:	84 d2                	test   %dl,%dl
 63f:	0f 85 1b ff ff ff    	jne    560 <printf+0x20>
}
 645:	83 c4 3c             	add    $0x3c,%esp
 648:	5b                   	pop    %ebx
 649:	5e                   	pop    %esi
 64a:	5f                   	pop    %edi
 64b:	5d                   	pop    %ebp
 64c:	c3                   	ret
 64d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 650:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 653:	8b 01                	mov    (%ecx),%eax
        ap++;
 655:	83 c1 04             	add    $0x4,%ecx
 658:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 65b:	85 c0                	test   %eax,%eax
 65d:	0f 84 d5 00 00 00    	je     738 <printf+0x1f8>
        while(*s != 0){
 663:	0f b6 10             	movzbl (%eax),%edx
 666:	84 d2                	test   %dl,%dl
 668:	74 39                	je     6a3 <printf+0x163>
 66a:	89 c7                	mov    %eax,%edi
 66c:	88 d0                	mov    %dl,%al
 66e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 671:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 674:	89 fb                	mov    %edi,%ebx
 676:	89 cf                	mov    %ecx,%edi
 678:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 67f:	00 
          putc(fd, *s);
 680:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 683:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 688:	43                   	inc    %ebx
  write(fd, &c, 1);
 689:	89 44 24 08          	mov    %eax,0x8(%esp)
 68d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 691:	89 34 24             	mov    %esi,(%esp)
 694:	e8 0a fd ff ff       	call   3a3 <write>
        while(*s != 0){
 699:	0f b6 03             	movzbl (%ebx),%eax
 69c:	84 c0                	test   %al,%al
 69e:	75 e0                	jne    680 <printf+0x140>
 6a0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 6a3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 6a7:	83 c3 02             	add    $0x2,%ebx
 6aa:	84 d2                	test   %dl,%dl
 6ac:	0f 85 ae fe ff ff    	jne    560 <printf+0x20>
 6b2:	e9 d5 fe ff ff       	jmp    58c <printf+0x4c>
 6b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6be:	00 
 6bf:	90                   	nop
        printint(fd, *ap, 10, 1);
 6c0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6c8:	8b 17                	mov    (%edi),%edx
 6ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6d1:	e9 53 ff ff ff       	jmp    629 <printf+0xe9>
 6d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6dd:	00 
 6de:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 6e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 6e3:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 6e8:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 6eb:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 6ed:	89 7c 24 08          	mov    %edi,0x8(%esp)
 6f1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 6f4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6f8:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 6fb:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 6fe:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 702:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 705:	e8 99 fc ff ff       	call   3a3 <write>
        ap++;
 70a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 70e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 712:	84 d2                	test   %dl,%dl
 714:	0f 85 46 fe ff ff    	jne    560 <printf+0x20>
 71a:	e9 6d fe ff ff       	jmp    58c <printf+0x4c>
 71f:	90                   	nop
        putc(fd, c);
 720:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 723:	8d 7d e7             	lea    -0x19(%ebp),%edi
 726:	b9 01 00 00 00       	mov    $0x1,%ecx
 72b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 72f:	e9 bb fe ff ff       	jmp    5ef <printf+0xaf>
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 738:	bf e8 08 00 00       	mov    $0x8e8,%edi
 73d:	b0 28                	mov    $0x28,%al
 73f:	e9 2a ff ff ff       	jmp    66e <printf+0x12e>
 744:	66 90                	xchg   %ax,%ax
 746:	66 90                	xchg   %ax,%ax
 748:	66 90                	xchg   %ax,%ax
 74a:	66 90                	xchg   %ax,%ax
 74c:	66 90                	xchg   %ax,%ax
 74e:	66 90                	xchg   %ax,%ax

00000750 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 750:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	a1 5c 09 00 00       	mov    0x95c,%eax
{
 756:	89 e5                	mov    %esp,%ebp
 758:	57                   	push   %edi
 759:	56                   	push   %esi
 75a:	53                   	push   %ebx
 75b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 75e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 761:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 768:	00 
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 770:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 772:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 774:	39 ca                	cmp    %ecx,%edx
 776:	73 30                	jae    7a8 <free+0x58>
 778:	39 c1                	cmp    %eax,%ecx
 77a:	72 04                	jb     780 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77c:	39 c2                	cmp    %eax,%edx
 77e:	72 f0                	jb     770 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 780:	8b 73 fc             	mov    -0x4(%ebx),%esi
 783:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 786:	39 f8                	cmp    %edi,%eax
 788:	74 36                	je     7c0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 78a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 78d:	8b 42 04             	mov    0x4(%edx),%eax
 790:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 793:	39 f1                	cmp    %esi,%ecx
 795:	74 42                	je     7d9 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 797:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 799:	5b                   	pop    %ebx
  freep = p;
 79a:	89 15 5c 09 00 00    	mov    %edx,0x95c
}
 7a0:	5e                   	pop    %esi
 7a1:	5f                   	pop    %edi
 7a2:	5d                   	pop    %ebp
 7a3:	c3                   	ret
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a8:	39 c2                	cmp    %eax,%edx
 7aa:	72 c4                	jb     770 <free+0x20>
 7ac:	39 c1                	cmp    %eax,%ecx
 7ae:	73 c0                	jae    770 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 7b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7b6:	39 f8                	cmp    %edi,%eax
 7b8:	75 d0                	jne    78a <free+0x3a>
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 7c0:	8b 78 04             	mov    0x4(%eax),%edi
 7c3:	01 fe                	add    %edi,%esi
 7c5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c8:	8b 02                	mov    (%edx),%eax
 7ca:	8b 00                	mov    (%eax),%eax
 7cc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7cf:	8b 42 04             	mov    0x4(%edx),%eax
 7d2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7d5:	39 f1                	cmp    %esi,%ecx
 7d7:	75 be                	jne    797 <free+0x47>
  freep = p;
 7d9:	89 15 5c 09 00 00    	mov    %edx,0x95c
    p->s.size += bp->s.size;
 7df:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 7e2:	01 c8                	add    %ecx,%eax
 7e4:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7e7:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7ea:	89 0a                	mov    %ecx,(%edx)
}
 7ec:	5b                   	pop    %ebx
 7ed:	5e                   	pop    %esi
 7ee:	5f                   	pop    %edi
 7ef:	5d                   	pop    %ebp
 7f0:	c3                   	ret
 7f1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7f8:	00 
 7f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 809:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 80c:	8b 15 5c 09 00 00    	mov    0x95c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 812:	8d 78 07             	lea    0x7(%eax),%edi
 815:	c1 ef 03             	shr    $0x3,%edi
 818:	47                   	inc    %edi
  if((prevp = freep) == 0){
 819:	85 d2                	test   %edx,%edx
 81b:	0f 84 8f 00 00 00    	je     8b0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 821:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 823:	8b 48 04             	mov    0x4(%eax),%ecx
 826:	39 f9                	cmp    %edi,%ecx
 828:	73 5e                	jae    888 <malloc+0x88>
  if(nu < 4096)
 82a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 82f:	39 df                	cmp    %ebx,%edi
 831:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 834:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 83b:	eb 0c                	jmp    849 <malloc+0x49>
 83d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 840:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 842:	8b 48 04             	mov    0x4(%eax),%ecx
 845:	39 f9                	cmp    %edi,%ecx
 847:	73 3f                	jae    888 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 849:	39 05 5c 09 00 00    	cmp    %eax,0x95c
 84f:	89 c2                	mov    %eax,%edx
 851:	75 ed                	jne    840 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 853:	89 34 24             	mov    %esi,(%esp)
 856:	e8 b0 fb ff ff       	call   40b <sbrk>
  if(p == (char*)-1)
 85b:	83 f8 ff             	cmp    $0xffffffff,%eax
 85e:	74 18                	je     878 <malloc+0x78>
  hp->s.size = nu;
 860:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 863:	83 c0 08             	add    $0x8,%eax
 866:	89 04 24             	mov    %eax,(%esp)
 869:	e8 e2 fe ff ff       	call   750 <free>
  return freep;
 86e:	8b 15 5c 09 00 00    	mov    0x95c,%edx
      if((p = morecore(nunits)) == 0)
 874:	85 d2                	test   %edx,%edx
 876:	75 c8                	jne    840 <malloc+0x40>
        return 0;
  }
}
 878:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 87b:	31 c0                	xor    %eax,%eax
}
 87d:	5b                   	pop    %ebx
 87e:	5e                   	pop    %esi
 87f:	5f                   	pop    %edi
 880:	5d                   	pop    %ebp
 881:	c3                   	ret
 882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 888:	39 cf                	cmp    %ecx,%edi
 88a:	74 54                	je     8e0 <malloc+0xe0>
        p->s.size -= nunits;
 88c:	29 f9                	sub    %edi,%ecx
 88e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 891:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 894:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 897:	89 15 5c 09 00 00    	mov    %edx,0x95c
}
 89d:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 8a0:	83 c0 08             	add    $0x8,%eax
}
 8a3:	5b                   	pop    %ebx
 8a4:	5e                   	pop    %esi
 8a5:	5f                   	pop    %edi
 8a6:	5d                   	pop    %ebp
 8a7:	c3                   	ret
 8a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8af:	00 
    base.s.ptr = freep = prevp = &base;
 8b0:	b8 60 09 00 00       	mov    $0x960,%eax
 8b5:	ba 60 09 00 00       	mov    $0x960,%edx
 8ba:	a3 5c 09 00 00       	mov    %eax,0x95c
    base.s.size = 0;
 8bf:	31 c9                	xor    %ecx,%ecx
 8c1:	b8 60 09 00 00       	mov    $0x960,%eax
    base.s.ptr = freep = prevp = &base;
 8c6:	89 15 60 09 00 00    	mov    %edx,0x960
    base.s.size = 0;
 8cc:	89 0d 64 09 00 00    	mov    %ecx,0x964
    if(p->s.size >= nunits){
 8d2:	e9 53 ff ff ff       	jmp    82a <malloc+0x2a>
 8d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8de:	00 
 8df:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 8e0:	8b 08                	mov    (%eax),%ecx
 8e2:	89 0a                	mov    %ecx,(%edx)
 8e4:	eb b1                	jmp    897 <malloc+0x97>
