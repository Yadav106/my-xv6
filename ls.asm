
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	bb 01 00 00 00       	mov    $0x1,%ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 75 08             	mov    0x8(%ebp),%esi
  14:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 19                	jle    35 <main+0x35>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  for(i=1; i<argc; i++)
  23:	43                   	inc    %ebx
    ls(argv[i]);
  24:	89 04 24             	mov    %eax,(%esp)
  27:	e8 c4 00 00 00       	call   f0 <ls>
  for(i=1; i<argc; i++)
  2c:	39 de                	cmp    %ebx,%esi
  2e:	75 f0                	jne    20 <main+0x20>
  exit();
  30:	e8 7e 05 00 00       	call   5b3 <exit>
    ls(".");
  35:	c7 04 24 60 0b 00 00 	movl   $0xb60,(%esp)
  3c:	e8 af 00 00 00       	call   f0 <ls>
    exit();
  41:	e8 6d 05 00 00       	call   5b3 <exit>
  46:	66 90                	xchg   %ax,%ax
  48:	66 90                	xchg   %ax,%ax
  4a:	66 90                	xchg   %ax,%ax
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <fmtname>:
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  55:	83 ec 10             	sub    $0x10,%esp
  58:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  5b:	89 34 24             	mov    %esi,(%esp)
  5e:	e8 8d 03 00 00       	call   3f0 <strlen>
  63:	01 f0                	add    %esi,%eax
  65:	89 c3                	mov    %eax,%ebx
  67:	73 10                	jae    79 <fmtname+0x29>
  69:	eb 13                	jmp    7e <fmtname+0x2e>
  6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  70:	8d 43 ff             	lea    -0x1(%ebx),%eax
  73:	39 f0                	cmp    %esi,%eax
  75:	72 08                	jb     7f <fmtname+0x2f>
  77:	89 c3                	mov    %eax,%ebx
  79:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  7c:	75 f2                	jne    70 <fmtname+0x20>
  p++;
  7e:	43                   	inc    %ebx
  if(strlen(p) >= DIRSIZ)
  7f:	89 1c 24             	mov    %ebx,(%esp)
  82:	e8 69 03 00 00       	call   3f0 <strlen>
  87:	83 f8 0d             	cmp    $0xd,%eax
  8a:	77 54                	ja     e0 <fmtname+0x90>
  memmove(buf, p, strlen(p));
  8c:	89 1c 24             	mov    %ebx,(%esp)
  8f:	e8 5c 03 00 00       	call   3f0 <strlen>
  94:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  98:	c7 04 24 d8 0b 00 00 	movl   $0xbd8,(%esp)
  9f:	89 44 24 08          	mov    %eax,0x8(%esp)
  a3:	e8 d8 04 00 00       	call   580 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  a8:	89 1c 24             	mov    %ebx,(%esp)
  ab:	e8 40 03 00 00       	call   3f0 <strlen>
  b0:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  b3:	bb d8 0b 00 00       	mov    $0xbd8,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 c6                	mov    %eax,%esi
  ba:	e8 31 03 00 00       	call   3f0 <strlen>
  bf:	ba 0e 00 00 00       	mov    $0xe,%edx
  c4:	29 f2                	sub    %esi,%edx
  c6:	89 54 24 08          	mov    %edx,0x8(%esp)
  ca:	ba 20 00 00 00       	mov    $0x20,%edx
  cf:	89 54 24 04          	mov    %edx,0x4(%esp)
  d3:	05 d8 0b 00 00       	add    $0xbd8,%eax
  d8:	89 04 24             	mov    %eax,(%esp)
  db:	e8 40 03 00 00       	call   420 <memset>
}
  e0:	83 c4 10             	add    $0x10,%esp
  e3:	89 d8                	mov    %ebx,%eax
  e5:	5b                   	pop    %ebx
  e6:	5e                   	pop    %esi
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <ls>:
{
  f0:	55                   	push   %ebp
  if((fd = open(path, 0)) < 0){
  f1:	31 c0                	xor    %eax,%eax
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	57                   	push   %edi
  f6:	56                   	push   %esi
  f7:	53                   	push   %ebx
  f8:	81 ec 7c 02 00 00    	sub    $0x27c,%esp
  if((fd = open(path, 0)) < 0){
  fe:	89 44 24 04          	mov    %eax,0x4(%esp)
{
 102:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 105:	89 3c 24             	mov    %edi,(%esp)
 108:	e8 e6 04 00 00       	call   5f3 <open>
 10d:	85 c0                	test   %eax,%eax
 10f:	0f 88 bb 01 00 00    	js     2d0 <ls+0x1e0>
  if(fstat(fd, &st) < 0){
 115:	89 04 24             	mov    %eax,(%esp)
 118:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 11e:	89 c3                	mov    %eax,%ebx
 120:	89 74 24 04          	mov    %esi,0x4(%esp)
 124:	e8 e2 04 00 00       	call   60b <fstat>
 129:	85 c0                	test   %eax,%eax
 12b:	0f 88 e7 01 00 00    	js     318 <ls+0x228>
  switch(st.type){
 131:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 138:	83 f8 01             	cmp    $0x1,%eax
 13b:	74 63                	je     1a0 <ls+0xb0>
 13d:	83 f8 02             	cmp    $0x2,%eax
 140:	75 4a                	jne    18c <ls+0x9c>
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 142:	89 3c 24             	mov    %edi,(%esp)
 145:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 14b:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 151:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 157:	e8 f4 fe ff ff       	call   50 <fmtname>
 15c:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 162:	b9 40 0b 00 00       	mov    $0xb40,%ecx
 167:	89 74 24 10          	mov    %esi,0x10(%esp)
 16b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 16f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 176:	89 54 24 14          	mov    %edx,0x14(%esp)
 17a:	ba 02 00 00 00       	mov    $0x2,%edx
 17f:	89 54 24 0c          	mov    %edx,0xc(%esp)
 183:	89 44 24 08          	mov    %eax,0x8(%esp)
 187:	e8 e4 05 00 00       	call   770 <printf>
  close(fd);
 18c:	89 1c 24             	mov    %ebx,(%esp)
 18f:	e8 47 04 00 00       	call   5db <close>
}
 194:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 19a:	5b                   	pop    %ebx
 19b:	5e                   	pop    %esi
 19c:	5f                   	pop    %edi
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret
 19f:	90                   	nop
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a0:	89 3c 24             	mov    %edi,(%esp)
 1a3:	e8 48 02 00 00       	call   3f0 <strlen>
 1a8:	83 c0 10             	add    $0x10,%eax
 1ab:	3d 00 02 00 00       	cmp    $0x200,%eax
 1b0:	0f 87 42 01 00 00    	ja     2f8 <ls+0x208>
    strcpy(buf, path);
 1b6:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ba:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 1c0:	89 3c 24             	mov    %edi,(%esp)
 1c3:	e8 a8 01 00 00       	call   370 <strcpy>
    p = buf+strlen(buf);
 1c8:	89 3c 24             	mov    %edi,(%esp)
 1cb:	e8 20 02 00 00       	call   3f0 <strlen>
 1d0:	8d 0c 07             	lea    (%edi,%eax,1),%ecx
 1d3:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
    *p++ = '/';
 1d9:	8d 44 07 01          	lea    0x1(%edi,%eax,1),%eax
 1dd:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
 1e3:	c6 01 2f             	movb   $0x2f,(%ecx)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ed:	00 
 1ee:	66 90                	xchg   %ax,%ax
 1f0:	89 1c 24             	mov    %ebx,(%esp)
 1f3:	b8 10 00 00 00       	mov    $0x10,%eax
 1f8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1fc:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 202:	89 44 24 04          	mov    %eax,0x4(%esp)
 206:	e8 c0 03 00 00       	call   5cb <read>
 20b:	83 f8 10             	cmp    $0x10,%eax
 20e:	0f 85 78 ff ff ff    	jne    18c <ls+0x9c>
      if(de.inum == 0)
 214:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 21b:	00 
 21c:	74 d2                	je     1f0 <ls+0x100>
      memmove(p, de.name, DIRSIZ);
 21e:	b8 0e 00 00 00       	mov    $0xe,%eax
 223:	89 44 24 08          	mov    %eax,0x8(%esp)
 227:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 22d:	89 44 24 04          	mov    %eax,0x4(%esp)
 231:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 237:	89 04 24             	mov    %eax,(%esp)
 23a:	e8 41 03 00 00       	call   580 <memmove>
      p[DIRSIZ] = 0;
 23f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 245:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 249:	89 74 24 04          	mov    %esi,0x4(%esp)
 24d:	89 3c 24             	mov    %edi,(%esp)
 250:	e8 8b 02 00 00       	call   4e0 <stat>
 255:	85 c0                	test   %eax,%eax
 257:	0f 88 eb 00 00 00    	js     348 <ls+0x258>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 25d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 263:	89 3c 24             	mov    %edi,(%esp)
 266:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 26c:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 273:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 279:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 27f:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 285:	e8 c6 fd ff ff       	call   50 <fmtname>
 28a:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 290:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 297:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 29d:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 2a1:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
 2a7:	89 54 24 10          	mov    %edx,0x10(%esp)
 2ab:	ba 40 0b 00 00       	mov    $0xb40,%edx
 2b0:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b4:	89 54 24 04          	mov    %edx,0x4(%esp)
 2b8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 2bc:	e8 af 04 00 00       	call   770 <printf>
 2c1:	e9 2a ff ff ff       	jmp    1f0 <ls+0x100>
 2c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2cd:	00 
 2ce:	66 90                	xchg   %ax,%ax
    printf(2, "ls: cannot open %s\n", path);
 2d0:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2d4:	bf 18 0b 00 00       	mov    $0xb18,%edi
 2d9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2dd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2e4:	e8 87 04 00 00       	call   770 <printf>
}
 2e9:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 2ef:	5b                   	pop    %ebx
 2f0:	5e                   	pop    %esi
 2f1:	5f                   	pop    %edi
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret
 2f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "ls: path too long\n");
 2f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2ff:	b8 4d 0b 00 00       	mov    $0xb4d,%eax
 304:	89 44 24 04          	mov    %eax,0x4(%esp)
 308:	e8 63 04 00 00       	call   770 <printf>
      break;
 30d:	e9 7a fe ff ff       	jmp    18c <ls+0x9c>
 312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "ls: cannot stat %s\n", path);
 318:	89 7c 24 08          	mov    %edi,0x8(%esp)
 31c:	be 2c 0b 00 00       	mov    $0xb2c,%esi
 321:	89 74 24 04          	mov    %esi,0x4(%esp)
 325:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 32c:	e8 3f 04 00 00       	call   770 <printf>
    close(fd);
 331:	89 1c 24             	mov    %ebx,(%esp)
 334:	e8 a2 02 00 00       	call   5db <close>
}
 339:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 33f:	5b                   	pop    %ebx
 340:	5e                   	pop    %esi
 341:	5f                   	pop    %edi
 342:	5d                   	pop    %ebp
 343:	c3                   	ret
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 348:	89 7c 24 08          	mov    %edi,0x8(%esp)
 34c:	b9 2c 0b 00 00       	mov    $0xb2c,%ecx
 351:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 355:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 35c:	e8 0f 04 00 00       	call   770 <printf>
        continue;
 361:	e9 8a fe ff ff       	jmp    1f0 <ls+0x100>
 366:	66 90                	xchg   %ax,%ax
 368:	66 90                	xchg   %ax,%ax
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 370:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 371:	31 c0                	xor    %eax,%eax
{
 373:	89 e5                	mov    %esp,%ebp
 375:	53                   	push   %ebx
 376:	8b 4d 08             	mov    0x8(%ebp),%ecx
 379:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 380:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 384:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 387:	40                   	inc    %eax
 388:	84 d2                	test   %dl,%dl
 38a:	75 f4                	jne    380 <strcpy+0x10>
    ;
  return os;
}
 38c:	5b                   	pop    %ebx
 38d:	89 c8                	mov    %ecx,%eax
 38f:	5d                   	pop    %ebp
 390:	c3                   	ret
 391:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 398:	00 
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	53                   	push   %ebx
 3a4:	8b 55 08             	mov    0x8(%ebp),%edx
 3a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 3aa:	0f b6 02             	movzbl (%edx),%eax
 3ad:	84 c0                	test   %al,%al
 3af:	75 15                	jne    3c6 <strcmp+0x26>
 3b1:	eb 30                	jmp    3e3 <strcmp+0x43>
 3b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 3b8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 3bc:	8d 4b 01             	lea    0x1(%ebx),%ecx
 3bf:	42                   	inc    %edx
  while(*p && *p == *q)
 3c0:	84 c0                	test   %al,%al
 3c2:	74 14                	je     3d8 <strcmp+0x38>
 3c4:	89 cb                	mov    %ecx,%ebx
 3c6:	0f b6 0b             	movzbl (%ebx),%ecx
 3c9:	38 c1                	cmp    %al,%cl
 3cb:	74 eb                	je     3b8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 3cd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 3ce:	29 c8                	sub    %ecx,%eax
}
 3d0:	5d                   	pop    %ebp
 3d1:	c3                   	ret
 3d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 3d8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 3dc:	31 c0                	xor    %eax,%eax
}
 3de:	5b                   	pop    %ebx
 3df:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 3e0:	29 c8                	sub    %ecx,%eax
}
 3e2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 3e3:	0f b6 0b             	movzbl (%ebx),%ecx
 3e6:	31 c0                	xor    %eax,%eax
 3e8:	eb e3                	jmp    3cd <strcmp+0x2d>
 3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003f0 <strlen>:

uint
strlen(const char *s)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3f6:	80 3a 00             	cmpb   $0x0,(%edx)
 3f9:	74 15                	je     410 <strlen+0x20>
 3fb:	31 c0                	xor    %eax,%eax
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	40                   	inc    %eax
 401:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 405:	89 c1                	mov    %eax,%ecx
 407:	75 f7                	jne    400 <strlen+0x10>
    ;
  return n;
}
 409:	5d                   	pop    %ebp
 40a:	89 c8                	mov    %ecx,%eax
 40c:	c3                   	ret
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 411:	31 c9                	xor    %ecx,%ecx
}
 413:	89 c8                	mov    %ecx,%eax
 415:	c3                   	ret
 416:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41d:	00 
 41e:	66 90                	xchg   %ax,%ax

00000420 <memset>:

void*
memset(void *dst, int c, uint n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	8b 55 08             	mov    0x8(%ebp),%edx
 426:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 427:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	89 d7                	mov    %edx,%edi
 42f:	fc                   	cld
 430:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 432:	5f                   	pop    %edi
 433:	89 d0                	mov    %edx,%eax
 435:	5d                   	pop    %ebp
 436:	c3                   	ret
 437:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43e:	00 
 43f:	90                   	nop

00000440 <strchr>:

char*
strchr(const char *s, char c)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	8b 45 08             	mov    0x8(%ebp),%eax
 446:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 44a:	0f b6 10             	movzbl (%eax),%edx
 44d:	84 d2                	test   %dl,%dl
 44f:	75 10                	jne    461 <strchr+0x21>
 451:	eb 1d                	jmp    470 <strchr+0x30>
 453:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 458:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 45c:	40                   	inc    %eax
 45d:	84 d2                	test   %dl,%dl
 45f:	74 0f                	je     470 <strchr+0x30>
    if(*s == c)
 461:	38 d1                	cmp    %dl,%cl
 463:	75 f3                	jne    458 <strchr+0x18>
      return (char*)s;
  return 0;
}
 465:	5d                   	pop    %ebp
 466:	c3                   	ret
 467:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 46e:	00 
 46f:	90                   	nop
 470:	5d                   	pop    %ebp
  return 0;
 471:	31 c0                	xor    %eax,%eax
}
 473:	c3                   	ret
 474:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47b:	00 
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000480 <gets>:

char*
gets(char *buf, int max)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 485:	31 f6                	xor    %esi,%esi
{
 487:	53                   	push   %ebx
    cc = read(0, &c, 1);
 488:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 48b:	83 ec 3c             	sub    $0x3c,%esp
 48e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 491:	eb 32                	jmp    4c5 <gets+0x45>
 493:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 498:	89 7c 24 04          	mov    %edi,0x4(%esp)
 49c:	b8 01 00 00 00       	mov    $0x1,%eax
 4a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 4a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4ac:	e8 1a 01 00 00       	call   5cb <read>
    if(cc < 1)
 4b1:	85 c0                	test   %eax,%eax
 4b3:	7e 19                	jle    4ce <gets+0x4e>
      break;
    buf[i++] = c;
 4b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4b9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 4bd:	3c 0a                	cmp    $0xa,%al
 4bf:	74 10                	je     4d1 <gets+0x51>
 4c1:	3c 0d                	cmp    $0xd,%al
 4c3:	74 0c                	je     4d1 <gets+0x51>
  for(i=0; i+1 < max; ){
 4c5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4c8:	46                   	inc    %esi
 4c9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 4cc:	7c ca                	jl     498 <gets+0x18>
 4ce:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 4d1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 4d5:	83 c4 3c             	add    $0x3c,%esp
 4d8:	89 d8                	mov    %ebx,%eax
 4da:	5b                   	pop    %ebx
 4db:	5e                   	pop    %esi
 4dc:	5f                   	pop    %edi
 4dd:	5d                   	pop    %ebp
 4de:	c3                   	ret
 4df:	90                   	nop

000004e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4e0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e1:	31 c0                	xor    %eax,%eax
{
 4e3:	89 e5                	mov    %esp,%ebp
 4e5:	83 ec 18             	sub    $0x18,%esp
 4e8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4eb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 4ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f2:	8b 45 08             	mov    0x8(%ebp),%eax
 4f5:	89 04 24             	mov    %eax,(%esp)
 4f8:	e8 f6 00 00 00       	call   5f3 <open>
  if(fd < 0)
 4fd:	85 c0                	test   %eax,%eax
 4ff:	78 2f                	js     530 <stat+0x50>
 501:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 503:	8b 45 0c             	mov    0xc(%ebp),%eax
 506:	89 1c 24             	mov    %ebx,(%esp)
 509:	89 44 24 04          	mov    %eax,0x4(%esp)
 50d:	e8 f9 00 00 00       	call   60b <fstat>
  close(fd);
 512:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 515:	89 c6                	mov    %eax,%esi
  close(fd);
 517:	e8 bf 00 00 00       	call   5db <close>
  return r;
}
 51c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 51f:	89 f0                	mov    %esi,%eax
 521:	8b 75 fc             	mov    -0x4(%ebp),%esi
 524:	89 ec                	mov    %ebp,%esp
 526:	5d                   	pop    %ebp
 527:	c3                   	ret
 528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 52f:	00 
    return -1;
 530:	be ff ff ff ff       	mov    $0xffffffff,%esi
 535:	eb e5                	jmp    51c <stat+0x3c>
 537:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53e:	00 
 53f:	90                   	nop

00000540 <atoi>:

int
atoi(const char *s)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	53                   	push   %ebx
 544:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 547:	0f be 02             	movsbl (%edx),%eax
 54a:	88 c1                	mov    %al,%cl
 54c:	80 e9 30             	sub    $0x30,%cl
 54f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 552:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 557:	77 1c                	ja     575 <atoi+0x35>
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 560:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 563:	42                   	inc    %edx
 564:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 568:	0f be 02             	movsbl (%edx),%eax
 56b:	88 c3                	mov    %al,%bl
 56d:	80 eb 30             	sub    $0x30,%bl
 570:	80 fb 09             	cmp    $0x9,%bl
 573:	76 eb                	jbe    560 <atoi+0x20>
  return n;
}
 575:	5b                   	pop    %ebx
 576:	89 c8                	mov    %ecx,%eax
 578:	5d                   	pop    %ebp
 579:	c3                   	ret
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000580 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	8b 45 10             	mov    0x10(%ebp),%eax
 587:	56                   	push   %esi
 588:	8b 55 08             	mov    0x8(%ebp),%edx
 58b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 58e:	85 c0                	test   %eax,%eax
 590:	7e 13                	jle    5a5 <memmove+0x25>
 592:	01 d0                	add    %edx,%eax
  dst = vdst;
 594:	89 d7                	mov    %edx,%edi
 596:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59d:	00 
 59e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 5a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5a1:	39 f8                	cmp    %edi,%eax
 5a3:	75 fb                	jne    5a0 <memmove+0x20>
  return vdst;
}
 5a5:	5e                   	pop    %esi
 5a6:	89 d0                	mov    %edx,%eax
 5a8:	5f                   	pop    %edi
 5a9:	5d                   	pop    %ebp
 5aa:	c3                   	ret

000005ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ab:	b8 01 00 00 00       	mov    $0x1,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret

000005b3 <exit>:
SYSCALL(exit)
 5b3:	b8 02 00 00 00       	mov    $0x2,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret

000005bb <wait>:
SYSCALL(wait)
 5bb:	b8 03 00 00 00       	mov    $0x3,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret

000005c3 <pipe>:
SYSCALL(pipe)
 5c3:	b8 04 00 00 00       	mov    $0x4,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret

000005cb <read>:
SYSCALL(read)
 5cb:	b8 05 00 00 00       	mov    $0x5,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret

000005d3 <write>:
SYSCALL(write)
 5d3:	b8 10 00 00 00       	mov    $0x10,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret

000005db <close>:
SYSCALL(close)
 5db:	b8 15 00 00 00       	mov    $0x15,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret

000005e3 <kill>:
SYSCALL(kill)
 5e3:	b8 06 00 00 00       	mov    $0x6,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret

000005eb <exec>:
SYSCALL(exec)
 5eb:	b8 07 00 00 00       	mov    $0x7,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret

000005f3 <open>:
SYSCALL(open)
 5f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret

000005fb <mknod>:
SYSCALL(mknod)
 5fb:	b8 11 00 00 00       	mov    $0x11,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret

00000603 <unlink>:
SYSCALL(unlink)
 603:	b8 12 00 00 00       	mov    $0x12,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret

0000060b <fstat>:
SYSCALL(fstat)
 60b:	b8 08 00 00 00       	mov    $0x8,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret

00000613 <link>:
SYSCALL(link)
 613:	b8 13 00 00 00       	mov    $0x13,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret

0000061b <mkdir>:
SYSCALL(mkdir)
 61b:	b8 14 00 00 00       	mov    $0x14,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret

00000623 <chdir>:
SYSCALL(chdir)
 623:	b8 09 00 00 00       	mov    $0x9,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret

0000062b <dup>:
SYSCALL(dup)
 62b:	b8 0a 00 00 00       	mov    $0xa,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret

00000633 <getpid>:
SYSCALL(getpid)
 633:	b8 0b 00 00 00       	mov    $0xb,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret

0000063b <sbrk>:
SYSCALL(sbrk)
 63b:	b8 0c 00 00 00       	mov    $0xc,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret

00000643 <sleep>:
SYSCALL(sleep)
 643:	b8 0d 00 00 00       	mov    $0xd,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret

0000064b <uptime>:
SYSCALL(uptime)
 64b:	b8 0e 00 00 00       	mov    $0xe,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret

00000653 <worldpeace>:
SYSCALL(worldpeace)
 653:	b8 16 00 00 00       	mov    $0x16,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret

0000065b <numberofprocesses>:
SYSCALL(numberofprocesses)
 65b:	b8 17 00 00 00       	mov    $0x17,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret

00000663 <whatsthestatus>:
SYSCALL(whatsthestatus)
 663:	b8 18 00 00 00       	mov    $0x18,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret

0000066b <get_sibling>:
SYSCALL(get_sibling)
 66b:	b8 19 00 00 00       	mov    $0x19,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret

00000673 <spawn>:
SYSCALL(spawn)
 673:	b8 1a 00 00 00       	mov    $0x1a,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret

0000067b <getvasize>:
SYSCALL(getvasize)
 67b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret

00000683 <va2pa>:
SYSCALL(va2pa)
 683:	b8 1c 00 00 00       	mov    $0x1c,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret

0000068b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 68b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret

00000693 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 693:	b8 1e 00 00 00       	mov    $0x1e,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret

0000069b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 69b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret

000006a3 <getpasize>:
SYSCALL(getpasize)
 6a3:	b8 20 00 00 00       	mov    $0x20,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret
 6ab:	66 90                	xchg   %ax,%ax
 6ad:	66 90                	xchg   %ax,%ax
 6af:	90                   	nop

000006b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	89 cb                	mov    %ecx,%ebx
 6b8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6bb:	89 d1                	mov    %edx,%ecx
{
 6bd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 6c0:	89 d0                	mov    %edx,%eax
 6c2:	c1 e8 1f             	shr    $0x1f,%eax
 6c5:	84 c0                	test   %al,%al
 6c7:	0f 84 93 00 00 00    	je     760 <printint+0xb0>
 6cd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6d1:	0f 84 89 00 00 00    	je     760 <printint+0xb0>
    x = -xx;
 6d7:	f7 d9                	neg    %ecx
    neg = 1;
 6d9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 6de:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6e5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 6e8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 6eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 6f0:	89 c8                	mov    %ecx,%eax
 6f2:	31 d2                	xor    %edx,%edx
 6f4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 6f7:	f7 f3                	div    %ebx
 6f9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6fc:	0f b6 92 c4 0b 00 00 	movzbl 0xbc4(%edx),%edx
 703:	8d 47 01             	lea    0x1(%edi),%eax
 706:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 709:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 70d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 70f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 712:	39 da                	cmp    %ebx,%edx
 714:	73 da                	jae    6f0 <printint+0x40>
  if(neg)
 716:	8b 45 b8             	mov    -0x48(%ebp),%eax
 719:	85 c0                	test   %eax,%eax
 71b:	74 0a                	je     727 <printint+0x77>
    buf[i++] = '-';
 71d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 720:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 725:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 727:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 72a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 72e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 730:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 733:	89 74 24 04          	mov    %esi,0x4(%esp)
 737:	88 45 d7             	mov    %al,-0x29(%ebp)
 73a:	b8 01 00 00 00       	mov    $0x1,%eax
 73f:	89 44 24 08          	mov    %eax,0x8(%esp)
 743:	8b 45 bc             	mov    -0x44(%ebp),%eax
 746:	89 04 24             	mov    %eax,(%esp)
 749:	e8 85 fe ff ff       	call   5d3 <write>
  while(--i >= 0)
 74e:	89 f8                	mov    %edi,%eax
 750:	4f                   	dec    %edi
 751:	39 d8                	cmp    %ebx,%eax
 753:	75 db                	jne    730 <printint+0x80>
}
 755:	83 c4 4c             	add    $0x4c,%esp
 758:	5b                   	pop    %ebx
 759:	5e                   	pop    %esi
 75a:	5f                   	pop    %edi
 75b:	5d                   	pop    %ebp
 75c:	c3                   	ret
 75d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 760:	31 c0                	xor    %eax,%eax
 762:	e9 77 ff ff ff       	jmp    6de <printint+0x2e>
 767:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 76e:	00 
 76f:	90                   	nop

00000770 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	56                   	push   %esi
 775:	53                   	push   %ebx
 776:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 779:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 77c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 77f:	0f b6 13             	movzbl (%ebx),%edx
 782:	43                   	inc    %ebx
 783:	84 d2                	test   %dl,%dl
 785:	74 35                	je     7bc <printf+0x4c>
 787:	8d 45 10             	lea    0x10(%ebp),%eax
 78a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 78d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 790:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 793:	83 f8 25             	cmp    $0x25,%eax
 796:	74 30                	je     7c8 <printf+0x58>
  write(fd, &c, 1);
 798:	89 34 24             	mov    %esi,(%esp)
 79b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 7a0:	43                   	inc    %ebx
  write(fd, &c, 1);
 7a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 7a5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 7ac:	88 55 e7             	mov    %dl,-0x19(%ebp)
 7af:	e8 1f fe ff ff       	call   5d3 <write>
  for(i = 0; fmt[i]; i++){
 7b4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 7b8:	84 d2                	test   %dl,%dl
 7ba:	75 d4                	jne    790 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7bc:	83 c4 3c             	add    $0x3c,%esp
 7bf:	5b                   	pop    %ebx
 7c0:	5e                   	pop    %esi
 7c1:	5f                   	pop    %edi
 7c2:	5d                   	pop    %ebp
 7c3:	c3                   	ret
 7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 7c8:	0f b6 13             	movzbl (%ebx),%edx
 7cb:	84 d2                	test   %dl,%dl
 7cd:	74 ed                	je     7bc <printf+0x4c>
    c = fmt[i] & 0xff;
 7cf:	80 fa 25             	cmp    $0x25,%dl
 7d2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 7d5:	0f 84 75 01 00 00    	je     950 <printf+0x1e0>
 7db:	83 e8 63             	sub    $0x63,%eax
 7de:	83 f8 15             	cmp    $0x15,%eax
 7e1:	77 0d                	ja     7f0 <printf+0x80>
 7e3:	ff 24 85 6c 0b 00 00 	jmp    *0xb6c(,%eax,4)
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7f0:	89 34 24             	mov    %esi,(%esp)
 7f3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 7f6:	b8 01 00 00 00       	mov    $0x1,%eax
 7fb:	89 44 24 08          	mov    %eax,0x8(%esp)
 7ff:	89 7c 24 04          	mov    %edi,0x4(%esp)
 803:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 806:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 80a:	e8 c4 fd ff ff       	call   5d3 <write>
        putc(fd, c);
 80f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 813:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 816:	ba 01 00 00 00       	mov    $0x1,%edx
 81b:	89 54 24 08          	mov    %edx,0x8(%esp)
 81f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 823:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 826:	89 34 24             	mov    %esi,(%esp)
 829:	e8 a5 fd ff ff       	call   5d3 <write>
  for(i = 0; fmt[i]; i++){
 82e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 832:	84 d2                	test   %dl,%dl
 834:	0f 85 56 ff ff ff    	jne    790 <printf+0x20>
}
 83a:	83 c4 3c             	add    $0x3c,%esp
 83d:	5b                   	pop    %ebx
 83e:	5e                   	pop    %esi
 83f:	5f                   	pop    %edi
 840:	5d                   	pop    %ebp
 841:	c3                   	ret
 842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 848:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 84b:	b9 10 00 00 00       	mov    $0x10,%ecx
 850:	8b 17                	mov    (%edi),%edx
 852:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 859:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 85c:	89 f0                	mov    %esi,%eax
 85e:	e8 4d fe ff ff       	call   6b0 <printint>
  for(i = 0; fmt[i]; i++){
 863:	83 c3 02             	add    $0x2,%ebx
        ap++;
 866:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 869:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 86d:	84 d2                	test   %dl,%dl
 86f:	0f 85 1b ff ff ff    	jne    790 <printf+0x20>
}
 875:	83 c4 3c             	add    $0x3c,%esp
 878:	5b                   	pop    %ebx
 879:	5e                   	pop    %esi
 87a:	5f                   	pop    %edi
 87b:	5d                   	pop    %ebp
 87c:	c3                   	ret
 87d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 880:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 883:	8b 01                	mov    (%ecx),%eax
        ap++;
 885:	83 c1 04             	add    $0x4,%ecx
 888:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 88b:	85 c0                	test   %eax,%eax
 88d:	0f 84 d5 00 00 00    	je     968 <printf+0x1f8>
        while(*s != 0){
 893:	0f b6 10             	movzbl (%eax),%edx
 896:	84 d2                	test   %dl,%dl
 898:	74 39                	je     8d3 <printf+0x163>
 89a:	89 c7                	mov    %eax,%edi
 89c:	88 d0                	mov    %dl,%al
 89e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8a1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 8a4:	89 fb                	mov    %edi,%ebx
 8a6:	89 cf                	mov    %ecx,%edi
 8a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8af:	00 
          putc(fd, *s);
 8b0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8b3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 8b8:	43                   	inc    %ebx
  write(fd, &c, 1);
 8b9:	89 44 24 08          	mov    %eax,0x8(%esp)
 8bd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 8c1:	89 34 24             	mov    %esi,(%esp)
 8c4:	e8 0a fd ff ff       	call   5d3 <write>
        while(*s != 0){
 8c9:	0f b6 03             	movzbl (%ebx),%eax
 8cc:	84 c0                	test   %al,%al
 8ce:	75 e0                	jne    8b0 <printf+0x140>
 8d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 8d3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 8d7:	83 c3 02             	add    $0x2,%ebx
 8da:	84 d2                	test   %dl,%dl
 8dc:	0f 85 ae fe ff ff    	jne    790 <printf+0x20>
 8e2:	e9 d5 fe ff ff       	jmp    7bc <printf+0x4c>
 8e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8ee:	00 
 8ef:	90                   	nop
        printint(fd, *ap, 10, 1);
 8f0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 8f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8f8:	8b 17                	mov    (%edi),%edx
 8fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 901:	e9 53 ff ff ff       	jmp    859 <printf+0xe9>
 906:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 90d:	00 
 90e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 910:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 913:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 918:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 91b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 91d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 921:	8d 7d e7             	lea    -0x19(%ebp),%edi
 924:	89 7c 24 04          	mov    %edi,0x4(%esp)
 928:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 92b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 92e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 932:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 935:	e8 99 fc ff ff       	call   5d3 <write>
        ap++;
 93a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 93e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 942:	84 d2                	test   %dl,%dl
 944:	0f 85 46 fe ff ff    	jne    790 <printf+0x20>
 94a:	e9 6d fe ff ff       	jmp    7bc <printf+0x4c>
 94f:	90                   	nop
        putc(fd, c);
 950:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 953:	8d 7d e7             	lea    -0x19(%ebp),%edi
 956:	b9 01 00 00 00       	mov    $0x1,%ecx
 95b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 95f:	e9 bb fe ff ff       	jmp    81f <printf+0xaf>
 964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 968:	bf 62 0b 00 00       	mov    $0xb62,%edi
 96d:	b0 28                	mov    $0x28,%al
 96f:	e9 2a ff ff ff       	jmp    89e <printf+0x12e>
 974:	66 90                	xchg   %ax,%ax
 976:	66 90                	xchg   %ax,%ax
 978:	66 90                	xchg   %ax,%ax
 97a:	66 90                	xchg   %ax,%ax
 97c:	66 90                	xchg   %ax,%ax
 97e:	66 90                	xchg   %ax,%ax

00000980 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 980:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 981:	a1 e8 0b 00 00       	mov    0xbe8,%eax
{
 986:	89 e5                	mov    %esp,%ebp
 988:	57                   	push   %edi
 989:	56                   	push   %esi
 98a:	53                   	push   %ebx
 98b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 98e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 991:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 998:	00 
 999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9a0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a4:	39 ca                	cmp    %ecx,%edx
 9a6:	73 30                	jae    9d8 <free+0x58>
 9a8:	39 c1                	cmp    %eax,%ecx
 9aa:	72 04                	jb     9b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ac:	39 c2                	cmp    %eax,%edx
 9ae:	72 f0                	jb     9a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9b6:	39 f8                	cmp    %edi,%eax
 9b8:	74 36                	je     9f0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 9ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9bd:	8b 42 04             	mov    0x4(%edx),%eax
 9c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 9c3:	39 f1                	cmp    %esi,%ecx
 9c5:	74 42                	je     a09 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 9c7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 9c9:	5b                   	pop    %ebx
  freep = p;
 9ca:	89 15 e8 0b 00 00    	mov    %edx,0xbe8
}
 9d0:	5e                   	pop    %esi
 9d1:	5f                   	pop    %edi
 9d2:	5d                   	pop    %ebp
 9d3:	c3                   	ret
 9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d8:	39 c2                	cmp    %eax,%edx
 9da:	72 c4                	jb     9a0 <free+0x20>
 9dc:	39 c1                	cmp    %eax,%ecx
 9de:	73 c0                	jae    9a0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 9e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9e6:	39 f8                	cmp    %edi,%eax
 9e8:	75 d0                	jne    9ba <free+0x3a>
 9ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 9f0:	8b 78 04             	mov    0x4(%eax),%edi
 9f3:	01 fe                	add    %edi,%esi
 9f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f8:	8b 02                	mov    (%edx),%eax
 9fa:	8b 00                	mov    (%eax),%eax
 9fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 9ff:	8b 42 04             	mov    0x4(%edx),%eax
 a02:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a05:	39 f1                	cmp    %esi,%ecx
 a07:	75 be                	jne    9c7 <free+0x47>
  freep = p;
 a09:	89 15 e8 0b 00 00    	mov    %edx,0xbe8
    p->s.size += bp->s.size;
 a0f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 a12:	01 c8                	add    %ecx,%eax
 a14:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a17:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 a1a:	89 0a                	mov    %ecx,(%edx)
}
 a1c:	5b                   	pop    %ebx
 a1d:	5e                   	pop    %esi
 a1e:	5f                   	pop    %edi
 a1f:	5d                   	pop    %ebp
 a20:	c3                   	ret
 a21:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a28:	00 
 a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a30 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	57                   	push   %edi
 a34:	56                   	push   %esi
 a35:	53                   	push   %ebx
 a36:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a39:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a3c:	8b 15 e8 0b 00 00    	mov    0xbe8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a42:	8d 78 07             	lea    0x7(%eax),%edi
 a45:	c1 ef 03             	shr    $0x3,%edi
 a48:	47                   	inc    %edi
  if((prevp = freep) == 0){
 a49:	85 d2                	test   %edx,%edx
 a4b:	0f 84 8f 00 00 00    	je     ae0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a51:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a53:	8b 48 04             	mov    0x4(%eax),%ecx
 a56:	39 f9                	cmp    %edi,%ecx
 a58:	73 5e                	jae    ab8 <malloc+0x88>
  if(nu < 4096)
 a5a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a5f:	39 df                	cmp    %ebx,%edi
 a61:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a64:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a6b:	eb 0c                	jmp    a79 <malloc+0x49>
 a6d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a70:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a72:	8b 48 04             	mov    0x4(%eax),%ecx
 a75:	39 f9                	cmp    %edi,%ecx
 a77:	73 3f                	jae    ab8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a79:	39 05 e8 0b 00 00    	cmp    %eax,0xbe8
 a7f:	89 c2                	mov    %eax,%edx
 a81:	75 ed                	jne    a70 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 a83:	89 34 24             	mov    %esi,(%esp)
 a86:	e8 b0 fb ff ff       	call   63b <sbrk>
  if(p == (char*)-1)
 a8b:	83 f8 ff             	cmp    $0xffffffff,%eax
 a8e:	74 18                	je     aa8 <malloc+0x78>
  hp->s.size = nu;
 a90:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a93:	83 c0 08             	add    $0x8,%eax
 a96:	89 04 24             	mov    %eax,(%esp)
 a99:	e8 e2 fe ff ff       	call   980 <free>
  return freep;
 a9e:	8b 15 e8 0b 00 00    	mov    0xbe8,%edx
      if((p = morecore(nunits)) == 0)
 aa4:	85 d2                	test   %edx,%edx
 aa6:	75 c8                	jne    a70 <malloc+0x40>
        return 0;
  }
}
 aa8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 aab:	31 c0                	xor    %eax,%eax
}
 aad:	5b                   	pop    %ebx
 aae:	5e                   	pop    %esi
 aaf:	5f                   	pop    %edi
 ab0:	5d                   	pop    %ebp
 ab1:	c3                   	ret
 ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ab8:	39 cf                	cmp    %ecx,%edi
 aba:	74 54                	je     b10 <malloc+0xe0>
        p->s.size -= nunits;
 abc:	29 f9                	sub    %edi,%ecx
 abe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ac1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ac4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 ac7:	89 15 e8 0b 00 00    	mov    %edx,0xbe8
}
 acd:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 ad0:	83 c0 08             	add    $0x8,%eax
}
 ad3:	5b                   	pop    %ebx
 ad4:	5e                   	pop    %esi
 ad5:	5f                   	pop    %edi
 ad6:	5d                   	pop    %ebp
 ad7:	c3                   	ret
 ad8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 adf:	00 
    base.s.ptr = freep = prevp = &base;
 ae0:	b8 ec 0b 00 00       	mov    $0xbec,%eax
 ae5:	ba ec 0b 00 00       	mov    $0xbec,%edx
 aea:	a3 e8 0b 00 00       	mov    %eax,0xbe8
    base.s.size = 0;
 aef:	31 c9                	xor    %ecx,%ecx
 af1:	b8 ec 0b 00 00       	mov    $0xbec,%eax
    base.s.ptr = freep = prevp = &base;
 af6:	89 15 ec 0b 00 00    	mov    %edx,0xbec
    base.s.size = 0;
 afc:	89 0d f0 0b 00 00    	mov    %ecx,0xbf0
    if(p->s.size >= nunits){
 b02:	e9 53 ff ff ff       	jmp    a5a <malloc+0x2a>
 b07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b0e:	00 
 b0f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 b10:	8b 08                	mov    (%eax),%ecx
 b12:	89 0a                	mov    %ecx,(%edx)
 b14:	eb b1                	jmp    ac7 <malloc+0x97>
