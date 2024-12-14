
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0e                	jmp    19 <main+0x19>
       b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f b5 00 00 00    	jg     ce <main+0xce>
  while((fd = open("console", O_RDWR)) >= 0){
      19:	c7 04 24 b9 15 00 00 	movl   $0x15b9,(%esp)
      20:	b8 02 00 00 00       	mov    $0x2,%eax
      25:	89 44 24 04          	mov    %eax,0x4(%esp)
      29:	e8 c5 0f 00 00       	call   ff3 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>
      32:	eb 33                	jmp    67 <main+0x67>
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d a2 16 00 00 20 	cmpb   $0x20,0x16a2
      3f:	0f 84 a7 00 00 00    	je     ec <main+0xec>
      45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
      4c:	00 
      4d:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 56 0f 00 00       	call   fab <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 d6 00 00 00    	je     134 <main+0x134>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	74 76                	je     d8 <main+0xd8>
    wait();
      62:	e8 54 0f 00 00       	call   fbb <wait>
  printf(2, "$ ");
      67:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      6e:	b8 18 15 00 00       	mov    $0x1518,%eax
      73:	89 44 24 04          	mov    %eax,0x4(%esp)
      77:	e8 f4 10 00 00       	call   1170 <printf>
  memset(buf, 0, nbuf);
      7c:	31 c9                	xor    %ecx,%ecx
      7e:	ba 64 00 00 00       	mov    $0x64,%edx
      83:	89 54 24 08          	mov    %edx,0x8(%esp)
      87:	89 4c 24 04          	mov    %ecx,0x4(%esp)
      8b:	c7 04 24 a0 16 00 00 	movl   $0x16a0,(%esp)
      92:	e8 89 0d 00 00       	call   e20 <memset>
  gets(buf, nbuf);
      97:	b8 64 00 00 00       	mov    $0x64,%eax
      9c:	89 44 24 04          	mov    %eax,0x4(%esp)
      a0:	c7 04 24 a0 16 00 00 	movl   $0x16a0,(%esp)
      a7:	e8 d4 0d 00 00       	call   e80 <gets>
  if(buf[0] == 0) // EOF
      ac:	0f b6 05 a0 16 00 00 	movzbl 0x16a0,%eax
      b3:	84 c0                	test   %al,%al
      b5:	74 12                	je     c9 <main+0xc9>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      b7:	3c 63                	cmp    $0x63,%al
      b9:	75 95                	jne    50 <main+0x50>
      bb:	80 3d a1 16 00 00 64 	cmpb   $0x64,0x16a1
      c2:	75 8c                	jne    50 <main+0x50>
      c4:	e9 6f ff ff ff       	jmp    38 <main+0x38>
  exit();
      c9:	e8 e5 0e 00 00       	call   fb3 <exit>
      close(fd);
      ce:	89 04 24             	mov    %eax,(%esp)
      d1:	e8 05 0f 00 00       	call   fdb <close>
      break;
      d6:	eb 8f                	jmp    67 <main+0x67>
      runcmd(parsecmd(buf));
      d8:	c7 04 24 a0 16 00 00 	movl   $0x16a0,(%esp)
      df:	e8 0c 0c 00 00       	call   cf0 <parsecmd>
      e4:	89 04 24             	mov    %eax,(%esp)
      e7:	e8 04 01 00 00       	call   1f0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      ec:	c7 04 24 a0 16 00 00 	movl   $0x16a0,(%esp)
      f3:	e8 f8 0c 00 00       	call   df0 <strlen>
      f8:	c6 80 9f 16 00 00 00 	movb   $0x0,0x169f(%eax)
      if(chdir(buf+3) < 0)
      ff:	c7 04 24 a3 16 00 00 	movl   $0x16a3,(%esp)
     106:	e8 18 0f 00 00       	call   1023 <chdir>
     10b:	85 c0                	test   %eax,%eax
     10d:	0f 89 54 ff ff ff    	jns    67 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
     113:	c7 44 24 08 a3 16 00 	movl   $0x16a3,0x8(%esp)
     11a:	00 
     11b:	c7 44 24 04 c1 15 00 	movl   $0x15c1,0x4(%esp)
     122:	00 
     123:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     12a:	e8 41 10 00 00       	call   1170 <printf>
     12f:	e9 33 ff ff ff       	jmp    67 <main+0x67>
    panic("fork");
     134:	c7 04 24 1b 15 00 00 	movl   $0x151b,(%esp)
     13b:	e8 60 00 00 00       	call   1a0 <panic>

00000140 <getcmd>:
{
     140:	55                   	push   %ebp
  printf(2, "$ ");
     141:	b8 18 15 00 00       	mov    $0x1518,%eax
{
     146:	89 e5                	mov    %esp,%ebp
     148:	83 ec 18             	sub    $0x18,%esp
     14b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     14e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     151:	89 75 fc             	mov    %esi,-0x4(%ebp)
     154:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     157:	89 44 24 04          	mov    %eax,0x4(%esp)
     15b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     162:	e8 09 10 00 00       	call   1170 <printf>
  memset(buf, 0, nbuf);
     167:	31 d2                	xor    %edx,%edx
     169:	89 74 24 08          	mov    %esi,0x8(%esp)
     16d:	89 54 24 04          	mov    %edx,0x4(%esp)
     171:	89 1c 24             	mov    %ebx,(%esp)
     174:	e8 a7 0c 00 00       	call   e20 <memset>
  gets(buf, nbuf);
     179:	89 74 24 04          	mov    %esi,0x4(%esp)
     17d:	89 1c 24             	mov    %ebx,(%esp)
     180:	e8 fb 0c 00 00       	call   e80 <gets>
}
     185:	8b 75 fc             	mov    -0x4(%ebp),%esi
  if(buf[0] == 0) // EOF
     188:	80 3b 01             	cmpb   $0x1,(%ebx)
}
     18b:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  if(buf[0] == 0) // EOF
     18e:	19 c0                	sbb    %eax,%eax
}
     190:	89 ec                	mov    %ebp,%esp
     192:	5d                   	pop    %ebp
     193:	c3                   	ret
     194:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     19b:	00 
     19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <panic>:
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     1a6:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     1ad:	8b 45 08             	mov    0x8(%ebp),%eax
     1b0:	89 44 24 08          	mov    %eax,0x8(%esp)
     1b4:	b8 b5 15 00 00       	mov    $0x15b5,%eax
     1b9:	89 44 24 04          	mov    %eax,0x4(%esp)
     1bd:	e8 ae 0f 00 00       	call   1170 <printf>
  exit();
     1c2:	e8 ec 0d 00 00       	call   fb3 <exit>
     1c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     1ce:	00 
     1cf:	90                   	nop

000001d0 <fork1>:
{
     1d0:	55                   	push   %ebp
     1d1:	89 e5                	mov    %esp,%ebp
     1d3:	83 ec 18             	sub    $0x18,%esp
  pid = fork();
     1d6:	e8 d0 0d 00 00       	call   fab <fork>
  if(pid == -1)
     1db:	83 f8 ff             	cmp    $0xffffffff,%eax
     1de:	74 04                	je     1e4 <fork1+0x14>
  return pid;
}
     1e0:	89 ec                	mov    %ebp,%esp
     1e2:	5d                   	pop    %ebp
     1e3:	c3                   	ret
    panic("fork");
     1e4:	c7 04 24 1b 15 00 00 	movl   $0x151b,(%esp)
     1eb:	e8 b0 ff ff ff       	call   1a0 <panic>

000001f0 <runcmd>:
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	53                   	push   %ebx
     1f4:	83 ec 24             	sub    $0x24,%esp
     1f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1fa:	85 db                	test   %ebx,%ebx
     1fc:	74 43                	je     241 <runcmd+0x51>
  switch(cmd->type){
     1fe:	83 3b 05             	cmpl   $0x5,(%ebx)
     201:	0f 87 fa 00 00 00    	ja     301 <runcmd+0x111>
     207:	8b 03                	mov    (%ebx),%eax
     209:	ff 24 85 d8 15 00 00 	jmp    *0x15d8(,%eax,4)
    if(ecmd->argv[0] == 0)
     210:	8b 43 04             	mov    0x4(%ebx),%eax
     213:	85 c0                	test   %eax,%eax
     215:	74 2a                	je     241 <runcmd+0x51>
    exec(ecmd->argv[0], ecmd->argv);
     217:	89 04 24             	mov    %eax,(%esp)
     21a:	8d 53 04             	lea    0x4(%ebx),%edx
     21d:	89 54 24 04          	mov    %edx,0x4(%esp)
     221:	e8 c5 0d 00 00       	call   feb <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     226:	8b 43 04             	mov    0x4(%ebx),%eax
     229:	c7 44 24 04 27 15 00 	movl   $0x1527,0x4(%esp)
     230:	00 
     231:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     238:	89 44 24 08          	mov    %eax,0x8(%esp)
     23c:	e8 2f 0f 00 00       	call   1170 <printf>
      exit();
     241:	e8 6d 0d 00 00       	call   fb3 <exit>
    if(fork1() == 0)
     246:	e8 85 ff ff ff       	call   1d0 <fork1>
     24b:	85 c0                	test   %eax,%eax
     24d:	8d 76 00             	lea    0x0(%esi),%esi
     250:	75 ef                	jne    241 <runcmd+0x51>
     252:	e9 9f 00 00 00       	jmp    2f6 <runcmd+0x106>
    if(pipe(p) < 0)
     257:	8d 45 f0             	lea    -0x10(%ebp),%eax
     25a:	89 04 24             	mov    %eax,(%esp)
     25d:	e8 61 0d 00 00       	call   fc3 <pipe>
     262:	85 c0                	test   %eax,%eax
     264:	0f 88 c3 00 00 00    	js     32d <runcmd+0x13d>
    if(fork1() == 0){
     26a:	e8 61 ff ff ff       	call   1d0 <fork1>
     26f:	85 c0                	test   %eax,%eax
     271:	0f 84 c2 00 00 00    	je     339 <runcmd+0x149>
    if(fork1() == 0){
     277:	e8 54 ff ff ff       	call   1d0 <fork1>
     27c:	85 c0                	test   %eax,%eax
     27e:	66 90                	xchg   %ax,%ax
     280:	0f 85 eb 00 00 00    	jne    371 <runcmd+0x181>
      close(0);
     286:	31 c0                	xor    %eax,%eax
     288:	89 04 24             	mov    %eax,(%esp)
     28b:	e8 4b 0d 00 00       	call   fdb <close>
      dup(p[0]);
     290:	8b 45 f0             	mov    -0x10(%ebp),%eax
     293:	89 04 24             	mov    %eax,(%esp)
     296:	e8 90 0d 00 00       	call   102b <dup>
      close(p[0]);
     29b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     29e:	89 04 24             	mov    %eax,(%esp)
     2a1:	e8 35 0d 00 00       	call   fdb <close>
      close(p[1]);
     2a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2a9:	89 04 24             	mov    %eax,(%esp)
     2ac:	e8 2a 0d 00 00       	call   fdb <close>
      runcmd(pcmd->right);
     2b1:	8b 43 08             	mov    0x8(%ebx),%eax
     2b4:	89 04 24             	mov    %eax,(%esp)
     2b7:	e8 34 ff ff ff       	call   1f0 <runcmd>
    if(fork1() == 0)
     2bc:	e8 0f ff ff ff       	call   1d0 <fork1>
     2c1:	85 c0                	test   %eax,%eax
     2c3:	74 31                	je     2f6 <runcmd+0x106>
    wait();
     2c5:	e8 f1 0c 00 00       	call   fbb <wait>
    runcmd(lcmd->right);
     2ca:	8b 43 08             	mov    0x8(%ebx),%eax
     2cd:	89 04 24             	mov    %eax,(%esp)
     2d0:	e8 1b ff ff ff       	call   1f0 <runcmd>
    close(rcmd->fd);
     2d5:	8b 43 14             	mov    0x14(%ebx),%eax
     2d8:	89 04 24             	mov    %eax,(%esp)
     2db:	e8 fb 0c 00 00       	call   fdb <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     2e0:	8b 43 10             	mov    0x10(%ebx),%eax
     2e3:	89 44 24 04          	mov    %eax,0x4(%esp)
     2e7:	8b 43 08             	mov    0x8(%ebx),%eax
     2ea:	89 04 24             	mov    %eax,(%esp)
     2ed:	e8 01 0d 00 00       	call   ff3 <open>
     2f2:	85 c0                	test   %eax,%eax
     2f4:	78 17                	js     30d <runcmd+0x11d>
      runcmd(bcmd->cmd);
     2f6:	8b 43 04             	mov    0x4(%ebx),%eax
     2f9:	89 04 24             	mov    %eax,(%esp)
     2fc:	e8 ef fe ff ff       	call   1f0 <runcmd>
    panic("runcmd");
     301:	c7 04 24 20 15 00 00 	movl   $0x1520,(%esp)
     308:	e8 93 fe ff ff       	call   1a0 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     30d:	8b 43 08             	mov    0x8(%ebx),%eax
     310:	c7 44 24 04 37 15 00 	movl   $0x1537,0x4(%esp)
     317:	00 
     318:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     31f:	89 44 24 08          	mov    %eax,0x8(%esp)
     323:	e8 48 0e 00 00       	call   1170 <printf>
     328:	e9 14 ff ff ff       	jmp    241 <runcmd+0x51>
      panic("pipe");
     32d:	c7 04 24 47 15 00 00 	movl   $0x1547,(%esp)
     334:	e8 67 fe ff ff       	call   1a0 <panic>
      close(1);
     339:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     340:	e8 96 0c 00 00       	call   fdb <close>
      dup(p[1]);
     345:	8b 45 f4             	mov    -0xc(%ebp),%eax
     348:	89 04 24             	mov    %eax,(%esp)
     34b:	e8 db 0c 00 00       	call   102b <dup>
      close(p[0]);
     350:	8b 45 f0             	mov    -0x10(%ebp),%eax
     353:	89 04 24             	mov    %eax,(%esp)
     356:	e8 80 0c 00 00       	call   fdb <close>
      close(p[1]);
     35b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     35e:	89 04 24             	mov    %eax,(%esp)
     361:	e8 75 0c 00 00       	call   fdb <close>
      runcmd(pcmd->left);
     366:	8b 43 04             	mov    0x4(%ebx),%eax
     369:	89 04 24             	mov    %eax,(%esp)
     36c:	e8 7f fe ff ff       	call   1f0 <runcmd>
    close(p[0]);
     371:	8b 45 f0             	mov    -0x10(%ebp),%eax
     374:	89 04 24             	mov    %eax,(%esp)
     377:	e8 5f 0c 00 00       	call   fdb <close>
    close(p[1]);
     37c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     37f:	89 04 24             	mov    %eax,(%esp)
     382:	e8 54 0c 00 00       	call   fdb <close>
    wait();
     387:	e8 2f 0c 00 00       	call   fbb <wait>
    wait();
     38c:	e8 2a 0c 00 00       	call   fbb <wait>
    break;
     391:	e9 ab fe ff ff       	jmp    241 <runcmd+0x51>
     396:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     39d:	00 
     39e:	66 90                	xchg   %ax,%ax

000003a0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	83 ec 18             	sub    $0x18,%esp
     3a6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a9:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     3b0:	e8 7b 10 00 00       	call   1430 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3b5:	31 d2                	xor    %edx,%edx
     3b7:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     3bb:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3bd:	b8 54 00 00 00       	mov    $0x54,%eax
     3c2:	89 1c 24             	mov    %ebx,(%esp)
     3c5:	89 44 24 08          	mov    %eax,0x8(%esp)
     3c9:	e8 52 0a 00 00       	call   e20 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     3ce:	89 d8                	mov    %ebx,%eax
  cmd->type = EXEC;
     3d0:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     3d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3d9:	89 ec                	mov    %ebp,%esp
     3db:	5d                   	pop    %ebp
     3dc:	c3                   	ret
     3dd:	8d 76 00             	lea    0x0(%esi),%esi

000003e0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	83 ec 18             	sub    $0x18,%esp
     3e6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3e9:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     3f0:	e8 3b 10 00 00       	call   1430 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3f5:	31 d2                	xor    %edx,%edx
     3f7:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     3fb:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3fd:	b8 18 00 00 00       	mov    $0x18,%eax
     402:	89 1c 24             	mov    %ebx,(%esp)
     405:	89 44 24 08          	mov    %eax,0x8(%esp)
     409:	e8 12 0a 00 00       	call   e20 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     40e:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     411:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     417:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     41a:	8b 45 0c             	mov    0xc(%ebp),%eax
     41d:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     420:	8b 45 10             	mov    0x10(%ebp),%eax
     423:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     426:	8b 45 14             	mov    0x14(%ebp),%eax
     429:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     42c:	8b 45 18             	mov    0x18(%ebp),%eax
     42f:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     432:	89 d8                	mov    %ebx,%eax
     434:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     437:	89 ec                	mov    %ebp,%esp
     439:	5d                   	pop    %ebp
     43a:	c3                   	ret
     43b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000440 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	83 ec 18             	sub    $0x18,%esp
     446:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     449:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     450:	e8 db 0f 00 00       	call   1430 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     455:	31 d2                	xor    %edx,%edx
     457:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     45b:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     45d:	b8 0c 00 00 00       	mov    $0xc,%eax
     462:	89 1c 24             	mov    %ebx,(%esp)
     465:	89 44 24 08          	mov    %eax,0x8(%esp)
     469:	e8 b2 09 00 00       	call   e20 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     46e:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     471:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     477:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     47a:	8b 45 0c             	mov    0xc(%ebp),%eax
     47d:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     480:	89 d8                	mov    %ebx,%eax
     482:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     485:	89 ec                	mov    %ebp,%esp
     487:	5d                   	pop    %ebp
     488:	c3                   	ret
     489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	83 ec 18             	sub    $0x18,%esp
     496:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     499:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     4a0:	e8 8b 0f 00 00       	call   1430 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4a5:	31 d2                	xor    %edx,%edx
     4a7:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     4ab:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4ad:	b8 0c 00 00 00       	mov    $0xc,%eax
     4b2:	89 1c 24             	mov    %ebx,(%esp)
     4b5:	89 44 24 08          	mov    %eax,0x8(%esp)
     4b9:	e8 62 09 00 00       	call   e20 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4be:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     4c1:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     4c7:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4ca:	8b 45 0c             	mov    0xc(%ebp),%eax
     4cd:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4d0:	89 d8                	mov    %ebx,%eax
     4d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4d5:	89 ec                	mov    %ebp,%esp
     4d7:	5d                   	pop    %ebp
     4d8:	c3                   	ret
     4d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004e0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4e0:	55                   	push   %ebp
     4e1:	89 e5                	mov    %esp,%ebp
     4e3:	83 ec 18             	sub    $0x18,%esp
     4e6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4e9:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     4f0:	e8 3b 0f 00 00       	call   1430 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4f5:	31 d2                	xor    %edx,%edx
     4f7:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     4fb:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4fd:	b8 08 00 00 00       	mov    $0x8,%eax
     502:	89 1c 24             	mov    %ebx,(%esp)
     505:	89 44 24 08          	mov    %eax,0x8(%esp)
     509:	e8 12 09 00 00       	call   e20 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     50e:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     511:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     517:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     51a:	89 d8                	mov    %ebx,%eax
     51c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     51f:	89 ec                	mov    %ebp,%esp
     521:	5d                   	pop    %ebp
     522:	c3                   	ret
     523:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     52a:	00 
     52b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000530 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	57                   	push   %edi
     534:	56                   	push   %esi
     535:	53                   	push   %ebx
     536:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;

  s = *ps;
     539:	8b 45 08             	mov    0x8(%ebp),%eax
{
     53c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     53f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     542:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     544:	39 df                	cmp    %ebx,%edi
     546:	72 0d                	jb     555 <gettoken+0x25>
     548:	eb 22                	jmp    56c <gettoken+0x3c>
     54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     550:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     551:	39 fb                	cmp    %edi,%ebx
     553:	74 17                	je     56c <gettoken+0x3c>
     555:	0f be 07             	movsbl (%edi),%eax
     558:	c7 04 24 7c 16 00 00 	movl   $0x167c,(%esp)
     55f:	89 44 24 04          	mov    %eax,0x4(%esp)
     563:	e8 d8 08 00 00       	call   e40 <strchr>
     568:	85 c0                	test   %eax,%eax
     56a:	75 e4                	jne    550 <gettoken+0x20>
  if(q)
     56c:	85 f6                	test   %esi,%esi
     56e:	74 02                	je     572 <gettoken+0x42>
    *q = s;
     570:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     572:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     575:	3c 3c                	cmp    $0x3c,%al
     577:	0f 8f c3 00 00 00    	jg     640 <gettoken+0x110>
     57d:	3c 3a                	cmp    $0x3a,%al
     57f:	7f 5f                	jg     5e0 <gettoken+0xb0>
     581:	84 c0                	test   %al,%al
     583:	75 4b                	jne    5d0 <gettoken+0xa0>
     585:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     587:	8b 4d 14             	mov    0x14(%ebp),%ecx
     58a:	85 c9                	test   %ecx,%ecx
     58c:	74 05                	je     593 <gettoken+0x63>
    *eq = s;
     58e:	8b 45 14             	mov    0x14(%ebp),%eax
     591:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     593:	39 df                	cmp    %ebx,%edi
     595:	72 0e                	jb     5a5 <gettoken+0x75>
     597:	eb 23                	jmp    5bc <gettoken+0x8c>
     599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s++;
     5a0:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     5a1:	39 fb                	cmp    %edi,%ebx
     5a3:	74 17                	je     5bc <gettoken+0x8c>
     5a5:	0f be 07             	movsbl (%edi),%eax
     5a8:	c7 04 24 7c 16 00 00 	movl   $0x167c,(%esp)
     5af:	89 44 24 04          	mov    %eax,0x4(%esp)
     5b3:	e8 88 08 00 00       	call   e40 <strchr>
     5b8:	85 c0                	test   %eax,%eax
     5ba:	75 e4                	jne    5a0 <gettoken+0x70>
  *ps = s;
     5bc:	8b 45 08             	mov    0x8(%ebp),%eax
     5bf:	89 38                	mov    %edi,(%eax)
  return ret;
}
     5c1:	83 c4 1c             	add    $0x1c,%esp
     5c4:	89 f0                	mov    %esi,%eax
     5c6:	5b                   	pop    %ebx
     5c7:	5e                   	pop    %esi
     5c8:	5f                   	pop    %edi
     5c9:	5d                   	pop    %ebp
     5ca:	c3                   	ret
     5cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  switch(*s){
     5d0:	78 22                	js     5f4 <gettoken+0xc4>
     5d2:	3c 26                	cmp    $0x26,%al
     5d4:	74 0a                	je     5e0 <gettoken+0xb0>
     5d6:	88 c1                	mov    %al,%cl
     5d8:	80 e9 28             	sub    $0x28,%cl
     5db:	80 f9 01             	cmp    $0x1,%cl
     5de:	77 14                	ja     5f4 <gettoken+0xc4>
  ret = *s;
     5e0:	0f be f0             	movsbl %al,%esi
    s++;
     5e3:	47                   	inc    %edi
    break;
     5e4:	eb a1                	jmp    587 <gettoken+0x57>
     5e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     5ed:	00 
     5ee:	66 90                	xchg   %ax,%ax
  switch(*s){
     5f0:	3c 7c                	cmp    $0x7c,%al
     5f2:	74 ec                	je     5e0 <gettoken+0xb0>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5f4:	39 df                	cmp    %ebx,%edi
     5f6:	72 24                	jb     61c <gettoken+0xec>
     5f8:	e9 7d 00 00 00       	jmp    67a <gettoken+0x14a>
     5fd:	8d 76 00             	lea    0x0(%esi),%esi
     600:	0f be 07             	movsbl (%edi),%eax
     603:	c7 04 24 74 16 00 00 	movl   $0x1674,(%esp)
     60a:	89 44 24 04          	mov    %eax,0x4(%esp)
     60e:	e8 2d 08 00 00       	call   e40 <strchr>
     613:	85 c0                	test   %eax,%eax
     615:	75 1c                	jne    633 <gettoken+0x103>
      s++;
     617:	47                   	inc    %edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     618:	39 fb                	cmp    %edi,%ebx
     61a:	74 46                	je     662 <gettoken+0x132>
     61c:	0f be 07             	movsbl (%edi),%eax
     61f:	c7 04 24 7c 16 00 00 	movl   $0x167c,(%esp)
     626:	89 44 24 04          	mov    %eax,0x4(%esp)
     62a:	e8 11 08 00 00       	call   e40 <strchr>
     62f:	85 c0                	test   %eax,%eax
     631:	74 cd                	je     600 <gettoken+0xd0>
    ret = 'a';
     633:	be 61 00 00 00       	mov    $0x61,%esi
     638:	e9 4a ff ff ff       	jmp    587 <gettoken+0x57>
     63d:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     640:	3c 3e                	cmp    $0x3e,%al
     642:	75 ac                	jne    5f0 <gettoken+0xc0>
    if(*s == '>'){
     644:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     648:	74 0b                	je     655 <gettoken+0x125>
    s++;
     64a:	47                   	inc    %edi
  ret = *s;
     64b:	be 3e 00 00 00       	mov    $0x3e,%esi
     650:	e9 32 ff ff ff       	jmp    587 <gettoken+0x57>
      s++;
     655:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     658:	be 2b 00 00 00       	mov    $0x2b,%esi
     65d:	e9 25 ff ff ff       	jmp    587 <gettoken+0x57>
  if(eq)
     662:	8b 45 14             	mov    0x14(%ebp),%eax
     665:	85 c0                	test   %eax,%eax
     667:	74 05                	je     66e <gettoken+0x13e>
    *eq = s;
     669:	8b 45 14             	mov    0x14(%ebp),%eax
     66c:	89 18                	mov    %ebx,(%eax)
  while(s < es && strchr(whitespace, *s))
     66e:	89 df                	mov    %ebx,%edi
    ret = 'a';
     670:	be 61 00 00 00       	mov    $0x61,%esi
     675:	e9 42 ff ff ff       	jmp    5bc <gettoken+0x8c>
  if(eq)
     67a:	8b 55 14             	mov    0x14(%ebp),%edx
     67d:	85 d2                	test   %edx,%edx
     67f:	74 ef                	je     670 <gettoken+0x140>
    *eq = s;
     681:	8b 45 14             	mov    0x14(%ebp),%eax
     684:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     686:	eb e8                	jmp    670 <gettoken+0x140>
     688:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     68f:	00 

00000690 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	57                   	push   %edi
     694:	56                   	push   %esi
     695:	53                   	push   %ebx
     696:	83 ec 1c             	sub    $0x1c,%esp
     699:	8b 7d 08             	mov    0x8(%ebp),%edi
     69c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     69f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     6a1:	39 f3                	cmp    %esi,%ebx
     6a3:	72 10                	jb     6b5 <peek+0x25>
     6a5:	eb 25                	jmp    6cc <peek+0x3c>
     6a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6ae:	00 
     6af:	90                   	nop
    s++;
     6b0:	43                   	inc    %ebx
  while(s < es && strchr(whitespace, *s))
     6b1:	39 de                	cmp    %ebx,%esi
     6b3:	74 17                	je     6cc <peek+0x3c>
     6b5:	0f be 03             	movsbl (%ebx),%eax
     6b8:	c7 04 24 7c 16 00 00 	movl   $0x167c,(%esp)
     6bf:	89 44 24 04          	mov    %eax,0x4(%esp)
     6c3:	e8 78 07 00 00       	call   e40 <strchr>
     6c8:	85 c0                	test   %eax,%eax
     6ca:	75 e4                	jne    6b0 <peek+0x20>
  *ps = s;
     6cc:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     6ce:	31 c0                	xor    %eax,%eax
     6d0:	0f be 13             	movsbl (%ebx),%edx
     6d3:	84 d2                	test   %dl,%dl
     6d5:	75 09                	jne    6e0 <peek+0x50>
}
     6d7:	83 c4 1c             	add    $0x1c,%esp
     6da:	5b                   	pop    %ebx
     6db:	5e                   	pop    %esi
     6dc:	5f                   	pop    %edi
     6dd:	5d                   	pop    %ebp
     6de:	c3                   	ret
     6df:	90                   	nop
  return *s && strchr(toks, *s);
     6e0:	89 54 24 04          	mov    %edx,0x4(%esp)
     6e4:	8b 45 10             	mov    0x10(%ebp),%eax
     6e7:	89 04 24             	mov    %eax,(%esp)
     6ea:	e8 51 07 00 00       	call   e40 <strchr>
     6ef:	85 c0                	test   %eax,%eax
     6f1:	0f 95 c0             	setne  %al
}
     6f4:	83 c4 1c             	add    $0x1c,%esp
     6f7:	5b                   	pop    %ebx
  return *s && strchr(toks, *s);
     6f8:	0f b6 c0             	movzbl %al,%eax
}
     6fb:	5e                   	pop    %esi
     6fc:	5f                   	pop    %edi
     6fd:	5d                   	pop    %ebp
     6fe:	c3                   	ret
     6ff:	90                   	nop

00000700 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
     706:	83 ec 3c             	sub    $0x3c,%esp
     709:	8b 75 0c             	mov    0xc(%ebp),%esi
     70c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     70f:	90                   	nop
     710:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     714:	b8 69 15 00 00       	mov    $0x1569,%eax
     719:	89 44 24 08          	mov    %eax,0x8(%esp)
     71d:	89 34 24             	mov    %esi,(%esp)
     720:	e8 6b ff ff ff       	call   690 <peek>
     725:	85 c0                	test   %eax,%eax
     727:	0f 84 13 01 00 00    	je     840 <parseredirs+0x140>
    tok = gettoken(ps, es, 0, 0);
     72d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     731:	31 c0                	xor    %eax,%eax
     733:	89 44 24 0c          	mov    %eax,0xc(%esp)
     737:	31 c0                	xor    %eax,%eax
     739:	89 44 24 08          	mov    %eax,0x8(%esp)
     73d:	89 34 24             	mov    %esi,(%esp)
     740:	e8 eb fd ff ff       	call   530 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     745:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     749:	89 34 24             	mov    %esi,(%esp)
    tok = gettoken(ps, es, 0, 0);
     74c:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     74e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     751:	89 44 24 0c          	mov    %eax,0xc(%esp)
     755:	8d 45 e0             	lea    -0x20(%ebp),%eax
     758:	89 44 24 08          	mov    %eax,0x8(%esp)
     75c:	e8 cf fd ff ff       	call   530 <gettoken>
     761:	83 f8 61             	cmp    $0x61,%eax
     764:	0f 85 e1 00 00 00    	jne    84b <parseredirs+0x14b>
      panic("missing file for redirection");
    switch(tok){
     76a:	83 ff 3c             	cmp    $0x3c,%edi
     76d:	74 71                	je     7e0 <parseredirs+0xe0>
     76f:	83 ff 3e             	cmp    $0x3e,%edi
     772:	74 05                	je     779 <parseredirs+0x79>
     774:	83 ff 2b             	cmp    $0x2b,%edi
     777:	75 97                	jne    710 <parseredirs+0x10>
  cmd = malloc(sizeof(*cmd));
     779:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     780:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     783:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     786:	89 55 d0             	mov    %edx,-0x30(%ebp)
     789:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     78c:	e8 9f 0c 00 00       	call   1430 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     791:	ba 18 00 00 00       	mov    $0x18,%edx
     796:	31 c9                	xor    %ecx,%ecx
     798:	89 54 24 08          	mov    %edx,0x8(%esp)
     79c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     7a0:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     7a3:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     7a5:	e8 76 06 00 00       	call   e20 <memset>
  cmd->type = REDIR;
     7aa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     7b0:	8b 45 08             	mov    0x8(%ebp),%eax
     7b3:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     7b6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     7b9:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     7bc:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     7bf:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->fd = fd;
     7c6:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
  cmd->efile = efile;
     7cd:	89 57 0c             	mov    %edx,0xc(%edi)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     7d0:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     7d3:	e9 38 ff ff ff       	jmp    710 <parseredirs+0x10>
     7d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7df:	00 
  cmd = malloc(sizeof(*cmd));
     7e0:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     7e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     7ea:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     7ed:	89 55 d0             	mov    %edx,-0x30(%ebp)
     7f0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     7f3:	e8 38 0c 00 00       	call   1430 <malloc>
     7f8:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     7fa:	b8 18 00 00 00       	mov    $0x18,%eax
     7ff:	89 44 24 08          	mov    %eax,0x8(%esp)
     803:	31 c0                	xor    %eax,%eax
     805:	89 44 24 04          	mov    %eax,0x4(%esp)
     809:	89 3c 24             	mov    %edi,(%esp)
     80c:	e8 0f 06 00 00       	call   e20 <memset>
  cmd->cmd = subcmd;
     811:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     814:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->file = file;
     81a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  cmd->mode = mode;
     81d:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->efile = efile;
     824:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->fd = fd;
     827:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  cmd->cmd = subcmd;
     82e:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     831:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     834:	89 57 0c             	mov    %edx,0xc(%edi)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     837:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     83a:	e9 d1 fe ff ff       	jmp    710 <parseredirs+0x10>
     83f:	90                   	nop
    }
  }
  return cmd;
}
     840:	8b 45 08             	mov    0x8(%ebp),%eax
     843:	83 c4 3c             	add    $0x3c,%esp
     846:	5b                   	pop    %ebx
     847:	5e                   	pop    %esi
     848:	5f                   	pop    %edi
     849:	5d                   	pop    %ebp
     84a:	c3                   	ret
      panic("missing file for redirection");
     84b:	c7 04 24 4c 15 00 00 	movl   $0x154c,(%esp)
     852:	e8 49 f9 ff ff       	call   1a0 <panic>
     857:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     85e:	00 
     85f:	90                   	nop

00000860 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     860:	55                   	push   %ebp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     861:	b8 6c 15 00 00       	mov    $0x156c,%eax
{
     866:	89 e5                	mov    %esp,%ebp
     868:	57                   	push   %edi
     869:	56                   	push   %esi
     86a:	53                   	push   %ebx
     86b:	83 ec 3c             	sub    $0x3c,%esp
  if(peek(ps, es, "("))
     86e:	89 44 24 08          	mov    %eax,0x8(%esp)
{
     872:	8b 75 08             	mov    0x8(%ebp),%esi
     875:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(peek(ps, es, "("))
     878:	89 34 24             	mov    %esi,(%esp)
     87b:	89 7c 24 04          	mov    %edi,0x4(%esp)
     87f:	e8 0c fe ff ff       	call   690 <peek>
     884:	85 c0                	test   %eax,%eax
     886:	0f 85 cc 00 00 00    	jne    958 <parseexec+0xf8>
  cmd = malloc(sizeof(*cmd));
     88c:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     893:	89 c3                	mov    %eax,%ebx
     895:	e8 96 0b 00 00       	call   1430 <malloc>
     89a:	89 c2                	mov    %eax,%edx
  memset(cmd, 0, sizeof(*cmd));
     89c:	b8 54 00 00 00       	mov    $0x54,%eax
     8a1:	89 44 24 08          	mov    %eax,0x8(%esp)
     8a5:	31 c0                	xor    %eax,%eax
     8a7:	89 14 24             	mov    %edx,(%esp)
     8aa:	89 44 24 04          	mov    %eax,0x4(%esp)
     8ae:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     8b1:	e8 6a 05 00 00       	call   e20 <memset>
  cmd->type = EXEC;
     8b6:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     8b9:	c7 02 01 00 00 00    	movl   $0x1,(%edx)

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     8bf:	89 7c 24 08          	mov    %edi,0x8(%esp)
     8c3:	89 74 24 04          	mov    %esi,0x4(%esp)
     8c7:	89 14 24             	mov    %edx,(%esp)
     8ca:	89 55 d0             	mov    %edx,-0x30(%ebp)
     8cd:	e8 2e fe ff ff       	call   700 <parseredirs>
     8d2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8d5:	eb 1f                	jmp    8f6 <parseexec+0x96>
     8d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     8de:	00 
     8df:	90                   	nop
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     8e0:	89 7c 24 08          	mov    %edi,0x8(%esp)
     8e4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     8e7:	89 74 24 04          	mov    %esi,0x4(%esp)
     8eb:	89 04 24             	mov    %eax,(%esp)
     8ee:	e8 0d fe ff ff       	call   700 <parseredirs>
     8f3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8f6:	89 7c 24 04          	mov    %edi,0x4(%esp)
     8fa:	b8 83 15 00 00       	mov    $0x1583,%eax
     8ff:	89 44 24 08          	mov    %eax,0x8(%esp)
     903:	89 34 24             	mov    %esi,(%esp)
     906:	e8 85 fd ff ff       	call   690 <peek>
     90b:	85 c0                	test   %eax,%eax
     90d:	75 61                	jne    970 <parseexec+0x110>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     90f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     913:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     916:	89 44 24 0c          	mov    %eax,0xc(%esp)
     91a:	8d 45 e0             	lea    -0x20(%ebp),%eax
     91d:	89 44 24 08          	mov    %eax,0x8(%esp)
     921:	89 34 24             	mov    %esi,(%esp)
     924:	e8 07 fc ff ff       	call   530 <gettoken>
     929:	85 c0                	test   %eax,%eax
     92b:	74 43                	je     970 <parseexec+0x110>
    if(tok != 'a')
     92d:	83 f8 61             	cmp    $0x61,%eax
     930:	75 58                	jne    98a <parseexec+0x12a>
    cmd->argv[argc] = q;
     932:	8b 45 e0             	mov    -0x20(%ebp),%eax
     935:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     938:	89 44 99 04          	mov    %eax,0x4(%ecx,%ebx,4)
    cmd->eargv[argc] = eq;
     93c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     93f:	89 44 99 2c          	mov    %eax,0x2c(%ecx,%ebx,4)
    argc++;
     943:	43                   	inc    %ebx
    if(argc >= MAXARGS)
     944:	83 fb 0a             	cmp    $0xa,%ebx
     947:	75 97                	jne    8e0 <parseexec+0x80>
      panic("too many args");
     949:	c7 04 24 75 15 00 00 	movl   $0x1575,(%esp)
     950:	e8 4b f8 ff ff       	call   1a0 <panic>
     955:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     958:	89 7d 0c             	mov    %edi,0xc(%ebp)
     95b:	89 75 08             	mov    %esi,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     95e:	83 c4 3c             	add    $0x3c,%esp
     961:	5b                   	pop    %ebx
     962:	5e                   	pop    %esi
     963:	5f                   	pop    %edi
     964:	5d                   	pop    %ebp
    return parseblock(ps, es);
     965:	e9 16 02 00 00       	jmp    b80 <parseblock>
     96a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     970:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->argv[argc] = 0;
     973:	31 c0                	xor    %eax,%eax
  cmd->eargv[argc] = 0;
     975:	31 c9                	xor    %ecx,%ecx
  cmd->argv[argc] = 0;
     977:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
}
     97b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  cmd->eargv[argc] = 0;
     97e:	89 4c 9a 2c          	mov    %ecx,0x2c(%edx,%ebx,4)
}
     982:	83 c4 3c             	add    $0x3c,%esp
     985:	5b                   	pop    %ebx
     986:	5e                   	pop    %esi
     987:	5f                   	pop    %edi
     988:	5d                   	pop    %ebp
     989:	c3                   	ret
      panic("syntax");
     98a:	c7 04 24 6e 15 00 00 	movl   $0x156e,(%esp)
     991:	e8 0a f8 ff ff       	call   1a0 <panic>
     996:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     99d:	00 
     99e:	66 90                	xchg   %ax,%ax

000009a0 <parsepipe>:
{
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
     9a3:	83 ec 28             	sub    $0x28,%esp
     9a6:	89 75 f8             	mov    %esi,-0x8(%ebp)
     9a9:	8b 75 08             	mov    0x8(%ebp),%esi
     9ac:	89 7d fc             	mov    %edi,-0x4(%ebp)
     9af:	8b 7d 0c             	mov    0xc(%ebp),%edi
     9b2:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  cmd = parseexec(ps, es);
     9b5:	89 34 24             	mov    %esi,(%esp)
     9b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9bc:	e8 9f fe ff ff       	call   860 <parseexec>
  if(peek(ps, es, "|")){
     9c1:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9c5:	89 34 24             	mov    %esi,(%esp)
  cmd = parseexec(ps, es);
     9c8:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     9ca:	b8 88 15 00 00       	mov    $0x1588,%eax
     9cf:	89 44 24 08          	mov    %eax,0x8(%esp)
     9d3:	e8 b8 fc ff ff       	call   690 <peek>
     9d8:	85 c0                	test   %eax,%eax
     9da:	75 14                	jne    9f0 <parsepipe+0x50>
}
     9dc:	8b 75 f8             	mov    -0x8(%ebp),%esi
     9df:	89 d8                	mov    %ebx,%eax
     9e1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     9e4:	8b 7d fc             	mov    -0x4(%ebp),%edi
     9e7:	89 ec                	mov    %ebp,%esp
     9e9:	5d                   	pop    %ebp
     9ea:	c3                   	ret
     9eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     9f0:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9f4:	31 d2                	xor    %edx,%edx
     9f6:	31 c0                	xor    %eax,%eax
     9f8:	89 54 24 08          	mov    %edx,0x8(%esp)
     9fc:	89 34 24             	mov    %esi,(%esp)
     9ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a03:	e8 28 fb ff ff       	call   530 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a08:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a0c:	89 34 24             	mov    %esi,(%esp)
     a0f:	e8 8c ff ff ff       	call   9a0 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     a14:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a1b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     a1d:	e8 0e 0a 00 00       	call   1430 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a22:	b9 0c 00 00 00       	mov    $0xc,%ecx
     a27:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  cmd = malloc(sizeof(*cmd));
     a2b:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     a2d:	31 c0                	xor    %eax,%eax
     a2f:	89 34 24             	mov    %esi,(%esp)
     a32:	89 44 24 04          	mov    %eax,0x4(%esp)
     a36:	e8 e5 03 00 00       	call   e20 <memset>
  cmd->left = left;
     a3b:	89 5e 04             	mov    %ebx,0x4(%esi)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a3e:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     a40:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     a46:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     a48:	89 7e 08             	mov    %edi,0x8(%esi)
}
     a4b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     a4e:	8b 75 f8             	mov    -0x8(%ebp),%esi
     a51:	8b 7d fc             	mov    -0x4(%ebp),%edi
     a54:	89 ec                	mov    %ebp,%esp
     a56:	5d                   	pop    %ebp
     a57:	c3                   	ret
     a58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a5f:	00 

00000a60 <parseline>:
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	57                   	push   %edi
     a64:	56                   	push   %esi
     a65:	53                   	push   %ebx
     a66:	83 ec 2c             	sub    $0x2c,%esp
     a69:	8b 75 08             	mov    0x8(%ebp),%esi
     a6c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     a6f:	89 34 24             	mov    %esi,(%esp)
     a72:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a76:	e8 25 ff ff ff       	call   9a0 <parsepipe>
     a7b:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     a7d:	eb 4f                	jmp    ace <parseline+0x6e>
     a7f:	90                   	nop
    gettoken(ps, es, 0, 0);
     a80:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a84:	31 c0                	xor    %eax,%eax
     a86:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a8a:	31 c0                	xor    %eax,%eax
     a8c:	89 44 24 08          	mov    %eax,0x8(%esp)
     a90:	89 34 24             	mov    %esi,(%esp)
     a93:	e8 98 fa ff ff       	call   530 <gettoken>
  cmd = malloc(sizeof(*cmd));
     a98:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     a9f:	e8 8c 09 00 00       	call   1430 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     aa4:	b9 08 00 00 00       	mov    $0x8,%ecx
     aa9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  cmd = malloc(sizeof(*cmd));
     aad:	89 c2                	mov    %eax,%edx
  memset(cmd, 0, sizeof(*cmd));
     aaf:	31 c0                	xor    %eax,%eax
     ab1:	89 14 24             	mov    %edx,(%esp)
     ab4:	89 44 24 04          	mov    %eax,0x4(%esp)
     ab8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     abb:	e8 60 03 00 00       	call   e20 <memset>
  cmd->type = BACK;
     ac0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     ac3:	89 5a 04             	mov    %ebx,0x4(%edx)
    cmd = backcmd(cmd);
     ac6:	89 d3                	mov    %edx,%ebx
  cmd->type = BACK;
     ac8:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  while(peek(ps, es, "&")){
     ace:	89 7c 24 04          	mov    %edi,0x4(%esp)
     ad2:	b8 8a 15 00 00       	mov    $0x158a,%eax
     ad7:	89 44 24 08          	mov    %eax,0x8(%esp)
     adb:	89 34 24             	mov    %esi,(%esp)
     ade:	e8 ad fb ff ff       	call   690 <peek>
     ae3:	85 c0                	test   %eax,%eax
     ae5:	75 99                	jne    a80 <parseline+0x20>
  if(peek(ps, es, ";")){
     ae7:	89 7c 24 04          	mov    %edi,0x4(%esp)
     aeb:	b8 86 15 00 00       	mov    $0x1586,%eax
     af0:	89 44 24 08          	mov    %eax,0x8(%esp)
     af4:	89 34 24             	mov    %esi,(%esp)
     af7:	e8 94 fb ff ff       	call   690 <peek>
     afc:	85 c0                	test   %eax,%eax
     afe:	75 10                	jne    b10 <parseline+0xb0>
}
     b00:	83 c4 2c             	add    $0x2c,%esp
     b03:	89 d8                	mov    %ebx,%eax
     b05:	5b                   	pop    %ebx
     b06:	5e                   	pop    %esi
     b07:	5f                   	pop    %edi
     b08:	5d                   	pop    %ebp
     b09:	c3                   	ret
     b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     b10:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b14:	31 d2                	xor    %edx,%edx
     b16:	31 c0                	xor    %eax,%eax
     b18:	89 54 24 08          	mov    %edx,0x8(%esp)
     b1c:	89 34 24             	mov    %esi,(%esp)
     b1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b23:	e8 08 fa ff ff       	call   530 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     b28:	89 7c 24 04          	mov    %edi,0x4(%esp)
     b2c:	89 34 24             	mov    %esi,(%esp)
     b2f:	e8 2c ff ff ff       	call   a60 <parseline>
  cmd = malloc(sizeof(*cmd));
     b34:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     b3b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     b3d:	e8 ee 08 00 00       	call   1430 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     b42:	b9 0c 00 00 00       	mov    $0xc,%ecx
     b47:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  cmd = malloc(sizeof(*cmd));
     b4b:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     b4d:	31 c0                	xor    %eax,%eax
     b4f:	89 34 24             	mov    %esi,(%esp)
     b52:	89 44 24 04          	mov    %eax,0x4(%esp)
     b56:	e8 c5 02 00 00       	call   e20 <memset>
  cmd->left = left;
     b5b:	89 5e 04             	mov    %ebx,0x4(%esi)
    cmd = listcmd(cmd, parseline(ps, es));
     b5e:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     b60:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     b66:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     b68:	89 7e 08             	mov    %edi,0x8(%esi)
}
     b6b:	83 c4 2c             	add    $0x2c,%esp
     b6e:	5b                   	pop    %ebx
     b6f:	5e                   	pop    %esi
     b70:	5f                   	pop    %edi
     b71:	5d                   	pop    %ebp
     b72:	c3                   	ret
     b73:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b7a:	00 
     b7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000b80 <parseblock>:
{
     b80:	55                   	push   %ebp
  if(!peek(ps, es, "("))
     b81:	b8 6c 15 00 00       	mov    $0x156c,%eax
{
     b86:	89 e5                	mov    %esp,%ebp
     b88:	83 ec 28             	sub    $0x28,%esp
     b8b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     b8e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b91:	89 75 f8             	mov    %esi,-0x8(%ebp)
     b94:	8b 75 0c             	mov    0xc(%ebp),%esi
     b97:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(!peek(ps, es, "("))
     b9a:	89 44 24 08          	mov    %eax,0x8(%esp)
     b9e:	89 1c 24             	mov    %ebx,(%esp)
     ba1:	89 74 24 04          	mov    %esi,0x4(%esp)
     ba5:	e8 e6 fa ff ff       	call   690 <peek>
     baa:	85 c0                	test   %eax,%eax
     bac:	74 74                	je     c22 <parseblock+0xa2>
  gettoken(ps, es, 0, 0);
     bae:	89 74 24 04          	mov    %esi,0x4(%esp)
     bb2:	31 c9                	xor    %ecx,%ecx
     bb4:	31 ff                	xor    %edi,%edi
     bb6:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     bba:	89 7c 24 08          	mov    %edi,0x8(%esp)
     bbe:	89 1c 24             	mov    %ebx,(%esp)
     bc1:	e8 6a f9 ff ff       	call   530 <gettoken>
  cmd = parseline(ps, es);
     bc6:	89 74 24 04          	mov    %esi,0x4(%esp)
     bca:	89 1c 24             	mov    %ebx,(%esp)
     bcd:	e8 8e fe ff ff       	call   a60 <parseline>
  if(!peek(ps, es, ")"))
     bd2:	89 74 24 04          	mov    %esi,0x4(%esp)
     bd6:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseline(ps, es);
     bd9:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     bdb:	b8 a8 15 00 00       	mov    $0x15a8,%eax
     be0:	89 44 24 08          	mov    %eax,0x8(%esp)
     be4:	e8 a7 fa ff ff       	call   690 <peek>
     be9:	85 c0                	test   %eax,%eax
     beb:	74 41                	je     c2e <parseblock+0xae>
  gettoken(ps, es, 0, 0);
     bed:	89 74 24 04          	mov    %esi,0x4(%esp)
     bf1:	31 d2                	xor    %edx,%edx
     bf3:	31 c0                	xor    %eax,%eax
     bf5:	89 54 24 08          	mov    %edx,0x8(%esp)
     bf9:	89 1c 24             	mov    %ebx,(%esp)
     bfc:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c00:	e8 2b f9 ff ff       	call   530 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     c05:	89 74 24 08          	mov    %esi,0x8(%esp)
     c09:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     c0d:	89 3c 24             	mov    %edi,(%esp)
     c10:	e8 eb fa ff ff       	call   700 <parseredirs>
}
     c15:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c18:	8b 75 f8             	mov    -0x8(%ebp),%esi
     c1b:	8b 7d fc             	mov    -0x4(%ebp),%edi
     c1e:	89 ec                	mov    %ebp,%esp
     c20:	5d                   	pop    %ebp
     c21:	c3                   	ret
    panic("parseblock");
     c22:	c7 04 24 8c 15 00 00 	movl   $0x158c,(%esp)
     c29:	e8 72 f5 ff ff       	call   1a0 <panic>
    panic("syntax - missing )");
     c2e:	c7 04 24 97 15 00 00 	movl   $0x1597,(%esp)
     c35:	e8 66 f5 ff ff       	call   1a0 <panic>
     c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c40 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	83 ec 18             	sub    $0x18,%esp
     c46:	89 5d fc             	mov    %ebx,-0x4(%ebp)
     c49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     c4c:	85 db                	test   %ebx,%ebx
     c4e:	74 26                	je     c76 <nulterminate+0x36>
    return 0;

  switch(cmd->type){
     c50:	83 3b 05             	cmpl   $0x5,(%ebx)
     c53:	77 21                	ja     c76 <nulterminate+0x36>
     c55:	8b 03                	mov    (%ebx),%eax
     c57:	ff 24 85 f0 15 00 00 	jmp    *0x15f0(,%eax,4)
     c5e:	66 90                	xchg   %ax,%ax
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     c60:	8b 43 04             	mov    0x4(%ebx),%eax
     c63:	89 04 24             	mov    %eax,(%esp)
     c66:	e8 d5 ff ff ff       	call   c40 <nulterminate>
    nulterminate(lcmd->right);
     c6b:	8b 43 08             	mov    0x8(%ebx),%eax
     c6e:	89 04 24             	mov    %eax,(%esp)
     c71:	e8 ca ff ff ff       	call   c40 <nulterminate>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     c76:	89 d8                	mov    %ebx,%eax
     c78:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c7b:	89 ec                	mov    %ebp,%esp
     c7d:	5d                   	pop    %ebp
     c7e:	c3                   	ret
     c7f:	90                   	nop
    nulterminate(bcmd->cmd);
     c80:	8b 43 04             	mov    0x4(%ebx),%eax
     c83:	89 04 24             	mov    %eax,(%esp)
     c86:	e8 b5 ff ff ff       	call   c40 <nulterminate>
}
     c8b:	89 d8                	mov    %ebx,%eax
     c8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c90:	89 ec                	mov    %ebp,%esp
     c92:	5d                   	pop    %ebp
     c93:	c3                   	ret
     c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(i=0; ecmd->argv[i]; i++)
     c98:	8b 4b 04             	mov    0x4(%ebx),%ecx
     c9b:	85 c9                	test   %ecx,%ecx
     c9d:	74 d7                	je     c76 <nulterminate+0x36>
     c9f:	8d 43 08             	lea    0x8(%ebx),%eax
     ca2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ca9:	00 
     caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     cb0:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     cb3:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     cb6:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     cb9:	8b 50 fc             	mov    -0x4(%eax),%edx
     cbc:	85 d2                	test   %edx,%edx
     cbe:	75 f0                	jne    cb0 <nulterminate+0x70>
}
     cc0:	89 d8                	mov    %ebx,%eax
     cc2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cc5:	89 ec                	mov    %ebp,%esp
     cc7:	5d                   	pop    %ebp
     cc8:	c3                   	ret
     cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(rcmd->cmd);
     cd0:	8b 43 04             	mov    0x4(%ebx),%eax
     cd3:	89 04 24             	mov    %eax,(%esp)
     cd6:	e8 65 ff ff ff       	call   c40 <nulterminate>
    *rcmd->efile = 0;
     cdb:	8b 43 0c             	mov    0xc(%ebx),%eax
     cde:	c6 00 00             	movb   $0x0,(%eax)
}
     ce1:	89 d8                	mov    %ebx,%eax
     ce3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ce6:	89 ec                	mov    %ebp,%esp
     ce8:	5d                   	pop    %ebp
     ce9:	c3                   	ret
     cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000cf0 <parsecmd>:
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	56                   	push   %esi
     cf4:	53                   	push   %ebx
     cf5:	83 ec 10             	sub    $0x10,%esp
  es = s + strlen(s);
     cf8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     cfb:	89 1c 24             	mov    %ebx,(%esp)
     cfe:	e8 ed 00 00 00       	call   df0 <strlen>
     d03:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     d05:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     d09:	8d 45 08             	lea    0x8(%ebp),%eax
     d0c:	89 04 24             	mov    %eax,(%esp)
     d0f:	e8 4c fd ff ff       	call   a60 <parseline>
  peek(&s, es, "");
     d14:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  cmd = parseline(&s, es);
     d18:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     d1a:	b8 36 15 00 00       	mov    $0x1536,%eax
     d1f:	89 44 24 08          	mov    %eax,0x8(%esp)
     d23:	8d 45 08             	lea    0x8(%ebp),%eax
     d26:	89 04 24             	mov    %eax,(%esp)
     d29:	e8 62 f9 ff ff       	call   690 <peek>
  if(s != es){
     d2e:	8b 45 08             	mov    0x8(%ebp),%eax
     d31:	39 d8                	cmp    %ebx,%eax
     d33:	75 11                	jne    d46 <parsecmd+0x56>
  nulterminate(cmd);
     d35:	89 34 24             	mov    %esi,(%esp)
     d38:	e8 03 ff ff ff       	call   c40 <nulterminate>
}
     d3d:	83 c4 10             	add    $0x10,%esp
     d40:	89 f0                	mov    %esi,%eax
     d42:	5b                   	pop    %ebx
     d43:	5e                   	pop    %esi
     d44:	5d                   	pop    %ebp
     d45:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     d46:	89 44 24 08          	mov    %eax,0x8(%esp)
     d4a:	c7 44 24 04 aa 15 00 	movl   $0x15aa,0x4(%esp)
     d51:	00 
     d52:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     d59:	e8 12 04 00 00       	call   1170 <printf>
    panic("syntax");
     d5e:	c7 04 24 6e 15 00 00 	movl   $0x156e,(%esp)
     d65:	e8 36 f4 ff ff       	call   1a0 <panic>
     d6a:	66 90                	xchg   %ax,%ax
     d6c:	66 90                	xchg   %ax,%ax
     d6e:	66 90                	xchg   %ax,%ax

00000d70 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     d70:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     d71:	31 c0                	xor    %eax,%eax
{
     d73:	89 e5                	mov    %esp,%ebp
     d75:	53                   	push   %ebx
     d76:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     d80:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     d84:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     d87:	40                   	inc    %eax
     d88:	84 d2                	test   %dl,%dl
     d8a:	75 f4                	jne    d80 <strcpy+0x10>
    ;
  return os;
}
     d8c:	5b                   	pop    %ebx
     d8d:	89 c8                	mov    %ecx,%eax
     d8f:	5d                   	pop    %ebp
     d90:	c3                   	ret
     d91:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d98:	00 
     d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000da0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	53                   	push   %ebx
     da4:	8b 55 08             	mov    0x8(%ebp),%edx
     da7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     daa:	0f b6 02             	movzbl (%edx),%eax
     dad:	84 c0                	test   %al,%al
     daf:	75 15                	jne    dc6 <strcmp+0x26>
     db1:	eb 30                	jmp    de3 <strcmp+0x43>
     db3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     db8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     dbc:	8d 4b 01             	lea    0x1(%ebx),%ecx
     dbf:	42                   	inc    %edx
  while(*p && *p == *q)
     dc0:	84 c0                	test   %al,%al
     dc2:	74 14                	je     dd8 <strcmp+0x38>
     dc4:	89 cb                	mov    %ecx,%ebx
     dc6:	0f b6 0b             	movzbl (%ebx),%ecx
     dc9:	38 c1                	cmp    %al,%cl
     dcb:	74 eb                	je     db8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
}
     dcd:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     dce:	29 c8                	sub    %ecx,%eax
}
     dd0:	5d                   	pop    %ebp
     dd1:	c3                   	ret
     dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
     dd8:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
     ddc:	31 c0                	xor    %eax,%eax
}
     dde:	5b                   	pop    %ebx
     ddf:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
     de0:	29 c8                	sub    %ecx,%eax
}
     de2:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     de3:	0f b6 0b             	movzbl (%ebx),%ecx
     de6:	31 c0                	xor    %eax,%eax
     de8:	eb e3                	jmp    dcd <strcmp+0x2d>
     dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000df0 <strlen>:

uint
strlen(const char *s)
{
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     df6:	80 3a 00             	cmpb   $0x0,(%edx)
     df9:	74 15                	je     e10 <strlen+0x20>
     dfb:	31 c0                	xor    %eax,%eax
     dfd:	8d 76 00             	lea    0x0(%esi),%esi
     e00:	40                   	inc    %eax
     e01:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     e05:	89 c1                	mov    %eax,%ecx
     e07:	75 f7                	jne    e00 <strlen+0x10>
    ;
  return n;
}
     e09:	5d                   	pop    %ebp
     e0a:	89 c8                	mov    %ecx,%eax
     e0c:	c3                   	ret
     e0d:	8d 76 00             	lea    0x0(%esi),%esi
     e10:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
     e11:	31 c9                	xor    %ecx,%ecx
}
     e13:	89 c8                	mov    %ecx,%eax
     e15:	c3                   	ret
     e16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e1d:	00 
     e1e:	66 90                	xchg   %ax,%ax

00000e20 <memset>:

void*
memset(void *dst, int c, uint n)
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	8b 55 08             	mov    0x8(%ebp),%edx
     e26:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     e27:	8b 4d 10             	mov    0x10(%ebp),%ecx
     e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e2d:	89 d7                	mov    %edx,%edi
     e2f:	fc                   	cld
     e30:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     e32:	5f                   	pop    %edi
     e33:	89 d0                	mov    %edx,%eax
     e35:	5d                   	pop    %ebp
     e36:	c3                   	ret
     e37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e3e:	00 
     e3f:	90                   	nop

00000e40 <strchr>:

char*
strchr(const char *s, char c)
{
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	8b 45 08             	mov    0x8(%ebp),%eax
     e46:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     e4a:	0f b6 10             	movzbl (%eax),%edx
     e4d:	84 d2                	test   %dl,%dl
     e4f:	75 10                	jne    e61 <strchr+0x21>
     e51:	eb 1d                	jmp    e70 <strchr+0x30>
     e53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     e58:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     e5c:	40                   	inc    %eax
     e5d:	84 d2                	test   %dl,%dl
     e5f:	74 0f                	je     e70 <strchr+0x30>
    if(*s == c)
     e61:	38 d1                	cmp    %dl,%cl
     e63:	75 f3                	jne    e58 <strchr+0x18>
      return (char*)s;
  return 0;
}
     e65:	5d                   	pop    %ebp
     e66:	c3                   	ret
     e67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e6e:	00 
     e6f:	90                   	nop
     e70:	5d                   	pop    %ebp
  return 0;
     e71:	31 c0                	xor    %eax,%eax
}
     e73:	c3                   	ret
     e74:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e7b:	00 
     e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e80 <gets>:

char*
gets(char *buf, int max)
{
     e80:	55                   	push   %ebp
     e81:	89 e5                	mov    %esp,%ebp
     e83:	57                   	push   %edi
     e84:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e85:	31 f6                	xor    %esi,%esi
{
     e87:	53                   	push   %ebx
    cc = read(0, &c, 1);
     e88:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
     e8b:	83 ec 3c             	sub    $0x3c,%esp
     e8e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  for(i=0; i+1 < max; ){
     e91:	eb 32                	jmp    ec5 <gets+0x45>
     e93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     e98:	89 7c 24 04          	mov    %edi,0x4(%esp)
     e9c:	b8 01 00 00 00       	mov    $0x1,%eax
     ea1:	89 44 24 08          	mov    %eax,0x8(%esp)
     ea5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     eac:	e8 1a 01 00 00       	call   fcb <read>
    if(cc < 1)
     eb1:	85 c0                	test   %eax,%eax
     eb3:	7e 19                	jle    ece <gets+0x4e>
      break;
    buf[i++] = c;
     eb5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     eb9:	88 44 33 ff          	mov    %al,-0x1(%ebx,%esi,1)
    if(c == '\n' || c == '\r')
     ebd:	3c 0a                	cmp    $0xa,%al
     ebf:	74 10                	je     ed1 <gets+0x51>
     ec1:	3c 0d                	cmp    $0xd,%al
     ec3:	74 0c                	je     ed1 <gets+0x51>
  for(i=0; i+1 < max; ){
     ec5:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     ec8:	46                   	inc    %esi
     ec9:	3b 75 0c             	cmp    0xc(%ebp),%esi
     ecc:	7c ca                	jl     e98 <gets+0x18>
     ece:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      break;
  }
  buf[i] = '\0';
     ed1:	c6 04 33 00          	movb   $0x0,(%ebx,%esi,1)
  return buf;
}
     ed5:	83 c4 3c             	add    $0x3c,%esp
     ed8:	89 d8                	mov    %ebx,%eax
     eda:	5b                   	pop    %ebx
     edb:	5e                   	pop    %esi
     edc:	5f                   	pop    %edi
     edd:	5d                   	pop    %ebp
     ede:	c3                   	ret
     edf:	90                   	nop

00000ee0 <stat>:

int
stat(const char *n, struct stat *st)
{
     ee0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ee1:	31 c0                	xor    %eax,%eax
{
     ee3:	89 e5                	mov    %esp,%ebp
     ee5:	83 ec 18             	sub    $0x18,%esp
     ee8:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     eeb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     eee:	89 44 24 04          	mov    %eax,0x4(%esp)
     ef2:	8b 45 08             	mov    0x8(%ebp),%eax
     ef5:	89 04 24             	mov    %eax,(%esp)
     ef8:	e8 f6 00 00 00       	call   ff3 <open>
  if(fd < 0)
     efd:	85 c0                	test   %eax,%eax
     eff:	78 2f                	js     f30 <stat+0x50>
     f01:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     f03:	8b 45 0c             	mov    0xc(%ebp),%eax
     f06:	89 1c 24             	mov    %ebx,(%esp)
     f09:	89 44 24 04          	mov    %eax,0x4(%esp)
     f0d:	e8 f9 00 00 00       	call   100b <fstat>
  close(fd);
     f12:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     f15:	89 c6                	mov    %eax,%esi
  close(fd);
     f17:	e8 bf 00 00 00       	call   fdb <close>
  return r;
}
     f1c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     f1f:	89 f0                	mov    %esi,%eax
     f21:	8b 75 fc             	mov    -0x4(%ebp),%esi
     f24:	89 ec                	mov    %ebp,%esp
     f26:	5d                   	pop    %ebp
     f27:	c3                   	ret
     f28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f2f:	00 
    return -1;
     f30:	be ff ff ff ff       	mov    $0xffffffff,%esi
     f35:	eb e5                	jmp    f1c <stat+0x3c>
     f37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f3e:	00 
     f3f:	90                   	nop

00000f40 <atoi>:

int
atoi(const char *s)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	53                   	push   %ebx
     f44:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f47:	0f be 02             	movsbl (%edx),%eax
     f4a:	88 c1                	mov    %al,%cl
     f4c:	80 e9 30             	sub    $0x30,%cl
     f4f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     f52:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     f57:	77 1c                	ja     f75 <atoi+0x35>
     f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     f60:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     f63:	42                   	inc    %edx
     f64:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     f68:	0f be 02             	movsbl (%edx),%eax
     f6b:	88 c3                	mov    %al,%bl
     f6d:	80 eb 30             	sub    $0x30,%bl
     f70:	80 fb 09             	cmp    $0x9,%bl
     f73:	76 eb                	jbe    f60 <atoi+0x20>
  return n;
}
     f75:	5b                   	pop    %ebx
     f76:	89 c8                	mov    %ecx,%eax
     f78:	5d                   	pop    %ebp
     f79:	c3                   	ret
     f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000f80 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     f80:	55                   	push   %ebp
     f81:	89 e5                	mov    %esp,%ebp
     f83:	57                   	push   %edi
     f84:	8b 45 10             	mov    0x10(%ebp),%eax
     f87:	56                   	push   %esi
     f88:	8b 55 08             	mov    0x8(%ebp),%edx
     f8b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     f8e:	85 c0                	test   %eax,%eax
     f90:	7e 13                	jle    fa5 <memmove+0x25>
     f92:	01 d0                	add    %edx,%eax
  dst = vdst;
     f94:	89 d7                	mov    %edx,%edi
     f96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f9d:	00 
     f9e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
     fa0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     fa1:	39 f8                	cmp    %edi,%eax
     fa3:	75 fb                	jne    fa0 <memmove+0x20>
  return vdst;
}
     fa5:	5e                   	pop    %esi
     fa6:	89 d0                	mov    %edx,%eax
     fa8:	5f                   	pop    %edi
     fa9:	5d                   	pop    %ebp
     faa:	c3                   	ret

00000fab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     fab:	b8 01 00 00 00       	mov    $0x1,%eax
     fb0:	cd 40                	int    $0x40
     fb2:	c3                   	ret

00000fb3 <exit>:
SYSCALL(exit)
     fb3:	b8 02 00 00 00       	mov    $0x2,%eax
     fb8:	cd 40                	int    $0x40
     fba:	c3                   	ret

00000fbb <wait>:
SYSCALL(wait)
     fbb:	b8 03 00 00 00       	mov    $0x3,%eax
     fc0:	cd 40                	int    $0x40
     fc2:	c3                   	ret

00000fc3 <pipe>:
SYSCALL(pipe)
     fc3:	b8 04 00 00 00       	mov    $0x4,%eax
     fc8:	cd 40                	int    $0x40
     fca:	c3                   	ret

00000fcb <read>:
SYSCALL(read)
     fcb:	b8 05 00 00 00       	mov    $0x5,%eax
     fd0:	cd 40                	int    $0x40
     fd2:	c3                   	ret

00000fd3 <write>:
SYSCALL(write)
     fd3:	b8 10 00 00 00       	mov    $0x10,%eax
     fd8:	cd 40                	int    $0x40
     fda:	c3                   	ret

00000fdb <close>:
SYSCALL(close)
     fdb:	b8 15 00 00 00       	mov    $0x15,%eax
     fe0:	cd 40                	int    $0x40
     fe2:	c3                   	ret

00000fe3 <kill>:
SYSCALL(kill)
     fe3:	b8 06 00 00 00       	mov    $0x6,%eax
     fe8:	cd 40                	int    $0x40
     fea:	c3                   	ret

00000feb <exec>:
SYSCALL(exec)
     feb:	b8 07 00 00 00       	mov    $0x7,%eax
     ff0:	cd 40                	int    $0x40
     ff2:	c3                   	ret

00000ff3 <open>:
SYSCALL(open)
     ff3:	b8 0f 00 00 00       	mov    $0xf,%eax
     ff8:	cd 40                	int    $0x40
     ffa:	c3                   	ret

00000ffb <mknod>:
SYSCALL(mknod)
     ffb:	b8 11 00 00 00       	mov    $0x11,%eax
    1000:	cd 40                	int    $0x40
    1002:	c3                   	ret

00001003 <unlink>:
SYSCALL(unlink)
    1003:	b8 12 00 00 00       	mov    $0x12,%eax
    1008:	cd 40                	int    $0x40
    100a:	c3                   	ret

0000100b <fstat>:
SYSCALL(fstat)
    100b:	b8 08 00 00 00       	mov    $0x8,%eax
    1010:	cd 40                	int    $0x40
    1012:	c3                   	ret

00001013 <link>:
SYSCALL(link)
    1013:	b8 13 00 00 00       	mov    $0x13,%eax
    1018:	cd 40                	int    $0x40
    101a:	c3                   	ret

0000101b <mkdir>:
SYSCALL(mkdir)
    101b:	b8 14 00 00 00       	mov    $0x14,%eax
    1020:	cd 40                	int    $0x40
    1022:	c3                   	ret

00001023 <chdir>:
SYSCALL(chdir)
    1023:	b8 09 00 00 00       	mov    $0x9,%eax
    1028:	cd 40                	int    $0x40
    102a:	c3                   	ret

0000102b <dup>:
SYSCALL(dup)
    102b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1030:	cd 40                	int    $0x40
    1032:	c3                   	ret

00001033 <getpid>:
SYSCALL(getpid)
    1033:	b8 0b 00 00 00       	mov    $0xb,%eax
    1038:	cd 40                	int    $0x40
    103a:	c3                   	ret

0000103b <sbrk>:
SYSCALL(sbrk)
    103b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1040:	cd 40                	int    $0x40
    1042:	c3                   	ret

00001043 <sleep>:
SYSCALL(sleep)
    1043:	b8 0d 00 00 00       	mov    $0xd,%eax
    1048:	cd 40                	int    $0x40
    104a:	c3                   	ret

0000104b <uptime>:
SYSCALL(uptime)
    104b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1050:	cd 40                	int    $0x40
    1052:	c3                   	ret

00001053 <worldpeace>:
SYSCALL(worldpeace)
    1053:	b8 16 00 00 00       	mov    $0x16,%eax
    1058:	cd 40                	int    $0x40
    105a:	c3                   	ret

0000105b <numberofprocesses>:
SYSCALL(numberofprocesses)
    105b:	b8 17 00 00 00       	mov    $0x17,%eax
    1060:	cd 40                	int    $0x40
    1062:	c3                   	ret

00001063 <whatsthestatus>:
SYSCALL(whatsthestatus)
    1063:	b8 18 00 00 00       	mov    $0x18,%eax
    1068:	cd 40                	int    $0x40
    106a:	c3                   	ret

0000106b <get_sibling>:
SYSCALL(get_sibling)
    106b:	b8 19 00 00 00       	mov    $0x19,%eax
    1070:	cd 40                	int    $0x40
    1072:	c3                   	ret

00001073 <spawn>:
SYSCALL(spawn)
    1073:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1078:	cd 40                	int    $0x40
    107a:	c3                   	ret

0000107b <getvasize>:
SYSCALL(getvasize)
    107b:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1080:	cd 40                	int    $0x40
    1082:	c3                   	ret

00001083 <va2pa>:
SYSCALL(va2pa)
    1083:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1088:	cd 40                	int    $0x40
    108a:	c3                   	ret

0000108b <get_pgtb_size>:
SYSCALL(get_pgtb_size)
    108b:	b8 1d 00 00 00       	mov    $0x1d,%eax
    1090:	cd 40                	int    $0x40
    1092:	c3                   	ret

00001093 <get_usr_pgtb_size>:
SYSCALL(get_usr_pgtb_size)
    1093:	b8 1e 00 00 00       	mov    $0x1e,%eax
    1098:	cd 40                	int    $0x40
    109a:	c3                   	ret

0000109b <get_kernel_pgtb_size>:
SYSCALL(get_kernel_pgtb_size)
    109b:	b8 1f 00 00 00       	mov    $0x1f,%eax
    10a0:	cd 40                	int    $0x40
    10a2:	c3                   	ret

000010a3 <getpasize>:
SYSCALL(getpasize)
    10a3:	b8 20 00 00 00       	mov    $0x20,%eax
    10a8:	cd 40                	int    $0x40
    10aa:	c3                   	ret
    10ab:	66 90                	xchg   %ax,%ax
    10ad:	66 90                	xchg   %ax,%ax
    10af:	90                   	nop

000010b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	57                   	push   %edi
    10b4:	56                   	push   %esi
    10b5:	53                   	push   %ebx
    10b6:	89 cb                	mov    %ecx,%ebx
    10b8:	83 ec 4c             	sub    $0x4c,%esp
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    10bb:	89 d1                	mov    %edx,%ecx
{
    10bd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  if(sgn && xx < 0){
    10c0:	89 d0                	mov    %edx,%eax
    10c2:	c1 e8 1f             	shr    $0x1f,%eax
    10c5:	84 c0                	test   %al,%al
    10c7:	0f 84 93 00 00 00    	je     1160 <printint+0xb0>
    10cd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    10d1:	0f 84 89 00 00 00    	je     1160 <printint+0xb0>
    x = -xx;
    10d7:	f7 d9                	neg    %ecx
    neg = 1;
    10d9:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
    10de:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    10e5:	8d 75 d7             	lea    -0x29(%ebp),%esi
    10e8:	89 45 b8             	mov    %eax,-0x48(%ebp)
    10eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    10f0:	89 c8                	mov    %ecx,%eax
    10f2:	31 d2                	xor    %edx,%edx
    10f4:	8b 7d c4             	mov    -0x3c(%ebp),%edi
    10f7:	f7 f3                	div    %ebx
    10f9:	89 45 c0             	mov    %eax,-0x40(%ebp)
    10fc:	0f b6 92 60 16 00 00 	movzbl 0x1660(%edx),%edx
    1103:	8d 47 01             	lea    0x1(%edi),%eax
    1106:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    1109:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
    110d:	89 ca                	mov    %ecx,%edx
  }while((x /= base) != 0);
    110f:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    1112:	39 da                	cmp    %ebx,%edx
    1114:	73 da                	jae    10f0 <printint+0x40>
  if(neg)
    1116:	8b 45 b8             	mov    -0x48(%ebp),%eax
    1119:	85 c0                	test   %eax,%eax
    111b:	74 0a                	je     1127 <printint+0x77>
    buf[i++] = '-';
    111d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1120:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    1125:	89 c7                	mov    %eax,%edi

  while(--i >= 0)
    1127:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    112a:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
    112e:	66 90                	xchg   %ax,%ax
    putc(fd, buf[i]);
    1130:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    1133:	89 74 24 04          	mov    %esi,0x4(%esp)
    1137:	88 45 d7             	mov    %al,-0x29(%ebp)
    113a:	b8 01 00 00 00       	mov    $0x1,%eax
    113f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1143:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1146:	89 04 24             	mov    %eax,(%esp)
    1149:	e8 85 fe ff ff       	call   fd3 <write>
  while(--i >= 0)
    114e:	89 f8                	mov    %edi,%eax
    1150:	4f                   	dec    %edi
    1151:	39 d8                	cmp    %ebx,%eax
    1153:	75 db                	jne    1130 <printint+0x80>
}
    1155:	83 c4 4c             	add    $0x4c,%esp
    1158:	5b                   	pop    %ebx
    1159:	5e                   	pop    %esi
    115a:	5f                   	pop    %edi
    115b:	5d                   	pop    %ebp
    115c:	c3                   	ret
    115d:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
    1160:	31 c0                	xor    %eax,%eax
    1162:	e9 77 ff ff ff       	jmp    10de <printint+0x2e>
    1167:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    116e:	00 
    116f:	90                   	nop

00001170 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	57                   	push   %edi
    1174:	56                   	push   %esi
    1175:	53                   	push   %ebx
    1176:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1179:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    117c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    117f:	0f b6 13             	movzbl (%ebx),%edx
    1182:	43                   	inc    %ebx
    1183:	84 d2                	test   %dl,%dl
    1185:	74 35                	je     11bc <printf+0x4c>
    1187:	8d 45 10             	lea    0x10(%ebp),%eax
    118a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    118d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    1190:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if(c == '%'){
    1193:	83 f8 25             	cmp    $0x25,%eax
    1196:	74 30                	je     11c8 <printf+0x58>
  write(fd, &c, 1);
    1198:	89 34 24             	mov    %esi,(%esp)
    119b:	b8 01 00 00 00       	mov    $0x1,%eax
  for(i = 0; fmt[i]; i++){
    11a0:	43                   	inc    %ebx
  write(fd, &c, 1);
    11a1:	89 44 24 08          	mov    %eax,0x8(%esp)
    11a5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    11ac:	88 55 e7             	mov    %dl,-0x19(%ebp)
    11af:	e8 1f fe ff ff       	call   fd3 <write>
  for(i = 0; fmt[i]; i++){
    11b4:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    11b8:	84 d2                	test   %dl,%dl
    11ba:	75 d4                	jne    1190 <printf+0x20>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    11bc:	83 c4 3c             	add    $0x3c,%esp
    11bf:	5b                   	pop    %ebx
    11c0:	5e                   	pop    %esi
    11c1:	5f                   	pop    %edi
    11c2:	5d                   	pop    %ebp
    11c3:	c3                   	ret
    11c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    11c8:	0f b6 13             	movzbl (%ebx),%edx
    11cb:	84 d2                	test   %dl,%dl
    11cd:	74 ed                	je     11bc <printf+0x4c>
    c = fmt[i] & 0xff;
    11cf:	80 fa 25             	cmp    $0x25,%dl
    11d2:	0f b6 c2             	movzbl %dl,%eax
      if(c == 'd'){
    11d5:	0f 84 75 01 00 00    	je     1350 <printf+0x1e0>
    11db:	83 e8 63             	sub    $0x63,%eax
    11de:	83 f8 15             	cmp    $0x15,%eax
    11e1:	77 0d                	ja     11f0 <printf+0x80>
    11e3:	ff 24 85 08 16 00 00 	jmp    *0x1608(,%eax,4)
    11ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    11f0:	89 34 24             	mov    %esi,(%esp)
    11f3:	8d 7d e7             	lea    -0x19(%ebp),%edi
    11f6:	b8 01 00 00 00       	mov    $0x1,%eax
    11fb:	89 44 24 08          	mov    %eax,0x8(%esp)
    11ff:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1203:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
    1206:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
    120a:	e8 c4 fd ff ff       	call   fd3 <write>
        putc(fd, c);
    120f:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
    1213:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    1216:	ba 01 00 00 00       	mov    $0x1,%edx
    121b:	89 54 24 08          	mov    %edx,0x8(%esp)
    121f:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for(i = 0; fmt[i]; i++){
    1223:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
    1226:	89 34 24             	mov    %esi,(%esp)
    1229:	e8 a5 fd ff ff       	call   fd3 <write>
  for(i = 0; fmt[i]; i++){
    122e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1232:	84 d2                	test   %dl,%dl
    1234:	0f 85 56 ff ff ff    	jne    1190 <printf+0x20>
}
    123a:	83 c4 3c             	add    $0x3c,%esp
    123d:	5b                   	pop    %ebx
    123e:	5e                   	pop    %esi
    123f:	5f                   	pop    %edi
    1240:	5d                   	pop    %ebp
    1241:	c3                   	ret
    1242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1248:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    124b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1250:	8b 17                	mov    (%edi),%edx
    1252:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        ap++;
    1259:	83 c7 04             	add    $0x4,%edi
        printint(fd, *ap, 16, 0);
    125c:	89 f0                	mov    %esi,%eax
    125e:	e8 4d fe ff ff       	call   10b0 <printint>
  for(i = 0; fmt[i]; i++){
    1263:	83 c3 02             	add    $0x2,%ebx
        ap++;
    1266:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
    1269:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    126d:	84 d2                	test   %dl,%dl
    126f:	0f 85 1b ff ff ff    	jne    1190 <printf+0x20>
}
    1275:	83 c4 3c             	add    $0x3c,%esp
    1278:	5b                   	pop    %ebx
    1279:	5e                   	pop    %esi
    127a:	5f                   	pop    %edi
    127b:	5d                   	pop    %ebp
    127c:	c3                   	ret
    127d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
    1280:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1283:	8b 01                	mov    (%ecx),%eax
        ap++;
    1285:	83 c1 04             	add    $0x4,%ecx
    1288:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
    128b:	85 c0                	test   %eax,%eax
    128d:	0f 84 d5 00 00 00    	je     1368 <printf+0x1f8>
        while(*s != 0){
    1293:	0f b6 10             	movzbl (%eax),%edx
    1296:	84 d2                	test   %dl,%dl
    1298:	74 39                	je     12d3 <printf+0x163>
    129a:	89 c7                	mov    %eax,%edi
    129c:	88 d0                	mov    %dl,%al
    129e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    12a1:	8d 4d e7             	lea    -0x19(%ebp),%ecx
    12a4:	89 fb                	mov    %edi,%ebx
    12a6:	89 cf                	mov    %ecx,%edi
    12a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    12af:	00 
          putc(fd, *s);
    12b0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    12b3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    12b8:	43                   	inc    %ebx
  write(fd, &c, 1);
    12b9:	89 44 24 08          	mov    %eax,0x8(%esp)
    12bd:	89 7c 24 04          	mov    %edi,0x4(%esp)
    12c1:	89 34 24             	mov    %esi,(%esp)
    12c4:	e8 0a fd ff ff       	call   fd3 <write>
        while(*s != 0){
    12c9:	0f b6 03             	movzbl (%ebx),%eax
    12cc:	84 c0                	test   %al,%al
    12ce:	75 e0                	jne    12b0 <printf+0x140>
    12d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
    12d3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
    12d7:	83 c3 02             	add    $0x2,%ebx
    12da:	84 d2                	test   %dl,%dl
    12dc:	0f 85 ae fe ff ff    	jne    1190 <printf+0x20>
    12e2:	e9 d5 fe ff ff       	jmp    11bc <printf+0x4c>
    12e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    12ee:	00 
    12ef:	90                   	nop
        printint(fd, *ap, 10, 1);
    12f0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    12f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    12f8:	8b 17                	mov    (%edi),%edx
    12fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1301:	e9 53 ff ff ff       	jmp    1259 <printf+0xe9>
    1306:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    130d:	00 
    130e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
    1310:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
    1313:	bf 01 00 00 00       	mov    $0x1,%edi
  for(i = 0; fmt[i]; i++){
    1318:	83 c3 02             	add    $0x2,%ebx
        putc(fd, *ap);
    131b:	8b 08                	mov    (%eax),%ecx
  write(fd, &c, 1);
    131d:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1321:	8d 7d e7             	lea    -0x19(%ebp),%edi
    1324:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1328:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
    132b:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    132e:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
    1332:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1335:	e8 99 fc ff ff       	call   fd3 <write>
        ap++;
    133a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
    133e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1342:	84 d2                	test   %dl,%dl
    1344:	0f 85 46 fe ff ff    	jne    1190 <printf+0x20>
    134a:	e9 6d fe ff ff       	jmp    11bc <printf+0x4c>
    134f:	90                   	nop
        putc(fd, c);
    1350:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    1353:	8d 7d e7             	lea    -0x19(%ebp),%edi
    1356:	b9 01 00 00 00       	mov    $0x1,%ecx
    135b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    135f:	e9 bb fe ff ff       	jmp    121f <printf+0xaf>
    1364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
    1368:	bf cf 15 00 00       	mov    $0x15cf,%edi
    136d:	b0 28                	mov    $0x28,%al
    136f:	e9 2a ff ff ff       	jmp    129e <printf+0x12e>
    1374:	66 90                	xchg   %ax,%ax
    1376:	66 90                	xchg   %ax,%ax
    1378:	66 90                	xchg   %ax,%ax
    137a:	66 90                	xchg   %ax,%ax
    137c:	66 90                	xchg   %ax,%ax
    137e:	66 90                	xchg   %ax,%ax

00001380 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1380:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1381:	a1 04 17 00 00       	mov    0x1704,%eax
{
    1386:	89 e5                	mov    %esp,%ebp
    1388:	57                   	push   %edi
    1389:	56                   	push   %esi
    138a:	53                   	push   %ebx
    138b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    138e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1391:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1398:	00 
    1399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13a0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13a2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13a4:	39 ca                	cmp    %ecx,%edx
    13a6:	73 30                	jae    13d8 <free+0x58>
    13a8:	39 c1                	cmp    %eax,%ecx
    13aa:	72 04                	jb     13b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13ac:	39 c2                	cmp    %eax,%edx
    13ae:	72 f0                	jb     13a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    13b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    13b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    13b6:	39 f8                	cmp    %edi,%eax
    13b8:	74 36                	je     13f0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    13ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    13bd:	8b 42 04             	mov    0x4(%edx),%eax
    13c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    13c3:	39 f1                	cmp    %esi,%ecx
    13c5:	74 42                	je     1409 <free+0x89>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    13c7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    13c9:	5b                   	pop    %ebx
  freep = p;
    13ca:	89 15 04 17 00 00    	mov    %edx,0x1704
}
    13d0:	5e                   	pop    %esi
    13d1:	5f                   	pop    %edi
    13d2:	5d                   	pop    %ebp
    13d3:	c3                   	ret
    13d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13d8:	39 c2                	cmp    %eax,%edx
    13da:	72 c4                	jb     13a0 <free+0x20>
    13dc:	39 c1                	cmp    %eax,%ecx
    13de:	73 c0                	jae    13a0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
    13e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    13e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    13e6:	39 f8                	cmp    %edi,%eax
    13e8:	75 d0                	jne    13ba <free+0x3a>
    13ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
    13f0:	8b 78 04             	mov    0x4(%eax),%edi
    13f3:	01 fe                	add    %edi,%esi
    13f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    13f8:	8b 02                	mov    (%edx),%eax
    13fa:	8b 00                	mov    (%eax),%eax
    13fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    13ff:	8b 42 04             	mov    0x4(%edx),%eax
    1402:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1405:	39 f1                	cmp    %esi,%ecx
    1407:	75 be                	jne    13c7 <free+0x47>
  freep = p;
    1409:	89 15 04 17 00 00    	mov    %edx,0x1704
    p->s.size += bp->s.size;
    140f:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    1412:	01 c8                	add    %ecx,%eax
    1414:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1417:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    141a:	89 0a                	mov    %ecx,(%edx)
}
    141c:	5b                   	pop    %ebx
    141d:	5e                   	pop    %esi
    141e:	5f                   	pop    %edi
    141f:	5d                   	pop    %ebp
    1420:	c3                   	ret
    1421:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1428:	00 
    1429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001430 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	57                   	push   %edi
    1434:	56                   	push   %esi
    1435:	53                   	push   %ebx
    1436:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1439:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    143c:	8b 15 04 17 00 00    	mov    0x1704,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1442:	8d 78 07             	lea    0x7(%eax),%edi
    1445:	c1 ef 03             	shr    $0x3,%edi
    1448:	47                   	inc    %edi
  if((prevp = freep) == 0){
    1449:	85 d2                	test   %edx,%edx
    144b:	0f 84 8f 00 00 00    	je     14e0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1451:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1453:	8b 48 04             	mov    0x4(%eax),%ecx
    1456:	39 f9                	cmp    %edi,%ecx
    1458:	73 5e                	jae    14b8 <malloc+0x88>
  if(nu < 4096)
    145a:	bb 00 10 00 00       	mov    $0x1000,%ebx
    145f:	39 df                	cmp    %ebx,%edi
    1461:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1464:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    146b:	eb 0c                	jmp    1479 <malloc+0x49>
    146d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1470:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1472:	8b 48 04             	mov    0x4(%eax),%ecx
    1475:	39 f9                	cmp    %edi,%ecx
    1477:	73 3f                	jae    14b8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1479:	39 05 04 17 00 00    	cmp    %eax,0x1704
    147f:	89 c2                	mov    %eax,%edx
    1481:	75 ed                	jne    1470 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1483:	89 34 24             	mov    %esi,(%esp)
    1486:	e8 b0 fb ff ff       	call   103b <sbrk>
  if(p == (char*)-1)
    148b:	83 f8 ff             	cmp    $0xffffffff,%eax
    148e:	74 18                	je     14a8 <malloc+0x78>
  hp->s.size = nu;
    1490:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1493:	83 c0 08             	add    $0x8,%eax
    1496:	89 04 24             	mov    %eax,(%esp)
    1499:	e8 e2 fe ff ff       	call   1380 <free>
  return freep;
    149e:	8b 15 04 17 00 00    	mov    0x1704,%edx
      if((p = morecore(nunits)) == 0)
    14a4:	85 d2                	test   %edx,%edx
    14a6:	75 c8                	jne    1470 <malloc+0x40>
        return 0;
  }
}
    14a8:	83 c4 1c             	add    $0x1c,%esp
        return 0;
    14ab:	31 c0                	xor    %eax,%eax
}
    14ad:	5b                   	pop    %ebx
    14ae:	5e                   	pop    %esi
    14af:	5f                   	pop    %edi
    14b0:	5d                   	pop    %ebp
    14b1:	c3                   	ret
    14b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    14b8:	39 cf                	cmp    %ecx,%edi
    14ba:	74 54                	je     1510 <malloc+0xe0>
        p->s.size -= nunits;
    14bc:	29 f9                	sub    %edi,%ecx
    14be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    14c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    14c4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    14c7:	89 15 04 17 00 00    	mov    %edx,0x1704
}
    14cd:	83 c4 1c             	add    $0x1c,%esp
      return (void*)(p + 1);
    14d0:	83 c0 08             	add    $0x8,%eax
}
    14d3:	5b                   	pop    %ebx
    14d4:	5e                   	pop    %esi
    14d5:	5f                   	pop    %edi
    14d6:	5d                   	pop    %ebp
    14d7:	c3                   	ret
    14d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    14df:	00 
    base.s.ptr = freep = prevp = &base;
    14e0:	b8 08 17 00 00       	mov    $0x1708,%eax
    14e5:	ba 08 17 00 00       	mov    $0x1708,%edx
    14ea:	a3 04 17 00 00       	mov    %eax,0x1704
    base.s.size = 0;
    14ef:	31 c9                	xor    %ecx,%ecx
    14f1:	b8 08 17 00 00       	mov    $0x1708,%eax
    base.s.ptr = freep = prevp = &base;
    14f6:	89 15 08 17 00 00    	mov    %edx,0x1708
    base.s.size = 0;
    14fc:	89 0d 0c 17 00 00    	mov    %ecx,0x170c
    if(p->s.size >= nunits){
    1502:	e9 53 ff ff ff       	jmp    145a <malloc+0x2a>
    1507:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    150e:	00 
    150f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
    1510:	8b 08                	mov    (%eax),%ecx
    1512:	89 0a                	mov    %ecx,(%edx)
    1514:	eb b1                	jmp    14c7 <malloc+0x97>
