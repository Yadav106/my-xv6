
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 20             	sub    $0x20,%esp
  int fd, i;
  char *pattern;

  if(argc <= 1){
   c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
{
  10:	8b 55 0c             	mov    0xc(%ebp),%edx
  if(argc <= 1){
  13:	7e 78                	jle    8d <main+0x8d>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
  15:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
  pattern = argv[1];
  19:	8b 7a 04             	mov    0x4(%edx),%edi
  if(argc <= 2){
  1c:	0f 84 84 00 00 00    	je     a6 <main+0xa6>
  22:	8d 72 08             	lea    0x8(%edx),%esi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  25:	bb 02 00 00 00       	mov    $0x2,%ebx
  2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if((fd = open(argv[i], 0)) < 0){
  30:	31 c0                	xor    %eax,%eax
  32:	89 44 24 04          	mov    %eax,0x4(%esp)
  36:	8b 06                	mov    (%esi),%eax
  38:	89 04 24             	mov    %eax,(%esp)
  3b:	e8 c3 05 00 00       	call   603 <open>
  40:	85 c0                	test   %eax,%eax
  42:	78 2a                	js     6e <main+0x6e>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  44:	89 44 24 04          	mov    %eax,0x4(%esp)
  for(i = 2; i < argc; i++){
  48:	43                   	inc    %ebx
  49:	83 c6 04             	add    $0x4,%esi
    grep(pattern, fd);
  4c:	89 3c 24             	mov    %edi,(%esp)
  4f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  53:	e8 88 01 00 00       	call   1e0 <grep>
    close(fd);
  58:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5c:	89 04 24             	mov    %eax,(%esp)
  5f:	e8 87 05 00 00       	call   5eb <close>
  for(i = 2; i < argc; i++){
  64:	39 5d 08             	cmp    %ebx,0x8(%ebp)
  67:	7f c7                	jg     30 <main+0x30>
  }
  exit();
  69:	e8 55 05 00 00       	call   5c3 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
  6e:	8b 06                	mov    (%esi),%eax
  70:	c7 44 24 04 48 0b 00 	movl   $0xb48,0x4(%esp)
  77:	00 
  78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7f:	89 44 24 08          	mov    %eax,0x8(%esp)
  83:	e8 f8 06 00 00       	call   780 <printf>
      exit();
  88:	e8 36 05 00 00       	call   5c3 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  8d:	c7 44 24 04 28 0b 00 	movl   $0xb28,0x4(%esp)
  94:	00 
  95:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  9c:	e8 df 06 00 00       	call   780 <printf>
    exit();
  a1:	e8 1d 05 00 00       	call   5c3 <exit>
    grep(pattern, 0);
  a6:	89 3c 24             	mov    %edi,(%esp)
  a9:	31 d2                	xor    %edx,%edx
  ab:	89 54 24 04          	mov    %edx,0x4(%esp)
  af:	e8 2c 01 00 00       	call   1e0 <grep>
    exit();
  b4:	e8 0a 05 00 00       	call   5c3 <exit>
  b9:	66 90                	xchg   %ax,%ax
  bb:	66 90                	xchg   %ax,%ax
  bd:	66 90                	xchg   %ax,%ax
  bf:	90                   	nop

000000c0 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 2c             	sub    $0x2c,%esp
  c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '\0')
  cf:	0f b6 13             	movzbl (%ebx),%edx
  d2:	84 d2                	test   %dl,%dl
  d4:	0f 84 8e 00 00 00    	je     168 <matchhere+0xa8>
    return 1;
  if(re[1] == '*')
  da:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
  de:	3c 2a                	cmp    $0x2a,%al
  e0:	74 33                	je     115 <matchhere+0x55>
  e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  e9:	00 
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
  f0:	80 fa 24             	cmp    $0x24,%dl
    return *text == '\0';
  f3:	0f b6 0e             	movzbl (%esi),%ecx
  if(re[0] == '$' && re[1] == '\0')
  f6:	74 58                	je     150 <matchhere+0x90>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  f8:	84 c9                	test   %cl,%cl
  fa:	74 7c                	je     178 <matchhere+0xb8>
  fc:	80 fa 2e             	cmp    $0x2e,%dl
  ff:	74 04                	je     105 <matchhere+0x45>
 101:	38 d1                	cmp    %dl,%cl
 103:	75 73                	jne    178 <matchhere+0xb8>
    return matchhere(re+1, text+1);
 105:	46                   	inc    %esi
 106:	43                   	inc    %ebx
  if(re[0] == '\0')
 107:	84 c0                	test   %al,%al
 109:	74 5d                	je     168 <matchhere+0xa8>
{
 10b:	88 c2                	mov    %al,%dl
  if(re[1] == '*')
 10d:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 111:	3c 2a                	cmp    $0x2a,%al
 113:	75 db                	jne    f0 <matchhere+0x30>
    return matchstar(re[0], re+2, text);
 115:	8d 7b 02             	lea    0x2(%ebx),%edi
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
 118:	80 fa 2e             	cmp    $0x2e,%dl
 11b:	0f 94 c3             	sete   %bl
 11e:	66 90                	xchg   %ax,%ax
    if(matchhere(re, text))
 120:	89 74 24 04          	mov    %esi,0x4(%esp)
 124:	89 3c 24             	mov    %edi,(%esp)
 127:	88 55 e7             	mov    %dl,-0x19(%ebp)
 12a:	e8 91 ff ff ff       	call   c0 <matchhere>
 12f:	85 c0                	test   %eax,%eax
 131:	75 3a                	jne    16d <matchhere+0xad>
  }while(*text!='\0' && (*text++==c || c=='.'));
 133:	0f b6 0e             	movzbl (%esi),%ecx
 136:	84 c9                	test   %cl,%cl
 138:	74 33                	je     16d <matchhere+0xad>
 13a:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
 13e:	46                   	inc    %esi
 13f:	38 d1                	cmp    %dl,%cl
 141:	74 dd                	je     120 <matchhere+0x60>
 143:	84 db                	test   %bl,%bl
 145:	75 d9                	jne    120 <matchhere+0x60>
 147:	eb 24                	jmp    16d <matchhere+0xad>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(re[0] == '$' && re[1] == '\0')
 150:	84 c0                	test   %al,%al
 152:	74 2e                	je     182 <matchhere+0xc2>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 154:	84 c9                	test   %cl,%cl
 156:	74 20                	je     178 <matchhere+0xb8>
 158:	80 f9 24             	cmp    $0x24,%cl
 15b:	75 1b                	jne    178 <matchhere+0xb8>
    return matchhere(re+1, text+1);
 15d:	46                   	inc    %esi
 15e:	43                   	inc    %ebx
{
 15f:	88 c2                	mov    %al,%dl
 161:	eb aa                	jmp    10d <matchhere+0x4d>
 163:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return 1;
 168:	b8 01 00 00 00       	mov    $0x1,%eax
}
 16d:	83 c4 2c             	add    $0x2c,%esp
 170:	5b                   	pop    %ebx
 171:	5e                   	pop    %esi
 172:	5f                   	pop    %edi
 173:	5d                   	pop    %ebp
 174:	c3                   	ret
 175:	8d 76 00             	lea    0x0(%esi),%esi
 178:	83 c4 2c             	add    $0x2c,%esp
  return 0;
 17b:	31 c0                	xor    %eax,%eax
}
 17d:	5b                   	pop    %ebx
 17e:	5e                   	pop    %esi
 17f:	5f                   	pop    %edi
 180:	5d                   	pop    %ebp
 181:	c3                   	ret
    return *text == '\0';
 182:	31 c0                	xor    %eax,%eax
 184:	84 c9                	test   %cl,%cl
 186:	0f 94 c0             	sete   %al
 189:	eb e2                	jmp    16d <matchhere+0xad>
 18b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000190 <match>:
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	56                   	push   %esi
 194:	53                   	push   %ebx
 195:	83 ec 10             	sub    $0x10,%esp
 198:	8b 5d 08             	mov    0x8(%ebp),%ebx
 19b:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
 19e:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 1a1:	75 0c                	jne    1af <match+0x1f>
 1a3:	eb 2b                	jmp    1d0 <match+0x40>
 1a5:	8d 76 00             	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1a8:	46                   	inc    %esi
 1a9:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 1ad:	74 10                	je     1bf <match+0x2f>
    if(matchhere(re, text))
 1af:	89 74 24 04          	mov    %esi,0x4(%esp)
 1b3:	89 1c 24             	mov    %ebx,(%esp)
 1b6:	e8 05 ff ff ff       	call   c0 <matchhere>
 1bb:	85 c0                	test   %eax,%eax
 1bd:	74 e9                	je     1a8 <match+0x18>
}
 1bf:	83 c4 10             	add    $0x10,%esp
 1c2:	5b                   	pop    %ebx
 1c3:	5e                   	pop    %esi
 1c4:	5d                   	pop    %ebp
 1c5:	c3                   	ret
 1c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cd:	00 
 1ce:	66 90                	xchg   %ax,%ax
    return matchhere(re+1, text);
 1d0:	43                   	inc    %ebx
 1d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 1d4:	83 c4 10             	add    $0x10,%esp
 1d7:	5b                   	pop    %ebx
 1d8:	5e                   	pop    %esi
 1d9:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 1da:	e9 e1 fe ff ff       	jmp    c0 <matchhere>
 1df:	90                   	nop

000001e0 <grep>:
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
  m = 0;
 1e4:	31 ff                	xor    %edi,%edi
{
 1e6:	56                   	push   %esi
 1e7:	53                   	push   %ebx
 1e8:	83 ec 2c             	sub    $0x2c,%esp
 1eb:	89 7d e0             	mov    %edi,-0x20(%ebp)
 1ee:	8b 75 08             	mov    0x8(%ebp),%esi
    return matchhere(re+1, text);
 1f1:	8d 46 01             	lea    0x1(%esi),%eax
 1f4:	89 45 dc             	mov    %eax,-0x24(%ebp)
 1f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1fe:	00 
 1ff:	90                   	nop
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 200:	8b 55 e0             	mov    -0x20(%ebp),%edx
 203:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 208:	29 d0                	sub    %edx,%eax
 20a:	89 44 24 08          	mov    %eax,0x8(%esp)
 20e:	8d 82 e0 0b 00 00    	lea    0xbe0(%edx),%eax
 214:	89 44 24 04          	mov    %eax,0x4(%esp)
 218:	8b 45 0c             	mov    0xc(%ebp),%eax
 21b:	89 04 24             	mov    %eax,(%esp)
 21e:	e8 b8 03 00 00       	call   5db <read>
 223:	85 c0                	test   %eax,%eax
 225:	0f 8e fa 00 00 00    	jle    325 <grep+0x145>
    m += n;
 22b:	01 45 e0             	add    %eax,-0x20(%ebp)
 22e:	bb e0 0b 00 00       	mov    $0xbe0,%ebx
 233:	8b 55 e0             	mov    -0x20(%ebp),%edx
    buf[m] = '\0';
 236:	c6 82 e0 0b 00 00 00 	movb   $0x0,0xbe0(%edx)
    while((q = strchr(p, '\n')) != 0){
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	89 1c 24             	mov    %ebx,(%esp)
 243:	ba 0a 00 00 00       	mov    $0xa,%edx
 248:	89 54 24 04          	mov    %edx,0x4(%esp)
 24c:	e8 ff 01 00 00       	call   450 <strchr>
 251:	85 c0                	test   %eax,%eax
 253:	89 c1                	mov    %eax,%ecx
 255:	0f 84 85 00 00 00    	je     2e0 <grep+0x100>
      *q = 0;
 25b:	c6 01 00             	movb   $0x0,(%ecx)
  if(re[0] == '^')
 25e:	80 3e 5e             	cmpb   $0x5e,(%esi)
 261:	74 55                	je     2b8 <grep+0xd8>
 263:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
 266:	89 cf                	mov    %ecx,%edi
 268:	eb 0d                	jmp    277 <grep+0x97>
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 270:	43                   	inc    %ebx
 271:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 275:	74 39                	je     2b0 <grep+0xd0>
    if(matchhere(re, text))
 277:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 27b:	89 34 24             	mov    %esi,(%esp)
 27e:	e8 3d fe ff ff       	call   c0 <matchhere>
 283:	85 c0                	test   %eax,%eax
 285:	74 e9                	je     270 <grep+0x90>
        write(1, p, q+1 - p);
 287:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
 28a:	89 f9                	mov    %edi,%ecx
 28c:	8d 7f 01             	lea    0x1(%edi),%edi
        *q = '\n';
 28f:	c6 01 0a             	movb   $0xa,(%ecx)
        write(1, p, q+1 - p);
 292:	89 f8                	mov    %edi,%eax
 294:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 298:	29 d8                	sub    %ebx,%eax
 29a:	89 fb                	mov    %edi,%ebx
 29c:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2a7:	e8 37 03 00 00       	call   5e3 <write>
 2ac:	eb 92                	jmp    240 <grep+0x60>
 2ae:	66 90                	xchg   %ax,%ax
 2b0:	8d 5f 01             	lea    0x1(%edi),%ebx
      p = q+1;
 2b3:	eb 8b                	jmp    240 <grep+0x60>
 2b5:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
 2b8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2bc:	8b 45 dc             	mov    -0x24(%ebp),%eax
 2bf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 2c2:	89 04 24             	mov    %eax,(%esp)
 2c5:	e8 f6 fd ff ff       	call   c0 <matchhere>
        write(1, p, q+1 - p);
 2ca:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 2cd:	8d 79 01             	lea    0x1(%ecx),%edi
      if(match(pattern, p)){
 2d0:	85 c0                	test   %eax,%eax
 2d2:	75 bb                	jne    28f <grep+0xaf>
        write(1, p, q+1 - p);
 2d4:	89 fb                	mov    %edi,%ebx
 2d6:	e9 65 ff ff ff       	jmp    240 <grep+0x60>
 2db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p == buf)
 2e0:	81 fb e0 0b 00 00    	cmp    $0xbe0,%ebx
 2e6:	74 31                	je     319 <grep+0x139>
    if(m > 0){
 2e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 2eb:	85 c0                	test   %eax,%eax
 2ed:	0f 8e 0d ff ff ff    	jle    200 <grep+0x20>
      memmove(buf, p, m);
 2f3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      m -= p - buf;
 2f7:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2f9:	c7 04 24 e0 0b 00 00 	movl   $0xbe0,(%esp)
      m -= p - buf;
 300:	2d e0 0b 00 00       	sub    $0xbe0,%eax
 305:	29 45 e0             	sub    %eax,-0x20(%ebp)
 308:	8b 7d e0             	mov    -0x20(%ebp),%edi
      memmove(buf, p, m);
 30b:	89 7c 24 08          	mov    %edi,0x8(%esp)
 30f:	e8 7c 02 00 00       	call   590 <memmove>
 314:	e9 e7 fe ff ff       	jmp    200 <grep+0x20>
      m = 0;
 319:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 320:	e9 db fe ff ff       	jmp    200 <grep+0x20>
}
 325:	83 c4 2c             	add    $0x2c,%esp
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	5f                   	pop    %edi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret
 32d:	8d 76 00             	lea    0x0(%esi),%esi

00000330 <matchstar>:
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
 336:	83 ec 2c             	sub    $0x2c,%esp
 339:	8b 75 08             	mov    0x8(%ebp),%esi
 33c:	8b 7d 0c             	mov    0xc(%ebp),%edi
 33f:	8b 5d 10             	mov    0x10(%ebp),%ebx
  }while(*text!='\0' && (*text++==c || c=='.'));
 342:	83 fe 2e             	cmp    $0x2e,%esi
 345:	0f 94 45 e7          	sete   -0x19(%ebp)
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(matchhere(re, text))
 350:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 354:	89 3c 24             	mov    %edi,(%esp)
 357:	e8 64 fd ff ff       	call   c0 <matchhere>
 35c:	85 c0                	test   %eax,%eax
 35e:	89 c1                	mov    %eax,%ecx
 360:	75 12                	jne    374 <matchstar+0x44>
  }while(*text!='\0' && (*text++==c || c=='.'));
 362:	0f be 03             	movsbl (%ebx),%eax
 365:	84 c0                	test   %al,%al
 367:	74 0b                	je     374 <matchstar+0x44>
 369:	43                   	inc    %ebx
 36a:	39 f0                	cmp    %esi,%eax
 36c:	74 e2                	je     350 <matchstar+0x20>
 36e:	80 7d e7 00          	cmpb   $0x0,-0x19(%ebp)
 372:	75 dc                	jne    350 <matchstar+0x20>
}
 374:	83 c4 2c             	add    $0x2c,%esp
 377:	89 c8                	mov    %ecx,%eax
 379:	5b                   	pop    %ebx
 37a:	5e                   	pop    %esi
 37b:	5f                   	pop    %edi
 37c:	5d                   	pop    %ebp
 37d:	c3                   	ret
 37e:	66 90                	xchg   %ax,%ax

00000380 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 380:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 381:	31 c0                	xor    %eax,%eax
{
 383:	89 e5                	mov    %esp,%ebp
 385:	53                   	push   %ebx
 386:	8b 4d 08             	mov    0x8(%ebp),%ecx
 389:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 390:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 394:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 397:	40                   	inc    %eax
 398:	84 d2                	test   %dl,%dl
 39a:	75 f4                	jne    390 <strcpy+0x10>
    ;
  return os;
}
 39c:	5b                   	pop    %ebx
 39d:	89 c8                	mov    %ecx,%eax
 39f:	5d                   	pop    %ebp
 3a0:	c3                   	ret
 3a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3a8:	00 
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 55 08             	mov    0x8(%ebp),%edx
 3b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 3ba:	0f b6 02             	movzbl (%edx),%eax
 3bd:	84 c0                	test   %al,%al
 3bf:	75 15                	jne    3d6 <strcmp+0x26>
 3c1:	eb 30                	jmp    3f3 <strcmp+0x43>
 3c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 3c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 3cc:	8d 4b 01             	lea    0x1(%ebx),%ecx
 3cf:	42                   	inc    %edx
  while(*p && *p == *q)
 3d0:	84 c0                	test   %al,%al
 3d2:	74 14                	je     3e8 <strcmp+0x38>
 3d4:	89 cb                	mov    %ecx,%ebx
 3d6:	0f b6 0b             	movzbl (%ebx),%ecx
 3d9:	38 c1                	cmp    %al,%cl
 3db:	74 eb                	je     3c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
 3dd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 3de:	29 c8                	sub    %ecx,%eax
}
 3e0:	5d                   	pop    %ebp
 3e1:	c3                   	ret
 3e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 3e8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 3ec:	31 c0                	xor    %eax,%eax
}
 3ee:	5b                   	pop    %ebx
 3ef:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
 3f0:	29 c8                	sub    %ecx,%eax
}
 3f2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 3f3:	0f b6 0b             	movzbl (%ebx),%ecx
 3f6:	31 c0                	xor    %eax,%eax
 3f8:	eb e3                	jmp    3dd <strcmp+0x2d>
 3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <strlen>:

uint
strlen(const char *s)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 406:	80 3a 00             	cmpb   $0x0,(%edx)
 409:	74 15                	je     420 <strlen+0x20>
 40b:	31 c0                	xor    %eax,%eax
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	40                   	inc    %eax
 411:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 415:	89 c1                	mov    %eax,%ecx
 417:	75 f7                	jne    410 <strlen+0x10>
    ;
  return n;
}
 419:	5d                   	pop    %ebp
 41a:	89 c8                	mov    %ecx,%eax
 41c:	c3                   	ret
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 421:	31 c9                	xor    %ecx,%ecx
}
 423:	89 c8                	mov    %ecx,%eax
 425:	c3                   	ret
 426:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 42d:	00 
 42e:	66 90                	xchg   %ax,%ax

00000430 <memset>:

void*
memset(void *dst, int c, uint n)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 55 08             	mov    0x8(%ebp),%edx
 436:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 437:	8b 4d 10             	mov    0x10(%ebp),%ecx
 43a:	8b 45 0c             	mov    0xc(%ebp),%eax
 43d:	89 d7                	mov    %edx,%edi
 43f:	fc                   	cld
 440:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 442:	5f                   	pop    %edi
 443:	89 d0                	mov    %edx,%eax
 445:	5d                   	pop    %ebp
 446:	c3                   	ret
 447:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 44e:	00 
 44f:	90                   	nop

00000450 <strchr>:

char*
strchr(const char *s, char c)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	8b 45 08             	mov    0x8(%ebp),%eax
 456:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 45a:	0f b6 10             	movzbl (%eax),%edx
 45d:	84 d2                	test   %dl,%dl
 45f:	75 10                	jne    471 <strchr+0x21>
 461:	eb 1d                	jmp    480 <strchr+0x30>
 463:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 468:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 46c:	40                   	inc    %eax
 46d:	84 d2                	test   %dl,%dl
 46f:	74 0f                	je     480 <strchr+0x30>
    if(*s == c)
 471:	38 d1                	cmp    %dl,%cl
 473:	75 f3                	jne    468 <strchr+0x18>
      return (char*)s;
  return 0;
}
 475:	5d                   	pop    %ebp
 476:	c3                   	ret
 477:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47e:	00 
 47f:	90                   	nop
 480:	5d                   	pop    %ebp
  return 0;
 481:	31 c0                	xor    %eax,%eax
}
 483:	c3                   	ret
 484:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 48b:	00 
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000490 <gets>:

char*
gets(char *buf, int max)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 495:	31 f6                	xor    %esi,%esi
{
 497:	53                   	push   %ebx
    cc = read(0, &c, 1);
 498:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 49b:	83 ec 3c             	sub    $0x3c,%esp
 49e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
 4a1:	eb 32                	jmp    4d5 <gets+0x45>
 4a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 4a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4ac:	b8 01 00 00 00       	mov    $0x1,%eax
 4b1:	89 44 24 08          	mov    %eax,0x8(%esp)
 4b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4bc:	e8 1a 01 00 00       	call   5db <read>
    if(cc < 1)
 4c1:	85 c0                	test   %eax,%eax
 4c3:	7e 19                	jle    4de <gets+0x4e>
      break;
    buf[i++] = c;
 4c5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4c9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
 4cd:	3c 0a                	cmp    $0xa,%al
 4cf:	74 10                	je     4e1 <gets+0x51>
 4d1:	3c 0d                	cmp    $0xd,%al
 4d3:	74 0c                	je     4e1 <gets+0x51>
  for(i=0; i+1 < max; ){
 4d5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4d8:	46                   	inc    %esi
 4d9:	3b 75 0c             	cmp    0xc(%ebp),%esi
 4dc:	7c ca                	jl     4a8 <gets+0x18>
 4de:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
 4e1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
 4e5:	83 c4 3c             	add    $0x3c,%esp
 4e8:	89 d8                	mov    %ebx,%eax
 4ea:	5b                   	pop    %ebx
 4eb:	5e                   	pop    %esi
 4ec:	5f                   	pop    %edi
 4ed:	5d                   	pop    %ebp
 4ee:	c3                   	ret
 4ef:	90                   	nop

000004f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4f0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4f1:	31 c0                	xor    %eax,%eax
{
 4f3:	89 e5                	mov    %esp,%ebp
 4f5:	83 ec 18             	sub    $0x18,%esp
 4f8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4fb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 4fe:	89 44 24 04          	mov    %eax,0x4(%esp)
 502:	8b 45 08             	mov    0x8(%ebp),%eax
 505:	89 04 24             	mov    %eax,(%esp)
 508:	e8 f6 00 00 00       	call   603 <open>
  if(fd < 0)
 50d:	85 c0                	test   %eax,%eax
 50f:	78 2f                	js     540 <stat+0x50>
 511:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 513:	8b 45 0c             	mov    0xc(%ebp),%eax
 516:	89 1c 24             	mov    %ebx,(%esp)
 519:	89 44 24 04          	mov    %eax,0x4(%esp)
 51d:	e8 f9 00 00 00       	call   61b <fstat>
  close(fd);
 522:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 525:	89 c6                	mov    %eax,%esi
  close(fd);
 527:	e8 bf 00 00 00       	call   5eb <close>
  return r;
}
 52c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 52f:	89 f0                	mov    %esi,%eax
 531:	8b 75 fc             	mov    -0x4(%ebp),%esi
 534:	89 ec                	mov    %ebp,%esp
 536:	5d                   	pop    %ebp
 537:	c3                   	ret
 538:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53f:	00 
    return -1;
 540:	be ff ff ff ff       	mov    $0xffffffff,%esi
 545:	eb e5                	jmp    52c <stat+0x3c>
 547:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 54e:	00 
 54f:	90                   	nop

00000550 <atoi>:

int
atoi(const char *s)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	53                   	push   %ebx
 554:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 557:	0f be 02             	movsbl (%edx),%eax
 55a:	88 c1                	mov    %al,%cl
 55c:	80 e9 30             	sub    $0x30,%cl
 55f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 562:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 567:	77 1c                	ja     585 <atoi+0x35>
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 570:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 573:	42                   	inc    %edx
 574:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 578:	0f be 02             	movsbl (%edx),%eax
 57b:	88 c3                	mov    %al,%bl
 57d:	80 eb 30             	sub    $0x30,%bl
 580:	80 fb 09             	cmp    $0x9,%bl
 583:	76 eb                	jbe    570 <atoi+0x20>
  return n;
}
 585:	5b                   	pop    %ebx
 586:	89 c8                	mov    %ecx,%eax
 588:	5d                   	pop    %ebp
 589:	c3                   	ret
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000590 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	8b 45 10             	mov    0x10(%ebp),%eax
 597:	56                   	push   %esi
 598:	8b 55 08             	mov    0x8(%ebp),%edx
 59b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 59e:	85 c0                	test   %eax,%eax
 5a0:	7e 13                	jle    5b5 <memmove+0x25>
 5a2:	01 d0                	add    %edx,%eax
  dst = vdst;
 5a4:	89 d7                	mov    %edx,%edi
 5a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ad:	00 
 5ae:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 5b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5b1:	39 f8                	cmp    %edi,%eax
 5b3:	75 fb                	jne    5b0 <memmove+0x20>
  return vdst;
}
 5b5:	5e                   	pop    %esi
 5b6:	89 d0                	mov    %edx,%eax
 5b8:	5f                   	pop    %edi
 5b9:	5d                   	pop    %ebp
 5ba:	c3                   	ret

000005bb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5bb:	b8 01 00 00 00       	mov    $0x1,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret

000005c3 <exit>:
SYSCALL(exit)
 5c3:	b8 02 00 00 00       	mov    $0x2,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret

000005cb <wait>:
SYSCALL(wait)
 5cb:	b8 03 00 00 00       	mov    $0x3,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret

000005d3 <pipe>:
SYSCALL(pipe)
 5d3:	b8 04 00 00 00       	mov    $0x4,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret

000005db <read>:
SYSCALL(read)
 5db:	b8 05 00 00 00       	mov    $0x5,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret

000005e3 <write>:
SYSCALL(write)
 5e3:	b8 10 00 00 00       	mov    $0x10,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret

000005eb <close>:
SYSCALL(close)
 5eb:	b8 15 00 00 00       	mov    $0x15,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret

000005f3 <kill>:
SYSCALL(kill)
 5f3:	b8 06 00 00 00       	mov    $0x6,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret

000005fb <exec>:
SYSCALL(exec)
 5fb:	b8 07 00 00 00       	mov    $0x7,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret

00000603 <open>:
SYSCALL(open)
 603:	b8 0f 00 00 00       	mov    $0xf,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret

0000060b <mknod>:
SYSCALL(mknod)
 60b:	b8 11 00 00 00       	mov    $0x11,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret

00000613 <unlink>:
SYSCALL(unlink)
 613:	b8 12 00 00 00       	mov    $0x12,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret

0000061b <fstat>:
SYSCALL(fstat)
 61b:	b8 08 00 00 00       	mov    $0x8,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret

00000623 <link>:
SYSCALL(link)
 623:	b8 13 00 00 00       	mov    $0x13,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret

0000062b <mkdir>:
SYSCALL(mkdir)
 62b:	b8 14 00 00 00       	mov    $0x14,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret

00000633 <chdir>:
SYSCALL(chdir)
 633:	b8 09 00 00 00       	mov    $0x9,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret

0000063b <dup>:
SYSCALL(dup)
 63b:	b8 0a 00 00 00       	mov    $0xa,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret

00000643 <getpid>:
SYSCALL(getpid)
 643:	b8 0b 00 00 00       	mov    $0xb,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret

0000064b <sbrk>:
SYSCALL(sbrk)
 64b:	b8 0c 00 00 00       	mov    $0xc,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret

00000653 <sleep>:
SYSCALL(sleep)
 653:	b8 0d 00 00 00       	mov    $0xd,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret

0000065b <uptime>:
SYSCALL(uptime)
 65b:	b8 0e 00 00 00       	mov    $0xe,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret

00000663 <worldpeace>:
SYSCALL(worldpeace)
 663:	b8 16 00 00 00       	mov    $0x16,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret

0000066b <numberofprocesses>:
SYSCALL(numberofprocesses)
 66b:	b8 17 00 00 00       	mov    $0x17,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret

00000673 <whatsthestatus>:
SYSCALL(whatsthestatus)
 673:	b8 18 00 00 00       	mov    $0x18,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret

0000067b <get_sibling>:
SYSCALL(get_sibling)
 67b:	b8 19 00 00 00       	mov    $0x19,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret

00000683 <spawn>:
SYSCALL(spawn)
 683:	b8 1a 00 00 00       	mov    $0x1a,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret

0000068b <getvasize>:
SYSCALL(getvasize)
 68b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret

00000693 <va2pa>:
SYSCALL(va2pa)
 693:	b8 1c 00 00 00       	mov    $0x1c,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret

0000069b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
 69b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret

000006a3 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
 6a3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret

000006ab <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
 6ab:	b8 1f 00 00 00       	mov    $0x1f,%eax
 6b0:	cd 40                	int    $0x40
 6b2:	c3                   	ret

000006b3 <getpasize>:
SYSCALL(getpasize)
 6b3:	b8 20 00 00 00       	mov    $0x20,%eax
 6b8:	cd 40                	int    $0x40
 6ba:	c3                   	ret
 6bb:	66 90                	xchg   %ax,%ax
 6bd:	66 90                	xchg   %ax,%ax
 6bf:	90                   	nop

000006c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	89 cb                	mov    %ecx,%ebx
 6c8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6cb:	89 d1                	mov    %edx,%ecx
{
 6cd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
 6d0:	89 d0                	mov    %edx,%eax
 6d2:	c1 e8 1f             	shr    $0x1f,%eax
 6d5:	84 c0                	test   %al,%al
 6d7:	0f 84 93 00 00 00    	je     770 <printint+0xb0>
 6dd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6e1:	0f 84 89 00 00 00    	je     770 <printint+0xb0>
    x = -xx;
 6e7:	f7 d9                	neg    %ecx
    neg = 1;
 6e9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 6ee:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6f5:	8d 75 d7             	lea    -0x29(%ebp),%esi
 6f8:	89 45 b8             	mov    %eax,-0x48(%ebp)
 6fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 700:	89 c8                	mov    %ecx,%eax
 702:	31 d2                	xor    %edx,%edx
 704:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 707:	f7 f3                	div    %ebx
 709:	89 45 c0             	mov    %eax,-0x40(%ebp)
 70c:	0f b6 92 c0 0b 00 00 	movzbl 0xbc0(%edx),%edx
 713:	8d 47 01             	lea    0x1(%edi),%eax
 716:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 719:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
 71d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
 71f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 722:	39 da                	cmp    %ebx,%edx
 724:	73 da                	jae    700 <printint+0x40>
  if(neg)
 726:	8b 45 b8             	mov    -0x48(%ebp),%eax
 729:	85 c0                	test   %eax,%eax
 72b:	74 0a                	je     737 <printint+0x77>
    buf[i++] = '-';
 72d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 730:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 735:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
 737:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 73a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 73e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
 740:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 743:	89 74 24 04          	mov    %esi,0x4(%esp)
 747:	88 45 d7             	mov    %al,-0x29(%ebp)
 74a:	b8 01 00 00 00       	mov    $0x1,%eax
 74f:	89 44 24 08          	mov    %eax,0x8(%esp)
 753:	8b 45 bc             	mov    -0x44(%ebp),%eax
 756:	89 04 24             	mov    %eax,(%esp)
 759:	e8 85 fe ff ff       	call   5e3 <write>
  while(--i >= 0)
 75e:	89 f8                	mov    %edi,%eax
 760:	4f                   	dec    %edi
 761:	39 d8                	cmp    %ebx,%eax
 763:	75 db                	jne    740 <printint+0x80>
}
 765:	83 c4 4c             	add    $0x4c,%esp
 768:	5b                   	pop    %ebx
 769:	5e                   	pop    %esi
 76a:	5f                   	pop    %edi
 76b:	5d                   	pop    %ebp
 76c:	c3                   	ret
 76d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
 770:	31 c0                	xor    %eax,%eax
 772:	e9 77 ff ff ff       	jmp    6ee <printint+0x2e>
 777:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 77e:	00 
 77f:	90                   	nop

00000780 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 789:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 78c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 78f:	0f b6 13             	movzbl (%ebx),%edx
 792:	43                   	inc    %ebx
 793:	84 d2                	test   %dl,%dl
 795:	74 35                	je     7cc <printf+0x4c>
 797:	8d 45 10             	lea    0x10(%ebp),%eax
 79a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 79d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 7a0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
 7a3:	83 f8 25             	cmp    $0x25,%eax
 7a6:	74 30                	je     7d8 <printf+0x58>
  write(fd, &c, 1);
 7a8:	89 34 24             	mov    %esi,(%esp)
 7ab:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
 7b0:	43                   	inc    %ebx
  write(fd, &c, 1);
 7b1:	89 44 24 08          	mov    %eax,0x8(%esp)
 7b5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 7bc:	88 55 e7             	mov    %dl,-0x19(%ebp)
 7bf:	e8 1f fe ff ff       	call   5e3 <write>
  for(i = 0; fmt[i]; i++){
 7c4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 7c8:	84 d2                	test   %dl,%dl
 7ca:	75 d4                	jne    7a0 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7cc:	83 c4 3c             	add    $0x3c,%esp
 7cf:	5b                   	pop    %ebx
 7d0:	5e                   	pop    %esi
 7d1:	5f                   	pop    %edi
 7d2:	5d                   	pop    %ebp
 7d3:	c3                   	ret
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 7d8:	0f b6 13             	movzbl (%ebx),%edx
 7db:	84 d2                	test   %dl,%dl
 7dd:	74 ed                	je     7cc <printf+0x4c>
    c = fmt[i] & 0xff;
 7df:	80 fa 25             	cmp    $0x25,%dl
 7e2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
 7e5:	0f 84 75 01 00 00    	je     960 <printf+0x1e0>
 7eb:	83 e8 63             	sub    $0x63,%eax
 7ee:	83 f8 15             	cmp    $0x15,%eax
 7f1:	77 0d                	ja     800 <printf+0x80>
 7f3:	ff 24 85 68 0b 00 00 	jmp    *0xb68(,%eax,4)
 7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 800:	89 34 24             	mov    %esi,(%esp)
 803:	8d 7d e7             	lea    -0x19(%ebp),%edi
 806:	b8 01 00 00 00       	mov    $0x1,%eax
 80b:	89 44 24 08          	mov    %eax,0x8(%esp)
 80f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 813:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 816:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 81a:	e8 c4 fd ff ff       	call   5e3 <write>
        putc(fd, c);
 81f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
 823:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 826:	ba 01 00 00 00       	mov    $0x1,%edx
 82b:	89 54 24 08          	mov    %edx,0x8(%esp)
 82f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
 833:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 836:	89 34 24             	mov    %esi,(%esp)
 839:	e8 a5 fd ff ff       	call   5e3 <write>
  for(i = 0; fmt[i]; i++){
 83e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 842:	84 d2                	test   %dl,%dl
 844:	0f 85 56 ff ff ff    	jne    7a0 <printf+0x20>
}
 84a:	83 c4 3c             	add    $0x3c,%esp
 84d:	5b                   	pop    %ebx
 84e:	5e                   	pop    %esi
 84f:	5f                   	pop    %edi
 850:	5d                   	pop    %ebp
 851:	c3                   	ret
 852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 858:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 85b:	b9 10 00 00 00       	mov    $0x10,%ecx
 860:	8b 17                	mov    (%edi),%edx
 862:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
 869:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
 86c:	89 f0                	mov    %esi,%eax
 86e:	e8 4d fe ff ff       	call   6c0 <printint>
  for(i = 0; fmt[i]; i++){
 873:	83 c3 02             	add    $0x2,%ebx
        ap++;
 876:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 879:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 87d:	84 d2                	test   %dl,%dl
 87f:	0f 85 1b ff ff ff    	jne    7a0 <printf+0x20>
}
 885:	83 c4 3c             	add    $0x3c,%esp
 888:	5b                   	pop    %ebx
 889:	5e                   	pop    %esi
 88a:	5f                   	pop    %edi
 88b:	5d                   	pop    %ebp
 88c:	c3                   	ret
 88d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 890:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 893:	8b 01                	mov    (%ecx),%eax
        ap++;
 895:	83 c1 04             	add    $0x4,%ecx
 898:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 89b:	85 c0                	test   %eax,%eax
 89d:	0f 84 d5 00 00 00    	je     978 <printf+0x1f8>
        while(*s != 0){
 8a3:	0f b6 10             	movzbl (%eax),%edx
 8a6:	84 d2                	test   %dl,%dl
 8a8:	74 39                	je     8e3 <printf+0x163>
 8aa:	89 c7                	mov    %eax,%edi
 8ac:	88 d0                	mov    %dl,%al
 8ae:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8b1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 8b4:	89 fb                	mov    %edi,%ebx
 8b6:	89 cf                	mov    %ecx,%edi
 8b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8bf:	00 
          putc(fd, *s);
 8c0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8c3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 8c8:	43                   	inc    %ebx
  write(fd, &c, 1);
 8c9:	89 44 24 08          	mov    %eax,0x8(%esp)
 8cd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 8d1:	89 34 24             	mov    %esi,(%esp)
 8d4:	e8 0a fd ff ff       	call   5e3 <write>
        while(*s != 0){
 8d9:	0f b6 03             	movzbl (%ebx),%eax
 8dc:	84 c0                	test   %al,%al
 8de:	75 e0                	jne    8c0 <printf+0x140>
 8e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 8e3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 8e7:	83 c3 02             	add    $0x2,%ebx
 8ea:	84 d2                	test   %dl,%dl
 8ec:	0f 85 ae fe ff ff    	jne    7a0 <printf+0x20>
 8f2:	e9 d5 fe ff ff       	jmp    7cc <printf+0x4c>
 8f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8fe:	00 
 8ff:	90                   	nop
        printint(fd, *ap, 10, 1);
 900:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 903:	b9 0a 00 00 00       	mov    $0xa,%ecx
 908:	8b 17                	mov    (%edi),%edx
 90a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 911:	e9 53 ff ff ff       	jmp    869 <printf+0xe9>
 916:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 91d:	00 
 91e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 920:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 923:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
 928:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
 92b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
 92d:	89 7c 24 08          	mov    %edi,0x8(%esp)
 931:	8d 7d e7             	lea    -0x19(%ebp),%edi
 934:	89 7c 24 04          	mov    %edi,0x4(%esp)
 938:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 93b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 93e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 942:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 945:	e8 99 fc ff ff       	call   5e3 <write>
        ap++;
 94a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 94e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 952:	84 d2                	test   %dl,%dl
 954:	0f 85 46 fe ff ff    	jne    7a0 <printf+0x20>
 95a:	e9 6d fe ff ff       	jmp    7cc <printf+0x4c>
 95f:	90                   	nop
        putc(fd, c);
 960:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 963:	8d 7d e7             	lea    -0x19(%ebp),%edi
 966:	b9 01 00 00 00       	mov    $0x1,%ecx
 96b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 96f:	e9 bb fe ff ff       	jmp    82f <printf+0xaf>
 974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 978:	bf 5e 0b 00 00       	mov    $0xb5e,%edi
 97d:	b0 28                	mov    $0x28,%al
 97f:	e9 2a ff ff ff       	jmp    8ae <printf+0x12e>
 984:	66 90                	xchg   %ax,%ax
 986:	66 90                	xchg   %ax,%ax
 988:	66 90                	xchg   %ax,%ax
 98a:	66 90                	xchg   %ax,%ax
 98c:	66 90                	xchg   %ax,%ax
 98e:	66 90                	xchg   %ax,%ax

00000990 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 990:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 991:	a1 e0 0f 00 00       	mov    0xfe0,%eax
{
 996:	89 e5                	mov    %esp,%ebp
 998:	57                   	push   %edi
 999:	56                   	push   %esi
 99a:	53                   	push   %ebx
 99b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 99e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9a8:	00 
 9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9b0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b4:	39 ca                	cmp    %ecx,%edx
 9b6:	73 30                	jae    9e8 <free+0x58>
 9b8:	39 c1                	cmp    %eax,%ecx
 9ba:	72 04                	jb     9c0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9bc:	39 c2                	cmp    %eax,%edx
 9be:	72 f0                	jb     9b0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9c6:	39 f8                	cmp    %edi,%eax
 9c8:	74 36                	je     a00 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 9ca:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9cd:	8b 42 04             	mov    0x4(%edx),%eax
 9d0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 9d3:	39 f1                	cmp    %esi,%ecx
 9d5:	74 42                	je     a19 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 9d7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 9d9:	5b                   	pop    %ebx
  freep = p;
 9da:	89 15 e0 0f 00 00    	mov    %edx,0xfe0
}
 9e0:	5e                   	pop    %esi
 9e1:	5f                   	pop    %edi
 9e2:	5d                   	pop    %ebp
 9e3:	c3                   	ret
 9e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9e8:	39 c2                	cmp    %eax,%edx
 9ea:	72 c4                	jb     9b0 <free+0x20>
 9ec:	39 c1                	cmp    %eax,%ecx
 9ee:	73 c0                	jae    9b0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 9f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9f6:	39 f8                	cmp    %edi,%eax
 9f8:	75 d0                	jne    9ca <free+0x3a>
 9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 a00:	8b 78 04             	mov    0x4(%eax),%edi
 a03:	01 fe                	add    %edi,%esi
 a05:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a08:	8b 02                	mov    (%edx),%eax
 a0a:	8b 00                	mov    (%eax),%eax
 a0c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 a0f:	8b 42 04             	mov    0x4(%edx),%eax
 a12:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a15:	39 f1                	cmp    %esi,%ecx
 a17:	75 be                	jne    9d7 <free+0x47>
  freep = p;
 a19:	89 15 e0 0f 00 00    	mov    %edx,0xfe0
    p->s.size += bp->s.size;
 a1f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 a22:	01 c8                	add    %ecx,%eax
 a24:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a27:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 a2a:	89 0a                	mov    %ecx,(%edx)
}
 a2c:	5b                   	pop    %ebx
 a2d:	5e                   	pop    %esi
 a2e:	5f                   	pop    %edi
 a2f:	5d                   	pop    %ebp
 a30:	c3                   	ret
 a31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a38:	00 
 a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a40:	55                   	push   %ebp
 a41:	89 e5                	mov    %esp,%ebp
 a43:	57                   	push   %edi
 a44:	56                   	push   %esi
 a45:	53                   	push   %ebx
 a46:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a49:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a4c:	8b 15 e0 0f 00 00    	mov    0xfe0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a52:	8d 78 07             	lea    0x7(%eax),%edi
 a55:	c1 ef 03             	shr    $0x3,%edi
 a58:	47                   	inc    %edi
  if((prevp = freep) == 0){
 a59:	85 d2                	test   %edx,%edx
 a5b:	0f 84 8f 00 00 00    	je     af0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a61:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a63:	8b 48 04             	mov    0x4(%eax),%ecx
 a66:	39 f9                	cmp    %edi,%ecx
 a68:	73 5e                	jae    ac8 <malloc+0x88>
  if(nu < 4096)
 a6a:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a6f:	39 df                	cmp    %ebx,%edi
 a71:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a74:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a7b:	eb 0c                	jmp    a89 <malloc+0x49>
 a7d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a80:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a82:	8b 48 04             	mov    0x4(%eax),%ecx
 a85:	39 f9                	cmp    %edi,%ecx
 a87:	73 3f                	jae    ac8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a89:	39 05 e0 0f 00 00    	cmp    %eax,0xfe0
 a8f:	89 c2                	mov    %eax,%edx
 a91:	75 ed                	jne    a80 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 a93:	89 34 24             	mov    %esi,(%esp)
 a96:	e8 b0 fb ff ff       	call   64b <sbrk>
  if(p == (char*)-1)
 a9b:	83 f8 ff             	cmp    $0xffffffff,%eax
 a9e:	74 18                	je     ab8 <malloc+0x78>
  hp->s.size = nu;
 aa0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 aa3:	83 c0 08             	add    $0x8,%eax
 aa6:	89 04 24             	mov    %eax,(%esp)
 aa9:	e8 e2 fe ff ff       	call   990 <free>
  return freep;
 aae:	8b 15 e0 0f 00 00    	mov    0xfe0,%edx
      if((p = morecore(nunits)) == 0)
 ab4:	85 d2                	test   %edx,%edx
 ab6:	75 c8                	jne    a80 <malloc+0x40>
        return 0;
  }
}
 ab8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
 abb:	31 c0                	xor    %eax,%eax
}
 abd:	5b                   	pop    %ebx
 abe:	5e                   	pop    %esi
 abf:	5f                   	pop    %edi
 ac0:	5d                   	pop    %ebp
 ac1:	c3                   	ret
 ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ac8:	39 cf                	cmp    %ecx,%edi
 aca:	74 54                	je     b20 <malloc+0xe0>
        p->s.size -= nunits;
 acc:	29 f9                	sub    %edi,%ecx
 ace:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ad1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ad4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 ad7:	89 15 e0 0f 00 00    	mov    %edx,0xfe0
}
 add:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
 ae0:	83 c0 08             	add    $0x8,%eax
}
 ae3:	5b                   	pop    %ebx
 ae4:	5e                   	pop    %esi
 ae5:	5f                   	pop    %edi
 ae6:	5d                   	pop    %ebp
 ae7:	c3                   	ret
 ae8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 aef:	00 
    base.s.ptr = freep = prevp = &base;
 af0:	b8 e4 0f 00 00       	mov    $0xfe4,%eax
 af5:	ba e4 0f 00 00       	mov    $0xfe4,%edx
 afa:	a3 e0 0f 00 00       	mov    %eax,0xfe0
    base.s.size = 0;
 aff:	31 c9                	xor    %ecx,%ecx
 b01:	b8 e4 0f 00 00       	mov    $0xfe4,%eax
    base.s.ptr = freep = prevp = &base;
 b06:	89 15 e4 0f 00 00    	mov    %edx,0xfe4
    base.s.size = 0;
 b0c:	89 0d e8 0f 00 00    	mov    %ecx,0xfe8
    if(p->s.size >= nunits){
 b12:	e9 53 ff ff ff       	jmp    a6a <malloc+0x2a>
 b17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b1e:	00 
 b1f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 b20:	8b 08                	mov    (%eax),%ecx
 b22:	89 0a                	mov    %ecx,(%edx)
 b24:	eb b1                	jmp    ad7 <malloc+0x97>
