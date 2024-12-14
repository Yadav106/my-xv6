
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 64 11 80       	mov    $0x801164d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 31 10 80       	mov    $0x80103110,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100041:	ba 80 7a 10 80       	mov    $0x80107a80,%edx
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	83 ec 18             	sub    $0x18,%esp
8010004b:	89 5d fc             	mov    %ebx,-0x4(%ebp)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
8010004e:	bb 1c fc 10 80       	mov    $0x8010fc1c,%ebx
  initlock(&bcache.lock, "bcache");
80100053:	89 54 24 04          	mov    %edx,0x4(%esp)
80100057:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010005e:	e8 3d 48 00 00       	call   801048a0 <initlock>
  bcache.head.prev = &bcache.head;
80100063:	b9 1c fc 10 80       	mov    $0x8010fc1c,%ecx
  bcache.head.next = &bcache.head;
80100068:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
8010006d:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100073:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
  bcache.head.prev = &bcache.head;
80100078:	89 0d 6c fc 10 80    	mov    %ecx,0x8010fc6c
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007e:	eb 02                	jmp    80100082 <binit+0x42>
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	b8 87 7a 10 80       	mov    $0x80107a87,%eax
    b->prev = &bcache.head;
8010008a:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 c0 46 00 00       	call   80104760 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a5:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000ab:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
    bcache.head.next->prev = b;
801000b1:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000b4:	89 d8                	mov    %ebx,%eax
801000b6:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	89 ec                	mov    %ebp,%esp
801000c3:	5d                   	pop    %ebp
801000c4:	c3                   	ret
801000c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000cc:	00 
801000cd:	8d 76 00             	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&bcache.lock);
801000d9:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
{
801000e0:	8b 75 08             	mov    0x8(%ebp),%esi
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 b5 49 00 00       	call   80104aa0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000f1:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	ff 43 4c             	incl   0x4c(%ebx)
      release(&bcache.lock);
80100118:	eb 40                	jmp    8010015a <bread+0x8a>
8010011a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 62                	jmp    80100192 <bread+0xc2>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 57                	je     80100192 <bread+0xc2>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100161:	e8 ca 48 00 00       	call   80104a30 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 2f 46 00 00       	call   801047a0 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	74 0a                	je     80100180 <bread+0xb0>
    iderw(b);
  }
  return b;
}
80100176:	83 c4 1c             	add    $0x1c,%esp
80100179:	89 d8                	mov    %ebx,%eax
8010017b:	5b                   	pop    %ebx
8010017c:	5e                   	pop    %esi
8010017d:	5f                   	pop    %edi
8010017e:	5d                   	pop    %ebp
8010017f:	c3                   	ret
    iderw(b);
80100180:	89 1c 24             	mov    %ebx,(%esp)
80100183:	e8 48 22 00 00       	call   801023d0 <iderw>
}
80100188:	83 c4 1c             	add    $0x1c,%esp
8010018b:	89 d8                	mov    %ebx,%eax
8010018d:	5b                   	pop    %ebx
8010018e:	5e                   	pop    %esi
8010018f:	5f                   	pop    %edi
80100190:	5d                   	pop    %ebp
80100191:	c3                   	ret
  panic("bget: no buffers");
80100192:	c7 04 24 8e 7a 10 80 	movl   $0x80107a8e,(%esp)
80100199:	e8 b2 01 00 00       	call   80100350 <panic>
8010019e:	66 90                	xchg   %ax,%ax

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	83 ec 18             	sub    $0x18,%esp
801001a6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
801001a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ac:	8d 43 0c             	lea    0xc(%ebx),%eax
801001af:	89 04 24             	mov    %eax,(%esp)
801001b2:	e8 89 46 00 00       	call   80104840 <holdingsleep>
801001b7:	85 c0                	test   %eax,%eax
801001b9:	74 11                	je     801001cc <bwrite+0x2c>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001bb:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001be:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c4:	89 ec                	mov    %ebp,%esp
801001c6:	5d                   	pop    %ebp
  iderw(b);
801001c7:	e9 04 22 00 00       	jmp    801023d0 <iderw>
    panic("bwrite");
801001cc:	c7 04 24 9f 7a 10 80 	movl   $0x80107a9f,(%esp)
801001d3:	e8 78 01 00 00       	call   80100350 <panic>
801001d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001df:	00 

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 4a 46 00 00       	call   80104840 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 57                	je     80100251 <brelse+0x71>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 fe 45 00 00       	call   80104800 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
80100209:	e8 92 48 00 00       	call   80104aa0 <acquire>
  b->refcnt--;
8010020e:	ff 4b 4c             	decl   0x4c(%ebx)
  if (b->refcnt == 0) {
80100211:	75 2c                	jne    8010023f <brelse+0x5f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100213:	8b 53 54             	mov    0x54(%ebx),%edx
80100216:	8b 43 50             	mov    0x50(%ebx),%eax
80100219:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
8010021c:	8b 53 54             	mov    0x54(%ebx),%edx
8010021f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100222:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100227:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010022e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100231:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100236:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100239:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010023f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100246:	83 c4 10             	add    $0x10,%esp
80100249:	5b                   	pop    %ebx
8010024a:	5e                   	pop    %esi
8010024b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010024c:	e9 df 47 00 00       	jmp    80104a30 <release>
    panic("brelse");
80100251:	c7 04 24 a6 7a 10 80 	movl   $0x80107aa6,(%esp)
80100258:	e8 f3 00 00 00       	call   80100350 <panic>
8010025d:	66 90                	xchg   %ax,%ax
8010025f:	90                   	nop

80100260 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100260:	55                   	push   %ebp
80100261:	89 e5                	mov    %esp,%ebp
80100263:	57                   	push   %edi
80100264:	56                   	push   %esi
80100265:	53                   	push   %ebx
80100266:	83 ec 2c             	sub    $0x2c,%esp
80100269:	8b 7d 08             	mov    0x8(%ebp),%edi
8010026c:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010026f:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
80100272:	89 3c 24             	mov    %edi,(%esp)
80100275:	e8 a6 16 00 00       	call   80101920 <iunlock>
  target = n;
  acquire(&cons.lock);
8010027a:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
  target = n;
80100281:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
80100284:	e8 17 48 00 00       	call   80104aa0 <acquire>
  while(n > 0){
80100289:	85 db                	test   %ebx,%ebx
8010028b:	0f 8e 86 00 00 00    	jle    80100317 <consoleread+0xb7>
    while(input.r == input.w){
80100291:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80100296:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
8010029c:	74 24                	je     801002c2 <consoleread+0x62>
8010029e:	eb 50                	jmp    801002f0 <consoleread+0x90>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002a0:	c7 04 24 00 ff 10 80 	movl   $0x8010ff00,(%esp)
801002a7:	b8 20 ff 10 80       	mov    $0x8010ff20,%eax
801002ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801002b0:	e8 8b 40 00 00       	call   80104340 <sleep>
    while(input.r == input.w){
801002b5:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002ba:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002c0:	75 2e                	jne    801002f0 <consoleread+0x90>
      if(myproc()->killed){
801002c2:	e8 b9 39 00 00       	call   80103c80 <myproc>
801002c7:	8b 50 24             	mov    0x24(%eax),%edx
801002ca:	85 d2                	test   %edx,%edx
801002cc:	74 d2                	je     801002a0 <consoleread+0x40>
        release(&cons.lock);
801002ce:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002d5:	e8 56 47 00 00       	call   80104a30 <release>
        ilock(ip);
801002da:	89 3c 24             	mov    %edi,(%esp)
801002dd:	e8 5e 15 00 00       	call   80101840 <ilock>
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002e2:	83 c4 2c             	add    $0x2c,%esp
        return -1;
801002e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801002ea:	5b                   	pop    %ebx
801002eb:	5e                   	pop    %esi
801002ec:	5f                   	pop    %edi
801002ed:	5d                   	pop    %ebp
801002ee:	c3                   	ret
801002ef:	90                   	nop
    c = input.buf[input.r++ % INPUT_BUF];
801002f0:	8d 50 01             	lea    0x1(%eax),%edx
801002f3:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
801002f9:	89 c2                	mov    %eax,%edx
801002fb:	83 e2 7f             	and    $0x7f,%edx
801002fe:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
80100305:	80 f9 04             	cmp    $0x4,%cl
80100308:	74 2e                	je     80100338 <consoleread+0xd8>
    *dst++ = c;
8010030a:	88 0e                	mov    %cl,(%esi)
8010030c:	46                   	inc    %esi
    --n;
8010030d:	4b                   	dec    %ebx
    if(c == '\n')
8010030e:	83 f9 0a             	cmp    $0xa,%ecx
80100311:	0f 85 72 ff ff ff    	jne    80100289 <consoleread+0x29>
  release(&cons.lock);
80100317:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010031e:	e8 0d 47 00 00       	call   80104a30 <release>
  ilock(ip);
80100323:	89 3c 24             	mov    %edi,(%esp)
80100326:	e8 15 15 00 00       	call   80101840 <ilock>
  return target - n;
8010032b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
8010032e:	83 c4 2c             	add    $0x2c,%esp
  return target - n;
80100331:	29 d8                	sub    %ebx,%eax
}
80100333:	5b                   	pop    %ebx
80100334:	5e                   	pop    %esi
80100335:	5f                   	pop    %edi
80100336:	5d                   	pop    %ebp
80100337:	c3                   	ret
      if(n < target){
80100338:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010033b:	39 cb                	cmp    %ecx,%ebx
8010033d:	73 d8                	jae    80100317 <consoleread+0xb7>
        input.r--;
8010033f:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100344:	eb d1                	jmp    80100317 <consoleread+0xb7>
80100346:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010034d:	00 
8010034e:	66 90                	xchg   %ax,%ax

80100350 <panic>:
{
80100350:	55                   	push   %ebp
80100351:	89 e5                	mov    %esp,%ebp
80100353:	53                   	push   %ebx
80100354:	83 ec 44             	sub    $0x44,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100357:	fa                   	cli
  getcallerpcs(&s, pcs);
80100358:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cons.locking = 0;
8010035b:	31 d2                	xor    %edx,%edx
8010035d:	89 15 54 ff 10 80    	mov    %edx,0x8010ff54
  cprintf("lapicid %d: panic: ", lapicid());
80100363:	e8 68 26 00 00       	call   801029d0 <lapicid>
80100368:	c7 04 24 ad 7a 10 80 	movl   $0x80107aad,(%esp)
8010036f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100373:	e8 08 03 00 00       	call   80100680 <cprintf>
  cprintf(s);
80100378:	8b 45 08             	mov    0x8(%ebp),%eax
8010037b:	89 04 24             	mov    %eax,(%esp)
8010037e:	e8 fd 02 00 00       	call   80100680 <cprintf>
  cprintf("\n");
80100383:	c7 04 24 6b 7f 10 80 	movl   $0x80107f6b,(%esp)
8010038a:	e8 f1 02 00 00       	call   80100680 <cprintf>
  getcallerpcs(&s, pcs);
8010038f:	8d 45 08             	lea    0x8(%ebp),%eax
80100392:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100396:	89 04 24             	mov    %eax,(%esp)
80100399:	e8 22 45 00 00       	call   801048c0 <getcallerpcs>
  for(i=0; i<10; i++)
8010039e:	66 90                	xchg   %ax,%ax
    cprintf(" %p", pcs[i]);
801003a0:	8b 03                	mov    (%ebx),%eax
  for(i=0; i<10; i++)
801003a2:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003a5:	c7 04 24 c1 7a 10 80 	movl   $0x80107ac1,(%esp)
801003ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801003b0:	e8 cb 02 00 00       	call   80100680 <cprintf>
  for(i=0; i<10; i++)
801003b5:	8d 45 f8             	lea    -0x8(%ebp),%eax
801003b8:	39 c3                	cmp    %eax,%ebx
801003ba:	75 e4                	jne    801003a0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003bc:	b8 01 00 00 00       	mov    $0x1,%eax
801003c1:	a3 58 ff 10 80       	mov    %eax,0x8010ff58
  for(;;)
801003c6:	eb fe                	jmp    801003c6 <panic+0x76>
801003c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801003cf:	00 

801003d0 <consputc.part.0>:
consputc(int c)
801003d0:	55                   	push   %ebp
801003d1:	89 e5                	mov    %esp,%ebp
801003d3:	56                   	push   %esi
801003d4:	53                   	push   %ebx
801003d5:	83 ec 20             	sub    $0x20,%esp
  if(c == BACKSPACE){
801003d8:	3d 00 01 00 00       	cmp    $0x100,%eax
801003dd:	0f 84 bd 00 00 00    	je     801004a0 <consputc.part.0+0xd0>
    uartputc(c);
801003e3:	89 04 24             	mov    %eax,(%esp)
801003e6:	89 c3                	mov    %eax,%ebx
801003e8:	e8 53 60 00 00       	call   80106440 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003ed:	b0 0e                	mov    $0xe,%al
801003ef:	ba d4 03 00 00       	mov    $0x3d4,%edx
801003f4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003f5:	be d5 03 00 00       	mov    $0x3d5,%esi
801003fa:	89 f2                	mov    %esi,%edx
801003fc:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801003fd:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100400:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100405:	c1 e1 08             	shl    $0x8,%ecx
80100408:	b0 0f                	mov    $0xf,%al
8010040a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010040b:	89 f2                	mov    %esi,%edx
8010040d:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010040e:	0f b6 c0             	movzbl %al,%eax
80100411:	09 c8                	or     %ecx,%eax
  if(c == '\n')
80100413:	83 fb 0a             	cmp    $0xa,%ebx
80100416:	75 68                	jne    80100480 <consputc.part.0+0xb0>
    pos += 80 - pos%80;
80100418:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
8010041d:	f7 e2                	mul    %edx
8010041f:	c1 ea 06             	shr    $0x6,%edx
80100422:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100425:	c1 e0 04             	shl    $0x4,%eax
80100428:	8d 50 50             	lea    0x50(%eax),%edx
  if(pos < 0 || pos > 25*80)
8010042b:	81 fa d0 07 00 00    	cmp    $0x7d0,%edx
80100431:	0f 8f 29 01 00 00    	jg     80100560 <consputc.part.0+0x190>
  if((pos/80) >= 24){  // Scroll up.
80100437:	81 fa 7f 07 00 00    	cmp    $0x77f,%edx
8010043d:	0f 8f b5 00 00 00    	jg     801004f8 <consputc.part.0+0x128>
  outb(CRTPORT+1, pos);
80100443:	88 55 f4             	mov    %dl,-0xc(%ebp)
  crt[pos] = ' ' | 0x0700;
80100446:	8d b4 12 00 80 0b 80 	lea    -0x7ff48000(%edx,%edx,1),%esi
  outb(CRTPORT+1, pos>>8);
8010044d:	0f b6 ce             	movzbl %dh,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100450:	b0 0e                	mov    $0xe,%al
80100452:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100457:	ee                   	out    %al,(%dx)
80100458:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010045d:	88 c8                	mov    %cl,%al
8010045f:	89 da                	mov    %ebx,%edx
80100461:	ee                   	out    %al,(%dx)
80100462:	b0 0f                	mov    $0xf,%al
80100464:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100469:	ee                   	out    %al,(%dx)
8010046a:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
8010046e:	89 da                	mov    %ebx,%edx
80100470:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
80100471:	66 c7 06 20 07       	movw   $0x720,(%esi)
}
80100476:	83 c4 20             	add    $0x20,%esp
80100479:	5b                   	pop    %ebx
8010047a:	5e                   	pop    %esi
8010047b:	5d                   	pop    %ebp
8010047c:	c3                   	ret
8010047d:	8d 76 00             	lea    0x0(%esi),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100480:	8d 50 01             	lea    0x1(%eax),%edx
80100483:	0f b6 db             	movzbl %bl,%ebx
80100486:	81 cb 00 07 00 00    	or     $0x700,%ebx
8010048c:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100493:	80 
80100494:	eb 95                	jmp    8010042b <consputc.part.0+0x5b>
80100496:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010049d:	00 
8010049e:	66 90                	xchg   %ax,%ax
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004a0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004a7:	e8 94 5f 00 00       	call   80106440 <uartputc>
801004ac:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004b3:	e8 88 5f 00 00       	call   80106440 <uartputc>
801004b8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004bf:	e8 7c 5f 00 00       	call   80106440 <uartputc>
801004c4:	b0 0e                	mov    $0xe,%al
801004c6:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004cc:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801004d1:	89 da                	mov    %ebx,%edx
801004d3:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801004d4:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004d7:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004dc:	c1 e1 08             	shl    $0x8,%ecx
801004df:	b0 0f                	mov    $0xf,%al
801004e1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004e2:	89 da                	mov    %ebx,%edx
801004e4:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801004e5:	0f b6 d0             	movzbl %al,%edx
    if(pos > 0) --pos;
801004e8:	09 ca                	or     %ecx,%edx
801004ea:	74 64                	je     80100550 <consputc.part.0+0x180>
801004ec:	4a                   	dec    %edx
801004ed:	e9 39 ff ff ff       	jmp    8010042b <consputc.part.0+0x5b>
801004f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801004f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fb:	b8 60 0e 00 00       	mov    $0xe60,%eax
80100500:	ba a0 80 0b 80       	mov    $0x800b80a0,%edx
80100505:	89 54 24 04          	mov    %edx,0x4(%esp)
80100509:	89 44 24 08          	mov    %eax,0x8(%esp)
8010050d:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100514:	e8 17 47 00 00       	call   80104c30 <memmove>
    pos -= 80;
80100519:	8b 55 f4             	mov    -0xc(%ebp),%edx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010051c:	b8 80 07 00 00       	mov    $0x780,%eax
80100521:	31 c9                	xor    %ecx,%ecx
80100523:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    pos -= 80;
80100527:	8d 5a b0             	lea    -0x50(%edx),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010052a:	8d b4 12 60 7f 0b 80 	lea    -0x7ff480a0(%edx,%edx,1),%esi
80100531:	29 d8                	sub    %ebx,%eax
80100533:	89 34 24             	mov    %esi,(%esp)
80100536:	01 c0                	add    %eax,%eax
80100538:	89 44 24 08          	mov    %eax,0x8(%esp)
8010053c:	e8 5f 46 00 00       	call   80104ba0 <memset>
  outb(CRTPORT+1, pos);
80100541:	b1 07                	mov    $0x7,%cl
80100543:	88 5d f4             	mov    %bl,-0xc(%ebp)
80100546:	e9 05 ff ff ff       	jmp    80100450 <consputc.part.0+0x80>
8010054b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100550:	c6 45 f4 00          	movb   $0x0,-0xc(%ebp)
80100554:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100559:	31 c9                	xor    %ecx,%ecx
8010055b:	e9 f0 fe ff ff       	jmp    80100450 <consputc.part.0+0x80>
    panic("pos under/overflow");
80100560:	c7 04 24 c5 7a 10 80 	movl   $0x80107ac5,(%esp)
80100567:	e8 e4 fd ff ff       	call   80100350 <panic>
8010056c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100570 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	53                   	push   %ebx
80100576:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
80100579:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010057c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010057f:	89 04 24             	mov    %eax,(%esp)
80100582:	e8 99 13 00 00       	call   80101920 <iunlock>
  acquire(&cons.lock);
80100587:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010058e:	e8 0d 45 00 00       	call   80104aa0 <acquire>
  for(i = 0; i < n; i++)
80100593:	85 f6                	test   %esi,%esi
80100595:	7e 26                	jle    801005bd <consolewrite+0x4d>
80100597:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010059a:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
8010059d:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801005a2:	85 c0                	test   %eax,%eax
801005a4:	74 0a                	je     801005b0 <consolewrite+0x40>
  asm volatile("cli");
801005a6:	fa                   	cli
    for(;;)
801005a7:	eb fe                	jmp    801005a7 <consolewrite+0x37>
801005a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i] & 0xff);
801005b0:	0f b6 03             	movzbl (%ebx),%eax
  for(i = 0; i < n; i++)
801005b3:	43                   	inc    %ebx
801005b4:	e8 17 fe ff ff       	call   801003d0 <consputc.part.0>
801005b9:	39 fb                	cmp    %edi,%ebx
801005bb:	75 e0                	jne    8010059d <consolewrite+0x2d>
  release(&cons.lock);
801005bd:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005c4:	e8 67 44 00 00       	call   80104a30 <release>
  ilock(ip);
801005c9:	8b 45 08             	mov    0x8(%ebp),%eax
801005cc:	89 04 24             	mov    %eax,(%esp)
801005cf:	e8 6c 12 00 00       	call   80101840 <ilock>

  return n;
}
801005d4:	83 c4 1c             	add    $0x1c,%esp
801005d7:	89 f0                	mov    %esi,%eax
801005d9:	5b                   	pop    %ebx
801005da:	5e                   	pop    %esi
801005db:	5f                   	pop    %edi
801005dc:	5d                   	pop    %ebp
801005dd:	c3                   	ret
801005de:	66 90                	xchg   %ax,%ax

801005e0 <printint>:
{
801005e0:	55                   	push   %ebp
801005e1:	89 e5                	mov    %esp,%ebp
801005e3:	57                   	push   %edi
801005e4:	56                   	push   %esi
  if(sign && (sign = xx < 0))
801005e5:	89 c6                	mov    %eax,%esi
801005e7:	c1 ee 1f             	shr    $0x1f,%esi
{
801005ea:	53                   	push   %ebx
801005eb:	89 d3                	mov    %edx,%ebx
  if(sign && (sign = xx < 0))
801005ed:	89 f2                	mov    %esi,%edx
{
801005ef:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
801005f2:	84 d2                	test   %dl,%dl
801005f4:	74 05                	je     801005fb <printint+0x1b>
801005f6:	f6 c1 01             	test   $0x1,%cl
801005f9:	75 70                	jne    8010066b <printint+0x8b>
    x = xx;
801005fb:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
80100602:	89 c1                	mov    %eax,%ecx
  i = 0;
80100604:	31 f6                	xor    %esi,%esi
80100606:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010060d:	00 
8010060e:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100610:	89 c8                	mov    %ecx,%eax
80100612:	31 d2                	xor    %edx,%edx
80100614:	f7 f3                	div    %ebx
80100616:	89 f7                	mov    %esi,%edi
80100618:	8d 76 01             	lea    0x1(%esi),%esi
8010061b:	0f b6 92 bc 7f 10 80 	movzbl -0x7fef8044(%edx),%edx
80100622:	88 55 d7             	mov    %dl,-0x29(%ebp)
80100625:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
80100629:	89 ca                	mov    %ecx,%edx
8010062b:	89 c1                	mov    %eax,%ecx
8010062d:	39 da                	cmp    %ebx,%edx
8010062f:	73 df                	jae    80100610 <printint+0x30>
  if(sign)
80100631:	8b 55 d0             	mov    -0x30(%ebp),%edx
80100634:	85 d2                	test   %edx,%edx
80100636:	74 07                	je     8010063f <printint+0x5f>
    buf[i++] = '-';
80100638:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
8010063d:	89 f7                	mov    %esi,%edi
  while(--i >= 0)
8010063f:	8d 75 d8             	lea    -0x28(%ebp),%esi
80100642:	8d 5c 3d d8          	lea    -0x28(%ebp,%edi,1),%ebx
  if(panicked){
80100646:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010064b:	85 c0                	test   %eax,%eax
8010064d:	74 09                	je     80100658 <printint+0x78>
8010064f:	fa                   	cli
    for(;;)
80100650:	eb fe                	jmp    80100650 <printint+0x70>
80100652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
80100658:	0f be 03             	movsbl (%ebx),%eax
8010065b:	e8 70 fd ff ff       	call   801003d0 <consputc.part.0>
  while(--i >= 0)
80100660:	8d 43 ff             	lea    -0x1(%ebx),%eax
80100663:	39 f3                	cmp    %esi,%ebx
80100665:	74 11                	je     80100678 <printint+0x98>
80100667:	89 c3                	mov    %eax,%ebx
80100669:	eb db                	jmp    80100646 <printint+0x66>
  if(sign && (sign = xx < 0))
8010066b:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
    x = -xx;
80100672:	f7 d8                	neg    %eax
80100674:	89 c1                	mov    %eax,%ecx
80100676:	eb 8c                	jmp    80100604 <printint+0x24>
}
80100678:	83 c4 2c             	add    $0x2c,%esp
8010067b:	5b                   	pop    %ebx
8010067c:	5e                   	pop    %esi
8010067d:	5f                   	pop    %edi
8010067e:	5d                   	pop    %ebp
8010067f:	c3                   	ret

80100680 <cprintf>:
{
80100680:	55                   	push   %ebp
80100681:	89 e5                	mov    %esp,%ebp
80100683:	57                   	push   %edi
80100684:	56                   	push   %esi
80100685:	53                   	push   %ebx
80100686:	83 ec 2c             	sub    $0x2c,%esp
  locking = cons.locking;
80100689:	8b 3d 54 ff 10 80    	mov    0x8010ff54,%edi
  if (fmt == 0)
8010068f:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100692:	85 ff                	test   %edi,%edi
80100694:	0f 85 06 01 00 00    	jne    801007a0 <cprintf+0x120>
  if (fmt == 0)
8010069a:	85 f6                	test   %esi,%esi
8010069c:	0f 84 b3 01 00 00    	je     80100855 <cprintf+0x1d5>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006a2:	0f b6 06             	movzbl (%esi),%eax
801006a5:	85 c0                	test   %eax,%eax
801006a7:	74 5c                	je     80100705 <cprintf+0x85>
801006a9:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  argp = (uint*)(void*)(&fmt + 1);
801006ac:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006af:	31 db                	xor    %ebx,%ebx
801006b1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006b3:	83 f8 25             	cmp    $0x25,%eax
801006b6:	75 58                	jne    80100710 <cprintf+0x90>
    c = fmt[++i] & 0xff;
801006b8:	43                   	inc    %ebx
801006b9:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006bd:	85 c9                	test   %ecx,%ecx
801006bf:	74 39                	je     801006fa <cprintf+0x7a>
    switch(c){
801006c1:	83 f9 70             	cmp    $0x70,%ecx
801006c4:	0f 84 b6 00 00 00    	je     80100780 <cprintf+0x100>
801006ca:	7f 74                	jg     80100740 <cprintf+0xc0>
801006cc:	83 f9 25             	cmp    $0x25,%ecx
801006cf:	90                   	nop
801006d0:	74 4e                	je     80100720 <cprintf+0xa0>
801006d2:	83 f9 64             	cmp    $0x64,%ecx
801006d5:	75 7b                	jne    80100752 <cprintf+0xd2>
      printint(*argp++, 10, 1);
801006d7:	8d 47 04             	lea    0x4(%edi),%eax
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006e2:	8b 07                	mov    (%edi),%eax
801006e4:	ba 0a 00 00 00       	mov    $0xa,%edx
801006e9:	e8 f2 fe ff ff       	call   801005e0 <printint>
801006ee:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f1:	43                   	inc    %ebx
801006f2:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006f6:	85 c0                	test   %eax,%eax
801006f8:	75 b9                	jne    801006b3 <cprintf+0x33>
801006fa:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
801006fd:	85 ff                	test   %edi,%edi
801006ff:	0f 85 ba 00 00 00    	jne    801007bf <cprintf+0x13f>
}
80100705:	83 c4 2c             	add    $0x2c,%esp
80100708:	5b                   	pop    %ebx
80100709:	5e                   	pop    %esi
8010070a:	5f                   	pop    %edi
8010070b:	5d                   	pop    %ebp
8010070c:	c3                   	ret
8010070d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100710:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100716:	85 d2                	test   %edx,%edx
80100718:	74 19                	je     80100733 <cprintf+0xb3>
8010071a:	fa                   	cli
    for(;;)
8010071b:	eb fe                	jmp    8010071b <cprintf+0x9b>
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100720:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100726:	85 c9                	test   %ecx,%ecx
80100728:	0f 85 0a 01 00 00    	jne    80100838 <cprintf+0x1b8>
8010072e:	b8 25 00 00 00       	mov    $0x25,%eax
80100733:	e8 98 fc ff ff       	call   801003d0 <consputc.part.0>
      break;
80100738:	eb b7                	jmp    801006f1 <cprintf+0x71>
8010073a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100740:	83 f9 73             	cmp    $0x73,%ecx
80100743:	0f 84 87 00 00 00    	je     801007d0 <cprintf+0x150>
80100749:	83 f9 78             	cmp    $0x78,%ecx
8010074c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100750:	74 2e                	je     80100780 <cprintf+0x100>
  if(panicked){
80100752:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100758:	85 d2                	test   %edx,%edx
8010075a:	0f 85 cf 00 00 00    	jne    8010082f <cprintf+0x1af>
80100760:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100763:	b8 25 00 00 00       	mov    $0x25,%eax
80100768:	e8 63 fc ff ff       	call   801003d0 <consputc.part.0>
8010076d:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100772:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100775:	85 c0                	test   %eax,%eax
80100777:	0f 84 c3 00 00 00    	je     80100840 <cprintf+0x1c0>
8010077d:	fa                   	cli
    for(;;)
8010077e:	eb fe                	jmp    8010077e <cprintf+0xfe>
      printint(*argp++, 16, 0);
80100780:	8d 47 04             	lea    0x4(%edi),%eax
80100783:	31 c9                	xor    %ecx,%ecx
80100785:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100788:	8b 07                	mov    (%edi),%eax
8010078a:	ba 10 00 00 00       	mov    $0x10,%edx
8010078f:	e8 4c fe ff ff       	call   801005e0 <printint>
80100794:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100797:	e9 55 ff ff ff       	jmp    801006f1 <cprintf+0x71>
8010079c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007a0:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801007a7:	e8 f4 42 00 00       	call   80104aa0 <acquire>
  if (fmt == 0)
801007ac:	85 f6                	test   %esi,%esi
801007ae:	0f 84 a1 00 00 00    	je     80100855 <cprintf+0x1d5>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b4:	0f b6 06             	movzbl (%esi),%eax
801007b7:	85 c0                	test   %eax,%eax
801007b9:	0f 85 ea fe ff ff    	jne    801006a9 <cprintf+0x29>
    release(&cons.lock);
801007bf:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801007c6:	e8 65 42 00 00       	call   80104a30 <release>
801007cb:	e9 35 ff ff ff       	jmp    80100705 <cprintf+0x85>
      if((s = (char*)*argp++) == 0)
801007d0:	8b 17                	mov    (%edi),%edx
801007d2:	8d 47 04             	lea    0x4(%edi),%eax
801007d5:	85 d2                	test   %edx,%edx
801007d7:	74 1f                	je     801007f8 <cprintf+0x178>
      for(; *s; s++)
801007d9:	0f b6 0a             	movzbl (%edx),%ecx
801007dc:	84 c9                	test   %cl,%cl
801007de:	74 6c                	je     8010084c <cprintf+0x1cc>
801007e0:	89 5d e0             	mov    %ebx,-0x20(%ebp)
801007e3:	89 f7                	mov    %esi,%edi
801007e5:	89 d3                	mov    %edx,%ebx
801007e7:	89 c6                	mov    %eax,%esi
  if(panicked){
801007e9:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007ee:	85 c0                	test   %eax,%eax
801007f0:	74 1f                	je     80100811 <cprintf+0x191>
801007f2:	fa                   	cli
    for(;;)
801007f3:	eb fe                	jmp    801007f3 <cprintf+0x173>
801007f5:	8d 76 00             	lea    0x0(%esi),%esi
        s = "(null)";
801007f8:	89 5d e0             	mov    %ebx,-0x20(%ebp)
801007fb:	bf d8 7a 10 80       	mov    $0x80107ad8,%edi
80100800:	b1 28                	mov    $0x28,%cl
80100802:	89 fb                	mov    %edi,%ebx
80100804:	89 f7                	mov    %esi,%edi
80100806:	89 c6                	mov    %eax,%esi
  if(panicked){
80100808:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010080d:	85 c0                	test   %eax,%eax
8010080f:	75 e1                	jne    801007f2 <cprintf+0x172>
        consputc(*s);
80100811:	0f be c1             	movsbl %cl,%eax
      for(; *s; s++)
80100814:	43                   	inc    %ebx
80100815:	e8 b6 fb ff ff       	call   801003d0 <consputc.part.0>
8010081a:	0f b6 0b             	movzbl (%ebx),%ecx
8010081d:	84 c9                	test   %cl,%cl
8010081f:	75 c8                	jne    801007e9 <cprintf+0x169>
      if((s = (char*)*argp++) == 0)
80100821:	89 f0                	mov    %esi,%eax
80100823:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100826:	89 fe                	mov    %edi,%esi
80100828:	89 c7                	mov    %eax,%edi
8010082a:	e9 c2 fe ff ff       	jmp    801006f1 <cprintf+0x71>
8010082f:	fa                   	cli
    for(;;)
80100830:	eb fe                	jmp    80100830 <cprintf+0x1b0>
80100832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100838:	fa                   	cli
80100839:	eb fe                	jmp    80100839 <cprintf+0x1b9>
8010083b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100840:	89 c8                	mov    %ecx,%eax
80100842:	e8 89 fb ff ff       	call   801003d0 <consputc.part.0>
      break;
80100847:	e9 a5 fe ff ff       	jmp    801006f1 <cprintf+0x71>
      if((s = (char*)*argp++) == 0)
8010084c:	89 c7                	mov    %eax,%edi
8010084e:	66 90                	xchg   %ax,%ax
80100850:	e9 9c fe ff ff       	jmp    801006f1 <cprintf+0x71>
    panic("null fmt");
80100855:	c7 04 24 df 7a 10 80 	movl   $0x80107adf,(%esp)
8010085c:	e8 ef fa ff ff       	call   80100350 <panic>
80100861:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100868:	00 
80100869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100870 <consoleintr>:
{
80100870:	55                   	push   %ebp
80100871:	89 e5                	mov    %esp,%ebp
80100873:	57                   	push   %edi
  int c, doprocdump = 0;
80100874:	31 ff                	xor    %edi,%edi
{
80100876:	56                   	push   %esi
80100877:	53                   	push   %ebx
80100878:	83 ec 2c             	sub    $0x2c,%esp
  acquire(&cons.lock);
8010087b:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
{
80100882:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
80100885:	e8 16 42 00 00       	call   80104aa0 <acquire>
  while((c = getc()) >= 0){
8010088a:	ff d6                	call   *%esi
8010088c:	85 c0                	test   %eax,%eax
8010088e:	78 21                	js     801008b1 <consoleintr+0x41>
    switch(c){
80100890:	83 f8 15             	cmp    $0x15,%eax
80100893:	74 3b                	je     801008d0 <consoleintr+0x60>
80100895:	7f 69                	jg     80100900 <consoleintr+0x90>
80100897:	83 f8 08             	cmp    $0x8,%eax
8010089a:	74 69                	je     80100905 <consoleintr+0x95>
8010089c:	83 f8 10             	cmp    $0x10,%eax
8010089f:	90                   	nop
801008a0:	0f 85 28 01 00 00    	jne    801009ce <consoleintr+0x15e>
  while((c = getc()) >= 0){
801008a6:	ff d6                	call   *%esi
    switch(c){
801008a8:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
801008ad:	85 c0                	test   %eax,%eax
801008af:	79 df                	jns    80100890 <consoleintr+0x20>
  release(&cons.lock);
801008b1:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801008b8:	e8 73 41 00 00       	call   80104a30 <release>
  if(doprocdump) {
801008bd:	85 ff                	test   %edi,%edi
801008bf:	0f 85 6f 01 00 00    	jne    80100a34 <consoleintr+0x1c4>
}
801008c5:	83 c4 2c             	add    $0x2c,%esp
801008c8:	5b                   	pop    %ebx
801008c9:	5e                   	pop    %esi
801008ca:	5f                   	pop    %edi
801008cb:	5d                   	pop    %ebp
801008cc:	c3                   	ret
801008cd:	8d 76 00             	lea    0x0(%esi),%esi
      while(input.e != input.w &&
801008d0:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801008d5:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
801008db:	74 ad                	je     8010088a <consoleintr+0x1a>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008dd:	48                   	dec    %eax
801008de:	89 c2                	mov    %eax,%edx
801008e0:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801008e3:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
801008ea:	74 9e                	je     8010088a <consoleintr+0x1a>
        input.e--;
801008ec:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
801008f1:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801008f6:	85 c0                	test   %eax,%eax
801008f8:	74 36                	je     80100930 <consoleintr+0xc0>
801008fa:	fa                   	cli
    for(;;)
801008fb:	eb fe                	jmp    801008fb <consoleintr+0x8b>
801008fd:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100900:	83 f8 7f             	cmp    $0x7f,%eax
80100903:	75 4b                	jne    80100950 <consoleintr+0xe0>
      if(input.e != input.w){
80100905:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010090a:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100910:	0f 84 74 ff ff ff    	je     8010088a <consoleintr+0x1a>
  if(panicked){
80100916:	8b 1d 58 ff 10 80    	mov    0x8010ff58,%ebx
        input.e--;
8010091c:	48                   	dec    %eax
8010091d:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100922:	85 db                	test   %ebx,%ebx
80100924:	0f 84 fb 00 00 00    	je     80100a25 <consoleintr+0x1b5>
8010092a:	fa                   	cli
    for(;;)
8010092b:	eb fe                	jmp    8010092b <consoleintr+0xbb>
8010092d:	8d 76 00             	lea    0x0(%esi),%esi
80100930:	b8 00 01 00 00       	mov    $0x100,%eax
80100935:	e8 96 fa ff ff       	call   801003d0 <consputc.part.0>
      while(input.e != input.w &&
8010093a:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010093f:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100945:	75 96                	jne    801008dd <consoleintr+0x6d>
80100947:	e9 3e ff ff ff       	jmp    8010088a <consoleintr+0x1a>
8010094c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100950:	8b 1d 08 ff 10 80    	mov    0x8010ff08,%ebx
80100956:	8b 0d 00 ff 10 80    	mov    0x8010ff00,%ecx
8010095c:	89 da                	mov    %ebx,%edx
8010095e:	29 ca                	sub    %ecx,%edx
80100960:	83 fa 7f             	cmp    $0x7f,%edx
80100963:	0f 87 21 ff ff ff    	ja     8010088a <consoleintr+0x1a>
  if(panicked){
80100969:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
8010096f:	8d 53 01             	lea    0x1(%ebx),%edx
80100972:	83 e3 7f             	and    $0x7f,%ebx
80100975:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
  if(panicked){
8010097b:	85 c9                	test   %ecx,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
8010097d:	88 83 80 fe 10 80    	mov    %al,-0x7fef0180(%ebx)
  if(panicked){
80100983:	0f 85 b7 00 00 00    	jne    80100a40 <consoleintr+0x1d0>
80100989:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010098c:	e8 3f fa ff ff       	call   801003d0 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100991:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100994:	8b 0d 08 ff 10 80    	mov    0x8010ff08,%ecx
8010099a:	83 f8 0a             	cmp    $0xa,%eax
8010099d:	74 18                	je     801009b7 <consoleintr+0x147>
8010099f:	83 f8 04             	cmp    $0x4,%eax
801009a2:	74 13                	je     801009b7 <consoleintr+0x147>
801009a4:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801009a9:	8d 90 80 00 00 00    	lea    0x80(%eax),%edx
801009af:	39 ca                	cmp    %ecx,%edx
801009b1:	0f 85 d3 fe ff ff    	jne    8010088a <consoleintr+0x1a>
          wakeup(&input.r);
801009b7:	c7 04 24 00 ff 10 80 	movl   $0x8010ff00,(%esp)
          input.w = input.e;
801009be:	89 0d 04 ff 10 80    	mov    %ecx,0x8010ff04
          wakeup(&input.r);
801009c4:	e8 47 3a 00 00       	call   80104410 <wakeup>
801009c9:	e9 bc fe ff ff       	jmp    8010088a <consoleintr+0x1a>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009ce:	85 c0                	test   %eax,%eax
801009d0:	0f 84 b4 fe ff ff    	je     8010088a <consoleintr+0x1a>
801009d6:	8b 1d 08 ff 10 80    	mov    0x8010ff08,%ebx
801009dc:	89 da                	mov    %ebx,%edx
801009de:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801009e4:	83 fa 7f             	cmp    $0x7f,%edx
801009e7:	0f 87 9d fe ff ff    	ja     8010088a <consoleintr+0x1a>
        input.buf[input.e++ % INPUT_BUF] = c;
801009ed:	8d 53 01             	lea    0x1(%ebx),%edx
801009f0:	83 e3 7f             	and    $0x7f,%ebx
  if(panicked){
801009f3:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        c = (c == '\r') ? '\n' : c;
801009f9:	83 f8 0d             	cmp    $0xd,%eax
801009fc:	0f 85 73 ff ff ff    	jne    80100975 <consoleintr+0x105>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a02:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
  if(panicked){
80100a08:	85 c9                	test   %ecx,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
80100a0a:	c6 83 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%ebx)
  if(panicked){
80100a11:	75 2d                	jne    80100a40 <consoleintr+0x1d0>
80100a13:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a18:	e8 b3 f9 ff ff       	call   801003d0 <consputc.part.0>
          input.w = input.e;
80100a1d:	8b 0d 08 ff 10 80    	mov    0x8010ff08,%ecx
80100a23:	eb 92                	jmp    801009b7 <consoleintr+0x147>
80100a25:	b8 00 01 00 00       	mov    $0x100,%eax
80100a2a:	e8 a1 f9 ff ff       	call   801003d0 <consputc.part.0>
80100a2f:	e9 56 fe ff ff       	jmp    8010088a <consoleintr+0x1a>
}
80100a34:	83 c4 2c             	add    $0x2c,%esp
80100a37:	5b                   	pop    %ebx
80100a38:	5e                   	pop    %esi
80100a39:	5f                   	pop    %edi
80100a3a:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a3b:	e9 b0 3a 00 00       	jmp    801044f0 <procdump>
80100a40:	fa                   	cli
    for(;;)
80100a41:	eb fe                	jmp    80100a41 <consoleintr+0x1d1>
80100a43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a4a:	00 
80100a4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100a50 <consoleinit>:

void
consoleinit(void)
{
80100a50:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100a51:	b8 e8 7a 10 80       	mov    $0x80107ae8,%eax
{
80100a56:	89 e5                	mov    %esp,%ebp
80100a58:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100a5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a5f:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80100a66:	e8 35 3e 00 00       	call   801048a0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
80100a6b:	b8 01 00 00 00       	mov    $0x1,%eax
  devsw[CONSOLE].write = consolewrite;
80100a70:	ba 70 05 10 80       	mov    $0x80100570,%edx
  cons.locking = 1;
80100a75:	a3 54 ff 10 80       	mov    %eax,0x8010ff54
  devsw[CONSOLE].read = consoleread;
80100a7a:	b9 60 02 10 80       	mov    $0x80100260,%ecx

  ioapicenable(IRQ_KBD, 0);
80100a7f:	31 c0                	xor    %eax,%eax
  devsw[CONSOLE].write = consolewrite;
80100a81:	89 15 0c 09 11 80    	mov    %edx,0x8011090c
  devsw[CONSOLE].read = consoleread;
80100a87:	89 0d 08 09 11 80    	mov    %ecx,0x80110908
  ioapicenable(IRQ_KBD, 0);
80100a8d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100a98:	e8 d3 1a 00 00       	call   80102570 <ioapicenable>
}
80100a9d:	89 ec                	mov    %ebp,%esp
80100a9f:	5d                   	pop    %ebp
80100aa0:	c3                   	ret
80100aa1:	66 90                	xchg   %ax,%ax
80100aa3:	66 90                	xchg   %ax,%ax
80100aa5:	66 90                	xchg   %ax,%ax
80100aa7:	66 90                	xchg   %ax,%ax
80100aa9:	66 90                	xchg   %ax,%ax
80100aab:	66 90                	xchg   %ax,%ax
80100aad:	66 90                	xchg   %ax,%ax
80100aaf:	90                   	nop

80100ab0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100abc:	e8 bf 31 00 00       	call   80103c80 <myproc>
80100ac1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100ac7:	e8 84 23 00 00       	call   80102e50 <begin_op>

  if((ip = namei(path)) == 0){
80100acc:	8b 45 08             	mov    0x8(%ebp),%eax
80100acf:	89 04 24             	mov    %eax,(%esp)
80100ad2:	e8 c9 16 00 00       	call   801021a0 <namei>
80100ad7:	85 c0                	test   %eax,%eax
80100ad9:	0f 84 53 03 00 00    	je     80100e32 <exec+0x382>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100adf:	89 04 24             	mov    %eax,(%esp)
80100ae2:	89 c7                	mov    %eax,%edi
80100ae4:	e8 57 0d 00 00       	call   80101840 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100ae9:	b8 34 00 00 00       	mov    $0x34,%eax
80100aee:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100af2:	31 c0                	xor    %eax,%eax
80100af4:	89 44 24 08          	mov    %eax,0x8(%esp)
80100af8:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100afe:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b02:	89 3c 24             	mov    %edi,(%esp)
80100b05:	e8 36 10 00 00       	call   80101b40 <readi>
80100b0a:	83 f8 34             	cmp    $0x34,%eax
80100b0d:	0f 85 1a 01 00 00    	jne    80100c2d <exec+0x17d>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b13:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b1a:	45 4c 46 
80100b1d:	0f 85 0a 01 00 00    	jne    80100c2d <exec+0x17d>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b23:	e8 88 6a 00 00       	call   801075b0 <setupkvm>
80100b28:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b2e:	85 c0                	test   %eax,%eax
80100b30:	0f 84 f7 00 00 00    	je     80100c2d <exec+0x17d>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b36:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b3d:	00 
80100b3e:	8b 9d 40 ff ff ff    	mov    -0xc0(%ebp),%ebx
80100b44:	0f 84 c0 02 00 00    	je     80100e0a <exec+0x35a>
  sz = 0;
80100b4a:	31 f6                	xor    %esi,%esi
80100b4c:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b52:	31 f6                	xor    %esi,%esi
80100b54:	e9 9e 00 00 00       	jmp    80100bf7 <exec+0x147>
80100b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b60:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b67:	75 7f                	jne    80100be8 <exec+0x138>
      continue;
    if(ph.memsz < ph.filesz)
80100b69:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b6f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b75:	0f 82 a4 00 00 00    	jb     80100c1f <exec+0x16f>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b7b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b81:	0f 82 98 00 00 00    	jb     80100c1f <exec+0x16f>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b87:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b8b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b91:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b95:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100b9b:	89 04 24             	mov    %eax,(%esp)
80100b9e:	e8 4d 68 00 00       	call   801073f0 <allocuvm>
80100ba3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ba9:	85 c0                	test   %eax,%eax
80100bab:	74 72                	je     80100c1f <exec+0x16f>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100bad:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bb3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bb8:	75 65                	jne    80100c1f <exec+0x16f>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bba:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bbe:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100bc4:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100bc8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100bce:	89 54 24 10          	mov    %edx,0x10(%esp)
80100bd2:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100bd8:	89 04 24             	mov    %eax,(%esp)
80100bdb:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100bdf:	e8 1c 67 00 00       	call   80107300 <loaduvm>
80100be4:	85 c0                	test   %eax,%eax
80100be6:	78 37                	js     80100c1f <exec+0x16f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bef:	46                   	inc    %esi
80100bf0:	83 c3 20             	add    $0x20,%ebx
80100bf3:	39 f0                	cmp    %esi,%eax
80100bf5:	7e 59                	jle    80100c50 <exec+0x1a0>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100bfb:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c01:	b9 20 00 00 00       	mov    $0x20,%ecx
80100c06:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80100c0a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c0e:	89 3c 24             	mov    %edi,(%esp)
80100c11:	e8 2a 0f 00 00       	call   80101b40 <readi>
80100c16:	83 f8 20             	cmp    $0x20,%eax
80100c19:	0f 84 41 ff ff ff    	je     80100b60 <exec+0xb0>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100c1f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c25:	89 04 24             	mov    %eax,(%esp)
80100c28:	e8 03 69 00 00       	call   80107530 <freevm>
  if(ip){
    iunlockput(ip);
80100c2d:	89 3c 24             	mov    %edi,(%esp)
80100c30:	e8 8b 0e 00 00       	call   80101ac0 <iunlockput>
    end_op();
80100c35:	e8 86 22 00 00       	call   80102ec0 <end_op>
    return -1;
80100c3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100c3f:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100c45:	5b                   	pop    %ebx
80100c46:	5e                   	pop    %esi
80100c47:	5f                   	pop    %edi
80100c48:	5d                   	pop    %ebp
80100c49:	c3                   	ret
80100c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  sz = PGROUNDUP(sz);
80100c50:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c56:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100c5c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c62:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100c68:	89 3c 24             	mov    %edi,(%esp)
80100c6b:	e8 50 0e 00 00       	call   80101ac0 <iunlockput>
  end_op();
80100c70:	e8 4b 22 00 00       	call   80102ec0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c75:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c7b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100c7f:	89 74 24 04          	mov    %esi,0x4(%esp)
80100c83:	89 3c 24             	mov    %edi,(%esp)
80100c86:	e8 65 67 00 00       	call   801073f0 <allocuvm>
80100c8b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c91:	85 c0                	test   %eax,%eax
80100c93:	89 c3                	mov    %eax,%ebx
80100c95:	0f 84 86 00 00 00    	je     80100d21 <exec+0x271>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c9b:	89 3c 24             	mov    %edi,(%esp)
80100c9e:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100ca4:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ca6:	89 44 24 04          	mov    %eax,0x4(%esp)
80100caa:	e8 a1 69 00 00       	call   80107650 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100caf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cb2:	8b 08                	mov    (%eax),%ecx
80100cb4:	85 c9                	test   %ecx,%ecx
80100cb6:	0f 84 5a 01 00 00    	je     80100e16 <exec+0x366>
80100cbc:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100cbf:	eb 25                	jmp    80100ce6 <exec+0x236>
80100cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ustack[3+argc] = sp;
80100cc8:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
  for(argc = 0; argv[argc]; argc++) {
80100ccf:	8d 46 01             	lea    0x1(%esi),%eax
80100cd2:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
    ustack[3+argc] = sp;
80100cd5:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100cdb:	85 c9                	test   %ecx,%ecx
80100cdd:	74 55                	je     80100d34 <exec+0x284>
    if(argc >= MAXARG)
80100cdf:	83 f8 20             	cmp    $0x20,%eax
80100ce2:	74 3d                	je     80100d21 <exec+0x271>
80100ce4:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ce6:	89 0c 24             	mov    %ecx,(%esp)
80100ce9:	e8 92 40 00 00       	call   80104d80 <strlen>
80100cee:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cf0:	8b 04 b7             	mov    (%edi,%esi,4),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cf3:	4b                   	dec    %ebx
80100cf4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cf7:	89 04 24             	mov    %eax,(%esp)
80100cfa:	e8 81 40 00 00       	call   80104d80 <strlen>
80100cff:	40                   	inc    %eax
80100d00:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100d04:	8b 04 b7             	mov    (%edi,%esi,4),%eax
80100d07:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100d0b:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d0f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100d15:	89 04 24             	mov    %eax,(%esp)
80100d18:	e8 f3 6a 00 00       	call   80107810 <copyout>
80100d1d:	85 c0                	test   %eax,%eax
80100d1f:	79 a7                	jns    80100cc8 <exec+0x218>
    freevm(pgdir);
80100d21:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100d27:	89 04 24             	mov    %eax,(%esp)
80100d2a:	e8 01 68 00 00       	call   80107530 <freevm>
  if(ip){
80100d2f:	e9 06 ff ff ff       	jmp    80100c3a <exec+0x18a>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d34:	8d 0c b5 08 00 00 00 	lea    0x8(,%esi,4),%ecx
  ustack[3+argc] = 0;
80100d3b:	89 d7                	mov    %edx,%edi
80100d3d:	8d 56 04             	lea    0x4(%esi),%edx
  sp -= (3+argc+1) * 4;
80100d40:	8d 71 0c             	lea    0xc(%ecx),%esi
  ustack[1] = argc;
80100d43:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d49:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100d4b:	29 f3                	sub    %esi,%ebx
  ustack[3+argc] = 0;
80100d4d:	c7 84 95 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%edx,4)
80100d54:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d58:	29 c8                	sub    %ecx,%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100d5a:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d5f:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d65:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100d6b:	89 74 24 0c          	mov    %esi,0xc(%esp)
80100d6f:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100d73:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100d77:	89 04 24             	mov    %eax,(%esp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d7a:	89 95 58 ff ff ff    	mov    %edx,-0xa8(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d80:	e8 8b 6a 00 00       	call   80107810 <copyout>
80100d85:	85 c0                	test   %eax,%eax
80100d87:	78 98                	js     80100d21 <exec+0x271>
  for(last=s=path; *s; s++)
80100d89:	8b 45 08             	mov    0x8(%ebp),%eax
80100d8c:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100d8f:	0f b6 00             	movzbl (%eax),%eax
80100d92:	84 c0                	test   %al,%al
80100d94:	74 17                	je     80100dad <exec+0x2fd>
80100d96:	89 ca                	mov    %ecx,%edx
80100d98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d9f:	00 
      last = s+1;
80100da0:	42                   	inc    %edx
80100da1:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100da3:	0f b6 02             	movzbl (%edx),%eax
      last = s+1;
80100da6:	0f 44 ca             	cmove  %edx,%ecx
  for(last=s=path; *s; s++)
80100da9:	84 c0                	test   %al,%al
80100dab:	75 f3                	jne    80100da0 <exec+0x2f0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100dad:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100db1:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100db7:	b8 10 00 00 00       	mov    $0x10,%eax
80100dbc:	89 44 24 08          	mov    %eax,0x8(%esp)
80100dc0:	89 f8                	mov    %edi,%eax
80100dc2:	83 c0 6c             	add    $0x6c,%eax
80100dc5:	89 04 24             	mov    %eax,(%esp)
80100dc8:	e8 73 3f 00 00       	call   80104d40 <safestrcpy>
  curproc->pgdir = pgdir;
80100dcd:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100dd3:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->tf->eip = elf.entry;  // main
80100dd6:	8b 47 18             	mov    0x18(%edi),%eax
  curproc->pgdir = pgdir;
80100dd9:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100ddc:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100de2:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100de4:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dea:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100ded:	8b 47 18             	mov    0x18(%edi),%eax
80100df0:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100df3:	89 3c 24             	mov    %edi,(%esp)
80100df6:	e8 75 63 00 00       	call   80107170 <switchuvm>
  freevm(oldpgdir);
80100dfb:	89 34 24             	mov    %esi,(%esp)
80100dfe:	e8 2d 67 00 00       	call   80107530 <freevm>
  return 0;
80100e03:	31 c0                	xor    %eax,%eax
80100e05:	e9 35 fe ff ff       	jmp    80100c3f <exec+0x18f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e0a:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100e0f:	31 f6                	xor    %esi,%esi
80100e11:	e9 52 fe ff ff       	jmp    80100c68 <exec+0x1b8>
  for(argc = 0; argv[argc]; argc++) {
80100e16:	be 10 00 00 00       	mov    $0x10,%esi
80100e1b:	b9 04 00 00 00       	mov    $0x4,%ecx
80100e20:	ba 03 00 00 00       	mov    $0x3,%edx
80100e25:	31 c0                	xor    %eax,%eax
80100e27:	8d bd 58 ff ff ff    	lea    -0xa8(%ebp),%edi
80100e2d:	e9 11 ff ff ff       	jmp    80100d43 <exec+0x293>
    end_op();
80100e32:	e8 89 20 00 00       	call   80102ec0 <end_op>
    cprintf("exec: fail\n");
80100e37:	c7 04 24 f0 7a 10 80 	movl   $0x80107af0,(%esp)
80100e3e:	e8 3d f8 ff ff       	call   80100680 <cprintf>
    return -1;
80100e43:	e9 f2 fd ff ff       	jmp    80100c3a <exec+0x18a>
80100e48:	66 90                	xchg   %ax,%ax
80100e4a:	66 90                	xchg   %ax,%ax
80100e4c:	66 90                	xchg   %ax,%ax
80100e4e:	66 90                	xchg   %ax,%ax

80100e50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e50:	55                   	push   %ebp
  initlock(&ftable.lock, "ftable");
80100e51:	b8 fc 7a 10 80       	mov    $0x80107afc,%eax
{
80100e56:	89 e5                	mov    %esp,%ebp
80100e58:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100e5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e5f:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100e66:	e8 35 3a 00 00       	call   801048a0 <initlock>
}
80100e6b:	89 ec                	mov    %ebp,%esp
80100e6d:	5d                   	pop    %ebp
80100e6e:	c3                   	ret
80100e6f:	90                   	nop

80100e70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e70:	55                   	push   %ebp
80100e71:	89 e5                	mov    %esp,%ebp
80100e73:	83 ec 18             	sub    $0x18,%esp
80100e76:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e79:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
  acquire(&ftable.lock);
80100e7e:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100e85:	e8 16 3c 00 00       	call   80104aa0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e8a:	eb 0f                	jmp    80100e9b <filealloc+0x2b>
80100e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e90:	83 c3 18             	add    $0x18,%ebx
80100e93:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100e99:	74 23                	je     80100ebe <filealloc+0x4e>
    if(f->ref == 0){
80100e9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e9e:	85 c0                	test   %eax,%eax
80100ea0:	75 ee                	jne    80100e90 <filealloc+0x20>
      f->ref = 1;
80100ea2:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100ea9:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100eb0:	e8 7b 3b 00 00       	call   80104a30 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100eb5:	89 d8                	mov    %ebx,%eax
80100eb7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eba:	89 ec                	mov    %ebp,%esp
80100ebc:	5d                   	pop    %ebp
80100ebd:	c3                   	ret
  release(&ftable.lock);
80100ebe:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
  return 0;
80100ec5:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100ec7:	e8 64 3b 00 00       	call   80104a30 <release>
}
80100ecc:	89 d8                	mov    %ebx,%eax
80100ece:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ed1:	89 ec                	mov    %ebp,%esp
80100ed3:	5d                   	pop    %ebp
80100ed4:	c3                   	ret
80100ed5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100edc:	00 
80100edd:	8d 76 00             	lea    0x0(%esi),%esi

80100ee0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ee0:	55                   	push   %ebp
80100ee1:	89 e5                	mov    %esp,%ebp
80100ee3:	83 ec 18             	sub    $0x18,%esp
80100ee6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80100ee9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eec:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100ef3:	e8 a8 3b 00 00       	call   80104aa0 <acquire>
  if(f->ref < 1)
80100ef8:	8b 43 04             	mov    0x4(%ebx),%eax
80100efb:	85 c0                	test   %eax,%eax
80100efd:	7e 19                	jle    80100f18 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100eff:	40                   	inc    %eax
80100f00:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f03:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100f0a:	e8 21 3b 00 00       	call   80104a30 <release>
  return f;
}
80100f0f:	89 d8                	mov    %ebx,%eax
80100f11:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f14:	89 ec                	mov    %ebp,%esp
80100f16:	5d                   	pop    %ebp
80100f17:	c3                   	ret
    panic("filedup");
80100f18:	c7 04 24 03 7b 10 80 	movl   $0x80107b03,(%esp)
80100f1f:	e8 2c f4 ff ff       	call   80100350 <panic>
80100f24:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f2b:	00 
80100f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f30 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f30:	55                   	push   %ebp
80100f31:	89 e5                	mov    %esp,%ebp
80100f33:	83 ec 38             	sub    $0x38,%esp
80100f36:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100f39:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f3c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100f3f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&ftable.lock);
80100f42:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100f49:	e8 52 3b 00 00       	call   80104aa0 <acquire>
  if(f->ref < 1)
80100f4e:	8b 53 04             	mov    0x4(%ebx),%edx
80100f51:	85 d2                	test   %edx,%edx
80100f53:	0f 8e ac 00 00 00    	jle    80101005 <fileclose+0xd5>
    panic("fileclose");
  if(--f->ref > 0){
80100f59:	4a                   	dec    %edx
80100f5a:	89 53 04             	mov    %edx,0x4(%ebx)
80100f5d:	75 41                	jne    80100fa0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f5f:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f63:	8b 3b                	mov    (%ebx),%edi
  f->ref = 0;
  f->type = FD_NONE;
80100f65:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f6b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f6e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f71:	8b 43 10             	mov    0x10(%ebx),%eax
80100f74:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f77:	c7 04 24 60 ff 10 80 	movl   $0x8010ff60,(%esp)
80100f7e:	e8 ad 3a 00 00       	call   80104a30 <release>

  if(ff.type == FD_PIPE)
80100f83:	83 ff 01             	cmp    $0x1,%edi
80100f86:	74 60                	je     80100fe8 <fileclose+0xb8>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f88:	83 ff 02             	cmp    $0x2,%edi
80100f8b:	74 33                	je     80100fc0 <fileclose+0x90>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f8d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100f90:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f93:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100f96:	89 ec                	mov    %ebp,%esp
80100f98:	5d                   	pop    %ebp
80100f99:	c3                   	ret
80100f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fa0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    release(&ftable.lock);
80100fa3:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80100faa:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fad:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100fb0:	89 ec                	mov    %ebp,%esp
80100fb2:	5d                   	pop    %ebp
    release(&ftable.lock);
80100fb3:	e9 78 3a 00 00       	jmp    80104a30 <release>
80100fb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fbf:	00 
    begin_op();
80100fc0:	e8 8b 1e 00 00       	call   80102e50 <begin_op>
    iput(ff.ip);
80100fc5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100fc8:	89 04 24             	mov    %eax,(%esp)
80100fcb:	e8 a0 09 00 00       	call   80101970 <iput>
}
80100fd0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fd3:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fd6:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100fd9:	89 ec                	mov    %ebp,%esp
80100fdb:	5d                   	pop    %ebp
    end_op();
80100fdc:	e9 df 1e 00 00       	jmp    80102ec0 <end_op>
80100fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pipeclose(ff.pipe, ff.writable);
80100fe8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fec:	89 34 24             	mov    %esi,(%esp)
80100fef:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100ff3:	e8 c8 25 00 00       	call   801035c0 <pipeclose>
}
80100ff8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100ffb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100ffe:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101001:	89 ec                	mov    %ebp,%esp
80101003:	5d                   	pop    %ebp
80101004:	c3                   	ret
    panic("fileclose");
80101005:	c7 04 24 0b 7b 10 80 	movl   $0x80107b0b,(%esp)
8010100c:	e8 3f f3 ff ff       	call   80100350 <panic>
80101011:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101018:	00 
80101019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101020 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	83 ec 18             	sub    $0x18,%esp
80101026:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010102c:	83 3b 02             	cmpl   $0x2,(%ebx)
8010102f:	75 37                	jne    80101068 <filestat+0x48>
    ilock(f->ip);
80101031:	8b 43 10             	mov    0x10(%ebx),%eax
80101034:	89 04 24             	mov    %eax,(%esp)
80101037:	e8 04 08 00 00       	call   80101840 <ilock>
    stati(f->ip, st);
8010103c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010103f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101043:	8b 43 10             	mov    0x10(%ebx),%eax
80101046:	89 04 24             	mov    %eax,(%esp)
80101049:	e8 c2 0a 00 00       	call   80101b10 <stati>
    iunlock(f->ip);
8010104e:	8b 43 10             	mov    0x10(%ebx),%eax
80101051:	89 04 24             	mov    %eax,(%esp)
80101054:	e8 c7 08 00 00       	call   80101920 <iunlock>
    return 0;
  }
  return -1;
}
80101059:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010105c:	89 ec                	mov    %ebp,%esp
8010105e:	5d                   	pop    %ebp
    return 0;
8010105f:	31 c0                	xor    %eax,%eax
}
80101061:	c3                   	ret
80101062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101068:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010106b:	89 ec                	mov    %ebp,%esp
  return -1;
8010106d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101072:	5d                   	pop    %ebp
80101073:	c3                   	ret
80101074:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010107b:	00 
8010107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101080 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101080:	55                   	push   %ebp
80101081:	89 e5                	mov    %esp,%ebp
80101083:	83 ec 28             	sub    $0x28,%esp
80101086:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101089:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010108c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010108f:	8b 75 0c             	mov    0xc(%ebp),%esi
80101092:	89 7d fc             	mov    %edi,-0x4(%ebp)
80101095:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101098:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
8010109c:	74 72                	je     80101110 <fileread+0x90>
    return -1;
  if(f->type == FD_PIPE)
8010109e:	8b 03                	mov    (%ebx),%eax
801010a0:	83 f8 01             	cmp    $0x1,%eax
801010a3:	74 53                	je     801010f8 <fileread+0x78>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010a5:	83 f8 02             	cmp    $0x2,%eax
801010a8:	75 6d                	jne    80101117 <fileread+0x97>
    ilock(f->ip);
801010aa:	8b 43 10             	mov    0x10(%ebx),%eax
801010ad:	89 04 24             	mov    %eax,(%esp)
801010b0:	e8 8b 07 00 00       	call   80101840 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010b5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801010b9:	8b 43 14             	mov    0x14(%ebx),%eax
801010bc:	89 74 24 04          	mov    %esi,0x4(%esp)
801010c0:	89 44 24 08          	mov    %eax,0x8(%esp)
801010c4:	8b 43 10             	mov    0x10(%ebx),%eax
801010c7:	89 04 24             	mov    %eax,(%esp)
801010ca:	e8 71 0a 00 00       	call   80101b40 <readi>
801010cf:	85 c0                	test   %eax,%eax
801010d1:	89 c6                	mov    %eax,%esi
801010d3:	7e 03                	jle    801010d8 <fileread+0x58>
      f->off += r;
801010d5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801010d8:	8b 43 10             	mov    0x10(%ebx),%eax
801010db:	89 04 24             	mov    %eax,(%esp)
801010de:	e8 3d 08 00 00       	call   80101920 <iunlock>
    return r;
  }
  panic("fileread");
}
801010e3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801010e6:	89 f0                	mov    %esi,%eax
801010e8:	8b 75 f8             	mov    -0x8(%ebp),%esi
801010eb:	8b 7d fc             	mov    -0x4(%ebp),%edi
801010ee:	89 ec                	mov    %ebp,%esp
801010f0:	5d                   	pop    %ebp
801010f1:	c3                   	ret
801010f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return piperead(f->pipe, addr, n);
801010f8:	8b 43 0c             	mov    0xc(%ebx),%eax
}
801010fb:	8b 75 f8             	mov    -0x8(%ebp),%esi
801010fe:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101101:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return piperead(f->pipe, addr, n);
80101104:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101107:	89 ec                	mov    %ebp,%esp
80101109:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010110a:	e9 61 26 00 00       	jmp    80103770 <piperead>
8010110f:	90                   	nop
    return -1;
80101110:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101115:	eb cc                	jmp    801010e3 <fileread+0x63>
  panic("fileread");
80101117:	c7 04 24 15 7b 10 80 	movl   $0x80107b15,(%esp)
8010111e:	e8 2d f2 ff ff       	call   80100350 <panic>
80101123:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010112a:	00 
8010112b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101130 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101130:	55                   	push   %ebp
80101131:	89 e5                	mov    %esp,%ebp
80101133:	57                   	push   %edi
80101134:	56                   	push   %esi
80101135:	53                   	push   %ebx
80101136:	83 ec 2c             	sub    $0x2c,%esp
80101139:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010113c:	8b 45 10             	mov    0x10(%ebp),%eax
8010113f:	8b 55 0c             	mov    0xc(%ebp),%edx
  int r;

  if(f->writable == 0)
80101142:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101146:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101149:	0f 84 c6 00 00 00    	je     80101215 <filewrite+0xe5>
    return -1;
  if(f->type == FD_PIPE)
8010114f:	8b 03                	mov    (%ebx),%eax
80101151:	83 f8 01             	cmp    $0x1,%eax
80101154:	0f 84 ca 00 00 00    	je     80101224 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010115a:	83 f8 02             	cmp    $0x2,%eax
8010115d:	0f 85 d3 00 00 00    	jne    80101236 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101163:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101166:	31 ff                	xor    %edi,%edi
    while(i < n){
80101168:	85 c0                	test   %eax,%eax
8010116a:	0f 8e a0 00 00 00    	jle    80101210 <filewrite+0xe0>
    int i = 0;
80101170:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101173:	89 de                	mov    %ebx,%esi
80101175:	eb 2a                	jmp    801011a1 <filewrite+0x71>
80101177:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010117e:	00 
8010117f:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101180:	01 56 14             	add    %edx,0x14(%esi)
      iunlock(f->ip);
80101183:	89 04 24             	mov    %eax,(%esp)
        f->off += r;
80101186:	89 55 e0             	mov    %edx,-0x20(%ebp)
      iunlock(f->ip);
80101189:	e8 92 07 00 00       	call   80101920 <iunlock>
      end_op();
8010118e:	e8 2d 1d 00 00       	call   80102ec0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101193:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101196:	39 da                	cmp    %ebx,%edx
80101198:	75 65                	jne    801011ff <filewrite+0xcf>
        panic("short filewrite");
      i += r;
8010119a:	01 d7                	add    %edx,%edi
    while(i < n){
8010119c:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
8010119f:	7e 6f                	jle    80101210 <filewrite+0xe0>
      int n1 = n - i;
801011a1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
      if(n1 > max)
801011a4:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
801011a9:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
801011ab:	39 c3                	cmp    %eax,%ebx
801011ad:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801011b0:	e8 9b 1c 00 00       	call   80102e50 <begin_op>
      ilock(f->ip);
801011b5:	8b 46 10             	mov    0x10(%esi),%eax
801011b8:	89 04 24             	mov    %eax,(%esp)
801011bb:	e8 80 06 00 00       	call   80101840 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011c0:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
801011c4:	8b 46 14             	mov    0x14(%esi),%eax
801011c7:	89 44 24 08          	mov    %eax,0x8(%esp)
801011cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011ce:	01 f8                	add    %edi,%eax
801011d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801011d4:	8b 46 10             	mov    0x10(%esi),%eax
801011d7:	89 04 24             	mov    %eax,(%esp)
801011da:	e8 91 0a 00 00       	call   80101c70 <writei>
801011df:	89 c2                	mov    %eax,%edx
      iunlock(f->ip);
801011e1:	8b 46 10             	mov    0x10(%esi),%eax
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011e4:	85 d2                	test   %edx,%edx
801011e6:	7f 98                	jg     80101180 <filewrite+0x50>
      iunlock(f->ip);
801011e8:	89 04 24             	mov    %eax,(%esp)
801011eb:	89 55 e0             	mov    %edx,-0x20(%ebp)
801011ee:	e8 2d 07 00 00       	call   80101920 <iunlock>
      end_op();
801011f3:	e8 c8 1c 00 00       	call   80102ec0 <end_op>
      if(r < 0)
801011f8:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801011fb:	85 c9                	test   %ecx,%ecx
801011fd:	75 11                	jne    80101210 <filewrite+0xe0>
        panic("short filewrite");
801011ff:	c7 04 24 1e 7b 10 80 	movl   $0x80107b1e,(%esp)
80101206:	e8 45 f1 ff ff       	call   80100350 <panic>
8010120b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101210:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101213:	74 05                	je     8010121a <filewrite+0xea>
    return -1;
80101215:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  }
  panic("filewrite");
}
8010121a:	83 c4 2c             	add    $0x2c,%esp
8010121d:	89 f8                	mov    %edi,%eax
8010121f:	5b                   	pop    %ebx
80101220:	5e                   	pop    %esi
80101221:	5f                   	pop    %edi
80101222:	5d                   	pop    %ebp
80101223:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
80101224:	8b 43 0c             	mov    0xc(%ebx),%eax
80101227:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010122a:	83 c4 2c             	add    $0x2c,%esp
8010122d:	5b                   	pop    %ebx
8010122e:	5e                   	pop    %esi
8010122f:	5f                   	pop    %edi
80101230:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101231:	e9 2a 24 00 00       	jmp    80103660 <pipewrite>
  panic("filewrite");
80101236:	c7 04 24 24 7b 10 80 	movl   $0x80107b24,(%esp)
8010123d:	e8 0e f1 ff ff       	call   80100350 <panic>
80101242:	66 90                	xchg   %ax,%ax
80101244:	66 90                	xchg   %ax,%ax
80101246:	66 90                	xchg   %ax,%ax
80101248:	66 90                	xchg   %ax,%ax
8010124a:	66 90                	xchg   %ax,%ax
8010124c:	66 90                	xchg   %ax,%ax
8010124e:	66 90                	xchg   %ax,%ax

80101250 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101250:	55                   	push   %ebp
80101251:	89 e5                	mov    %esp,%ebp
80101253:	57                   	push   %edi
80101254:	56                   	push   %esi
80101255:	53                   	push   %ebx
80101256:	83 ec 2c             	sub    $0x2c,%esp
80101259:	89 45 dc             	mov    %eax,-0x24(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010125c:	8b 35 b4 25 11 80    	mov    0x801125b4,%esi
80101262:	85 f6                	test   %esi,%esi
80101264:	0f 84 7f 00 00 00    	je     801012e9 <balloc+0x99>
8010126a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010126c:	8b 1d cc 25 11 80    	mov    0x801125cc,%ebx
80101272:	89 f8                	mov    %edi,%eax
80101274:	89 fe                	mov    %edi,%esi
80101276:	c1 f8 0c             	sar    $0xc,%eax
80101279:	01 d8                	add    %ebx,%eax
8010127b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010127f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101282:	89 04 24             	mov    %eax,(%esp)
80101285:	e8 46 ee ff ff       	call   801000d0 <bread>
8010128a:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010128d:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010128f:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101294:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101297:	31 c0                	xor    %eax,%eax
80101299:	eb 2e                	jmp    801012c9 <balloc+0x79>
8010129b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      m = 1 << (bi % 8);
801012a0:	89 c1                	mov    %eax,%ecx
801012a2:	ba 01 00 00 00       	mov    $0x1,%edx
801012a7:	83 e1 07             	and    $0x7,%ecx
801012aa:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012ac:	89 c1                	mov    %eax,%ecx
      m = 1 << (bi % 8);
801012ae:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012b1:	c1 f9 03             	sar    $0x3,%ecx
801012b4:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
801012b9:	85 7d e4             	test   %edi,-0x1c(%ebp)
801012bc:	89 fa                	mov    %edi,%edx
801012be:	74 38                	je     801012f8 <balloc+0xa8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012c0:	40                   	inc    %eax
801012c1:	46                   	inc    %esi
801012c2:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012c7:	74 07                	je     801012d0 <balloc+0x80>
801012c9:	8b 7d e0             	mov    -0x20(%ebp),%edi
801012cc:	39 fe                	cmp    %edi,%esi
801012ce:	72 d0                	jb     801012a0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801012d0:	89 1c 24             	mov    %ebx,(%esp)
801012d3:	8b 7d d8             	mov    -0x28(%ebp),%edi
801012d6:	e8 05 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012db:	81 c7 00 10 00 00    	add    $0x1000,%edi
801012e1:	3b 3d b4 25 11 80    	cmp    0x801125b4,%edi
801012e7:	72 83                	jb     8010126c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
801012e9:	c7 04 24 2e 7b 10 80 	movl   $0x80107b2e,(%esp)
801012f0:	e8 5b f0 ff ff       	call   80100350 <panic>
801012f5:	8d 76 00             	lea    0x0(%esi),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801012f8:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
801012fc:	08 c2                	or     %al,%dl
801012fe:	88 54 0b 5c          	mov    %dl,0x5c(%ebx,%ecx,1)
        log_write(bp);
80101302:	89 1c 24             	mov    %ebx,(%esp)
80101305:	e8 e6 1c 00 00       	call   80102ff0 <log_write>
        brelse(bp);
8010130a:	89 1c 24             	mov    %ebx,(%esp)
8010130d:	e8 ce ee ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
80101312:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101315:	89 74 24 04          	mov    %esi,0x4(%esp)
80101319:	89 04 24             	mov    %eax,(%esp)
8010131c:	e8 af ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101321:	ba 00 02 00 00       	mov    $0x200,%edx
80101326:	31 c9                	xor    %ecx,%ecx
80101328:	89 54 24 08          	mov    %edx,0x8(%esp)
8010132c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  bp = bread(dev, bno);
80101330:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101332:	8d 40 5c             	lea    0x5c(%eax),%eax
80101335:	89 04 24             	mov    %eax,(%esp)
80101338:	e8 63 38 00 00       	call   80104ba0 <memset>
  log_write(bp);
8010133d:	89 1c 24             	mov    %ebx,(%esp)
80101340:	e8 ab 1c 00 00       	call   80102ff0 <log_write>
  brelse(bp);
80101345:	89 1c 24             	mov    %ebx,(%esp)
80101348:	e8 93 ee ff ff       	call   801001e0 <brelse>
}
8010134d:	83 c4 2c             	add    $0x2c,%esp
80101350:	89 f0                	mov    %esi,%eax
80101352:	5b                   	pop    %ebx
80101353:	5e                   	pop    %esi
80101354:	5f                   	pop    %edi
80101355:	5d                   	pop    %ebp
80101356:	c3                   	ret
80101357:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010135e:	00 
8010135f:	90                   	nop

80101360 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101364:	31 ff                	xor    %edi,%edi
{
80101366:	56                   	push   %esi
80101367:	89 c6                	mov    %eax,%esi
80101369:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010136a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010136f:	83 ec 2c             	sub    $0x2c,%esp
  acquire(&icache.lock);
80101372:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
{
80101379:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
8010137c:	e8 1f 37 00 00       	call   80104aa0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101381:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101384:	eb 1c                	jmp    801013a2 <iget+0x42>
80101386:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010138d:	00 
8010138e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101390:	39 33                	cmp    %esi,(%ebx)
80101392:	74 6c                	je     80101400 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101394:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010139a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013a0:	74 2e                	je     801013d0 <iget+0x70>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013a2:	8b 43 08             	mov    0x8(%ebx),%eax
801013a5:	85 c0                	test   %eax,%eax
801013a7:	7f e7                	jg     80101390 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013a9:	85 ff                	test   %edi,%edi
801013ab:	75 e7                	jne    80101394 <iget+0x34>
801013ad:	85 c0                	test   %eax,%eax
801013af:	90                   	nop
801013b0:	75 6f                	jne    80101421 <iget+0xc1>
      empty = ip;
801013b2:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013b4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013ba:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013c0:	75 e0                	jne    801013a2 <iget+0x42>
801013c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801013c9:	00 
801013ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801013d0:	85 ff                	test   %edi,%edi
801013d2:	74 6b                	je     8010143f <iget+0xdf>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801013d4:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
801013d6:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
801013d9:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
801013e0:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
801013e7:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801013ee:	e8 3d 36 00 00       	call   80104a30 <release>

  return ip;
}
801013f3:	83 c4 2c             	add    $0x2c,%esp
801013f6:	89 f8                	mov    %edi,%eax
801013f8:	5b                   	pop    %ebx
801013f9:	5e                   	pop    %esi
801013fa:	5f                   	pop    %edi
801013fb:	5d                   	pop    %ebp
801013fc:	c3                   	ret
801013fd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101400:	39 53 04             	cmp    %edx,0x4(%ebx)
80101403:	75 8f                	jne    80101394 <iget+0x34>
      ip->ref++;
80101405:	40                   	inc    %eax
      return ip;
80101406:	89 df                	mov    %ebx,%edi
      ip->ref++;
80101408:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
8010140b:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101412:	e8 19 36 00 00       	call   80104a30 <release>
}
80101417:	83 c4 2c             	add    $0x2c,%esp
8010141a:	89 f8                	mov    %edi,%eax
8010141c:	5b                   	pop    %ebx
8010141d:	5e                   	pop    %esi
8010141e:	5f                   	pop    %edi
8010141f:	5d                   	pop    %ebp
80101420:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101421:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101427:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
8010142d:	74 10                	je     8010143f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010142f:	8b 43 08             	mov    0x8(%ebx),%eax
80101432:	85 c0                	test   %eax,%eax
80101434:	0f 8f 56 ff ff ff    	jg     80101390 <iget+0x30>
8010143a:	e9 6e ff ff ff       	jmp    801013ad <iget+0x4d>
    panic("iget: no inodes");
8010143f:	c7 04 24 44 7b 10 80 	movl   $0x80107b44,(%esp)
80101446:	e8 05 ef ff ff       	call   80100350 <panic>
8010144b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101450 <bfree>:
{
80101450:	55                   	push   %ebp
80101451:	89 c1                	mov    %eax,%ecx
80101453:	89 e5                	mov    %esp,%ebp
  bp = bread(dev, BBLOCK(b, sb));
80101455:	89 d0                	mov    %edx,%eax
{
80101457:	56                   	push   %esi
80101458:	53                   	push   %ebx
80101459:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
8010145b:	c1 e8 0c             	shr    $0xc,%eax
{
8010145e:	83 ec 10             	sub    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101461:	89 0c 24             	mov    %ecx,(%esp)
80101464:	8b 15 cc 25 11 80    	mov    0x801125cc,%edx
8010146a:	01 d0                	add    %edx,%eax
8010146c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101470:	e8 5b ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101475:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101477:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010147a:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010147d:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101483:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101485:	b8 01 00 00 00       	mov    $0x1,%eax
8010148a:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
8010148c:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101491:	85 c1                	test   %eax,%ecx
80101493:	74 1f                	je     801014b4 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101495:	f6 d0                	not    %al
80101497:	20 c8                	and    %cl,%al
80101499:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010149d:	89 34 24             	mov    %esi,(%esp)
801014a0:	e8 4b 1b 00 00       	call   80102ff0 <log_write>
  brelse(bp);
801014a5:	89 34 24             	mov    %esi,(%esp)
801014a8:	e8 33 ed ff ff       	call   801001e0 <brelse>
}
801014ad:	83 c4 10             	add    $0x10,%esp
801014b0:	5b                   	pop    %ebx
801014b1:	5e                   	pop    %esi
801014b2:	5d                   	pop    %ebp
801014b3:	c3                   	ret
    panic("freeing free block");
801014b4:	c7 04 24 54 7b 10 80 	movl   $0x80107b54,(%esp)
801014bb:	e8 90 ee ff ff       	call   80100350 <panic>

801014c0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014c0:	55                   	push   %ebp
801014c1:	89 e5                	mov    %esp,%ebp
801014c3:	83 ec 38             	sub    $0x38,%esp
801014c6:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014c9:	83 fa 0b             	cmp    $0xb,%edx
{
801014cc:	89 c6                	mov    %eax,%esi
801014ce:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801014d1:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(bn < NDIRECT){
801014d4:	76 7a                	jbe    80101550 <bmap+0x90>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801014d6:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801014d9:	83 fb 7f             	cmp    $0x7f,%ebx
801014dc:	0f 87 95 00 00 00    	ja     80101577 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801014e2:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801014e8:	85 c0                	test   %eax,%eax
801014ea:	74 54                	je     80101540 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801014ec:	89 44 24 04          	mov    %eax,0x4(%esp)
801014f0:	8b 06                	mov    (%esi),%eax
801014f2:	89 04 24             	mov    %eax,(%esp)
801014f5:	e8 d6 eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801014fa:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801014fe:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
80101500:	8b 3b                	mov    (%ebx),%edi
80101502:	85 ff                	test   %edi,%edi
80101504:	74 1a                	je     80101520 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101506:	89 14 24             	mov    %edx,(%esp)
80101509:	e8 d2 ec ff ff       	call   801001e0 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
8010150e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101511:	89 f8                	mov    %edi,%eax
80101513:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101516:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101519:	89 ec                	mov    %ebp,%esp
8010151b:	5d                   	pop    %ebp
8010151c:	c3                   	ret
8010151d:	8d 76 00             	lea    0x0(%esi),%esi
80101520:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101523:	8b 06                	mov    (%esi),%eax
80101525:	e8 26 fd ff ff       	call   80101250 <balloc>
      log_write(bp);
8010152a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      a[bn] = addr = balloc(ip->dev);
8010152d:	89 03                	mov    %eax,(%ebx)
8010152f:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101531:	89 14 24             	mov    %edx,(%esp)
80101534:	e8 b7 1a 00 00       	call   80102ff0 <log_write>
80101539:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010153c:	eb c8                	jmp    80101506 <bmap+0x46>
8010153e:	66 90                	xchg   %ax,%ax
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101540:	8b 06                	mov    (%esi),%eax
80101542:	e8 09 fd ff ff       	call   80101250 <balloc>
80101547:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010154d:	eb 9d                	jmp    801014ec <bmap+0x2c>
8010154f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101550:	8d 5a 14             	lea    0x14(%edx),%ebx
80101553:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101557:	85 ff                	test   %edi,%edi
80101559:	75 b3                	jne    8010150e <bmap+0x4e>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010155b:	8b 00                	mov    (%eax),%eax
8010155d:	e8 ee fc ff ff       	call   80101250 <balloc>
80101562:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101566:	89 c7                	mov    %eax,%edi
}
80101568:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010156b:	89 f8                	mov    %edi,%eax
8010156d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101570:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101573:	89 ec                	mov    %ebp,%esp
80101575:	5d                   	pop    %ebp
80101576:	c3                   	ret
  panic("bmap: out of range");
80101577:	c7 04 24 67 7b 10 80 	movl   $0x80107b67,(%esp)
8010157e:	e8 cd ed ff ff       	call   80100350 <panic>
80101583:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010158a:	00 
8010158b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101590 <readsb>:
{
80101590:	55                   	push   %ebp
  bp = bread(dev, 1);
80101591:	b8 01 00 00 00       	mov    $0x1,%eax
{
80101596:	89 e5                	mov    %esp,%ebp
80101598:	83 ec 18             	sub    $0x18,%esp
8010159b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010159e:	89 75 fc             	mov    %esi,-0x4(%ebp)
801015a1:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801015a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801015a8:	8b 45 08             	mov    0x8(%ebp),%eax
801015ab:	89 04 24             	mov    %eax,(%esp)
801015ae:	e8 1d eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015b3:	ba 1c 00 00 00       	mov    $0x1c,%edx
801015b8:	89 34 24             	mov    %esi,(%esp)
801015bb:	89 54 24 08          	mov    %edx,0x8(%esp)
  bp = bread(dev, 1);
801015bf:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015c1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801015c8:	e8 63 36 00 00       	call   80104c30 <memmove>
}
801015cd:	8b 75 fc             	mov    -0x4(%ebp),%esi
  brelse(bp);
801015d0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801015d3:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801015d6:	89 ec                	mov    %ebp,%esp
801015d8:	5d                   	pop    %ebp
  brelse(bp);
801015d9:	e9 02 ec ff ff       	jmp    801001e0 <brelse>
801015de:	66 90                	xchg   %ax,%ax

801015e0 <iinit>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	83 ec 28             	sub    $0x28,%esp
801015e6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  initlock(&icache.lock, "icache");
801015e9:	bb 7a 7b 10 80       	mov    $0x80107b7a,%ebx
801015ee:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801015f2:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
801015f7:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801015fe:	e8 9d 32 00 00       	call   801048a0 <initlock>
  for(i = 0; i < NINODE; i++) {
80101603:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010160a:	00 
8010160b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101610:	89 1c 24             	mov    %ebx,(%esp)
80101613:	b9 81 7b 10 80       	mov    $0x80107b81,%ecx
  for(i = 0; i < NINODE; i++) {
80101618:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010161e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80101622:	e8 39 31 00 00       	call   80104760 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101627:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
8010162d:	75 e1                	jne    80101610 <iinit+0x30>
  bp = bread(dev, 1);
8010162f:	b8 01 00 00 00       	mov    $0x1,%eax
80101634:	89 44 24 04          	mov    %eax,0x4(%esp)
80101638:	8b 45 08             	mov    0x8(%ebp),%eax
8010163b:	89 04 24             	mov    %eax,(%esp)
8010163e:	e8 8d ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101643:	ba 1c 00 00 00       	mov    $0x1c,%edx
80101648:	89 54 24 08          	mov    %edx,0x8(%esp)
8010164c:	c7 04 24 b4 25 11 80 	movl   $0x801125b4,(%esp)
  bp = bread(dev, 1);
80101653:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101655:	8d 40 5c             	lea    0x5c(%eax),%eax
80101658:	89 44 24 04          	mov    %eax,0x4(%esp)
8010165c:	e8 cf 35 00 00       	call   80104c30 <memmove>
  brelse(bp);
80101661:	89 1c 24             	mov    %ebx,(%esp)
80101664:	e8 77 eb ff ff       	call   801001e0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101669:	a1 cc 25 11 80       	mov    0x801125cc,%eax
8010166e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101672:	a1 c8 25 11 80       	mov    0x801125c8,%eax
80101677:	89 44 24 18          	mov    %eax,0x18(%esp)
8010167b:	a1 c4 25 11 80       	mov    0x801125c4,%eax
80101680:	89 44 24 14          	mov    %eax,0x14(%esp)
80101684:	a1 c0 25 11 80       	mov    0x801125c0,%eax
80101689:	89 44 24 10          	mov    %eax,0x10(%esp)
8010168d:	a1 bc 25 11 80       	mov    0x801125bc,%eax
80101692:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101696:	a1 b8 25 11 80       	mov    0x801125b8,%eax
8010169b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010169f:	a1 b4 25 11 80       	mov    0x801125b4,%eax
801016a4:	c7 04 24 d0 7f 10 80 	movl   $0x80107fd0,(%esp)
801016ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801016af:	e8 cc ef ff ff       	call   80100680 <cprintf>
}
801016b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016b7:	89 ec                	mov    %ebp,%esp
801016b9:	5d                   	pop    %ebp
801016ba:	c3                   	ret
801016bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801016c0 <ialloc>:
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	57                   	push   %edi
801016c4:	56                   	push   %esi
801016c5:	53                   	push   %ebx
801016c6:	83 ec 2c             	sub    $0x2c,%esp
801016c9:	0f bf 45 0c          	movswl 0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801016cd:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
801016d4:	8b 75 08             	mov    0x8(%ebp),%esi
801016d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801016da:	0f 86 91 00 00 00    	jbe    80101771 <ialloc+0xb1>
801016e0:	bf 01 00 00 00       	mov    $0x1,%edi
801016e5:	eb 1a                	jmp    80101701 <ialloc+0x41>
801016e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801016ee:	00 
801016ef:	90                   	nop
    brelse(bp);
801016f0:	89 1c 24             	mov    %ebx,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
801016f3:	47                   	inc    %edi
    brelse(bp);
801016f4:	e8 e7 ea ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801016f9:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
801016ff:	73 70                	jae    80101771 <ialloc+0xb1>
    bp = bread(dev, IBLOCK(inum, sb));
80101701:	89 34 24             	mov    %esi,(%esp)
80101704:	8b 0d c8 25 11 80    	mov    0x801125c8,%ecx
8010170a:	89 f8                	mov    %edi,%eax
8010170c:	c1 e8 03             	shr    $0x3,%eax
8010170f:	01 c8                	add    %ecx,%eax
80101711:	89 44 24 04          	mov    %eax,0x4(%esp)
80101715:	e8 b6 e9 ff ff       	call   801000d0 <bread>
8010171a:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
8010171c:	89 f8                	mov    %edi,%eax
8010171e:	83 e0 07             	and    $0x7,%eax
80101721:	c1 e0 06             	shl    $0x6,%eax
80101724:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101728:	66 83 39 00          	cmpw   $0x0,(%ecx)
8010172c:	75 c2                	jne    801016f0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
8010172e:	89 0c 24             	mov    %ecx,(%esp)
80101731:	31 d2                	xor    %edx,%edx
80101733:	b8 40 00 00 00       	mov    $0x40,%eax
80101738:	89 54 24 04          	mov    %edx,0x4(%esp)
8010173c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101740:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101743:	e8 58 34 00 00       	call   80104ba0 <memset>
      dip->type = type;
80101748:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010174b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010174e:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101751:	89 1c 24             	mov    %ebx,(%esp)
80101754:	e8 97 18 00 00       	call   80102ff0 <log_write>
      brelse(bp);
80101759:	89 1c 24             	mov    %ebx,(%esp)
8010175c:	e8 7f ea ff ff       	call   801001e0 <brelse>
}
80101761:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
80101764:	89 f0                	mov    %esi,%eax
}
80101766:	5b                   	pop    %ebx
      return iget(dev, inum);
80101767:	89 fa                	mov    %edi,%edx
}
80101769:	5e                   	pop    %esi
8010176a:	5f                   	pop    %edi
8010176b:	5d                   	pop    %ebp
      return iget(dev, inum);
8010176c:	e9 ef fb ff ff       	jmp    80101360 <iget>
  panic("ialloc: no inodes");
80101771:	c7 04 24 87 7b 10 80 	movl   $0x80107b87,(%esp)
80101778:	e8 d3 eb ff ff       	call   80100350 <panic>
8010177d:	8d 76 00             	lea    0x0(%esi),%esi

80101780 <iupdate>:
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	56                   	push   %esi
80101784:	53                   	push   %ebx
80101785:	83 ec 10             	sub    $0x10,%esp
80101788:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010178b:	8b 15 c8 25 11 80    	mov    0x801125c8,%edx
80101791:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101794:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101797:	c1 e8 03             	shr    $0x3,%eax
8010179a:	01 d0                	add    %edx,%eax
8010179c:	89 44 24 04          	mov    %eax,0x4(%esp)
801017a0:	8b 43 a4             	mov    -0x5c(%ebx),%eax
801017a3:	89 04 24             	mov    %eax,(%esp)
801017a6:	e8 25 e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801017ab:	0f bf 53 f4          	movswl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017af:	b9 34 00 00 00       	mov    $0x34,%ecx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017b4:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017b6:	8b 43 a8             	mov    -0x58(%ebx),%eax
801017b9:	83 e0 07             	and    $0x7,%eax
801017bc:	c1 e0 06             	shl    $0x6,%eax
801017bf:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801017c3:	66 89 10             	mov    %dx,(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017c6:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801017c9:	0f bf 53 f6          	movswl -0xa(%ebx),%edx
801017cd:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801017d1:	0f bf 53 f8          	movswl -0x8(%ebx),%edx
801017d5:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801017d9:	0f bf 53 fa          	movswl -0x6(%ebx),%edx
801017dd:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801017e1:	8b 53 fc             	mov    -0x4(%ebx),%edx
801017e4:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017e7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801017eb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801017ef:	89 04 24             	mov    %eax,(%esp)
801017f2:	e8 39 34 00 00       	call   80104c30 <memmove>
  log_write(bp);
801017f7:	89 34 24             	mov    %esi,(%esp)
801017fa:	e8 f1 17 00 00       	call   80102ff0 <log_write>
  brelse(bp);
801017ff:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101802:	83 c4 10             	add    $0x10,%esp
80101805:	5b                   	pop    %ebx
80101806:	5e                   	pop    %esi
80101807:	5d                   	pop    %ebp
  brelse(bp);
80101808:	e9 d3 e9 ff ff       	jmp    801001e0 <brelse>
8010180d:	8d 76 00             	lea    0x0(%esi),%esi

80101810 <idup>:
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	83 ec 18             	sub    $0x18,%esp
80101816:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80101819:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010181c:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101823:	e8 78 32 00 00       	call   80104aa0 <acquire>
  ip->ref++;
80101828:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
8010182b:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101832:	e8 f9 31 00 00       	call   80104a30 <release>
}
80101837:	89 d8                	mov    %ebx,%eax
80101839:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010183c:	89 ec                	mov    %ebp,%esp
8010183e:	5d                   	pop    %ebp
8010183f:	c3                   	ret

80101840 <ilock>:
{
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	56                   	push   %esi
80101844:	53                   	push   %ebx
80101845:	83 ec 10             	sub    $0x10,%esp
80101848:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
8010184b:	85 db                	test   %ebx,%ebx
8010184d:	0f 84 be 00 00 00    	je     80101911 <ilock+0xd1>
80101853:	8b 43 08             	mov    0x8(%ebx),%eax
80101856:	85 c0                	test   %eax,%eax
80101858:	0f 8e b3 00 00 00    	jle    80101911 <ilock+0xd1>
  acquiresleep(&ip->lock);
8010185e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101861:	89 04 24             	mov    %eax,(%esp)
80101864:	e8 37 2f 00 00       	call   801047a0 <acquiresleep>
  if(ip->valid == 0){
80101869:	8b 73 4c             	mov    0x4c(%ebx),%esi
8010186c:	85 f6                	test   %esi,%esi
8010186e:	74 10                	je     80101880 <ilock+0x40>
}
80101870:	83 c4 10             	add    $0x10,%esp
80101873:	5b                   	pop    %ebx
80101874:	5e                   	pop    %esi
80101875:	5d                   	pop    %ebp
80101876:	c3                   	ret
80101877:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010187e:	00 
8010187f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101880:	8b 43 04             	mov    0x4(%ebx),%eax
80101883:	8b 15 c8 25 11 80    	mov    0x801125c8,%edx
80101889:	c1 e8 03             	shr    $0x3,%eax
8010188c:	01 d0                	add    %edx,%eax
8010188e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101892:	8b 03                	mov    (%ebx),%eax
80101894:	89 04 24             	mov    %eax,(%esp)
80101897:	e8 34 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010189c:	b9 34 00 00 00       	mov    $0x34,%ecx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018a1:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018a3:	8b 43 04             	mov    0x4(%ebx),%eax
801018a6:	83 e0 07             	and    $0x7,%eax
801018a9:	c1 e0 06             	shl    $0x6,%eax
801018ac:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801018b0:	0f bf 10             	movswl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018b3:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801018b6:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801018ba:	0f bf 50 f6          	movswl -0xa(%eax),%edx
801018be:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801018c2:	0f bf 50 f8          	movswl -0x8(%eax),%edx
801018c6:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801018ca:	0f bf 50 fa          	movswl -0x6(%eax),%edx
801018ce:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801018d2:	8b 50 fc             	mov    -0x4(%eax),%edx
801018d5:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018d8:	89 44 24 04          	mov    %eax,0x4(%esp)
801018dc:	8d 43 5c             	lea    0x5c(%ebx),%eax
801018df:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801018e3:	89 04 24             	mov    %eax,(%esp)
801018e6:	e8 45 33 00 00       	call   80104c30 <memmove>
    brelse(bp);
801018eb:	89 34 24             	mov    %esi,(%esp)
801018ee:	e8 ed e8 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
801018f3:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801018f8:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018ff:	0f 85 6b ff ff ff    	jne    80101870 <ilock+0x30>
      panic("ilock: no type");
80101905:	c7 04 24 9f 7b 10 80 	movl   $0x80107b9f,(%esp)
8010190c:	e8 3f ea ff ff       	call   80100350 <panic>
    panic("ilock");
80101911:	c7 04 24 99 7b 10 80 	movl   $0x80107b99,(%esp)
80101918:	e8 33 ea ff ff       	call   80100350 <panic>
8010191d:	8d 76 00             	lea    0x0(%esi),%esi

80101920 <iunlock>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	83 ec 18             	sub    $0x18,%esp
80101926:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80101929:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010192c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010192f:	85 db                	test   %ebx,%ebx
80101931:	74 27                	je     8010195a <iunlock+0x3a>
80101933:	8d 73 0c             	lea    0xc(%ebx),%esi
80101936:	89 34 24             	mov    %esi,(%esp)
80101939:	e8 02 2f 00 00       	call   80104840 <holdingsleep>
8010193e:	85 c0                	test   %eax,%eax
80101940:	74 18                	je     8010195a <iunlock+0x3a>
80101942:	8b 43 08             	mov    0x8(%ebx),%eax
80101945:	85 c0                	test   %eax,%eax
80101947:	7e 11                	jle    8010195a <iunlock+0x3a>
  releasesleep(&ip->lock);
80101949:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010194c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010194f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80101952:	89 ec                	mov    %ebp,%esp
80101954:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101955:	e9 a6 2e 00 00       	jmp    80104800 <releasesleep>
    panic("iunlock");
8010195a:	c7 04 24 ae 7b 10 80 	movl   $0x80107bae,(%esp)
80101961:	e8 ea e9 ff ff       	call   80100350 <panic>
80101966:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010196d:	00 
8010196e:	66 90                	xchg   %ax,%ax

80101970 <iput>:
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	83 ec 38             	sub    $0x38,%esp
80101976:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101979:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010197c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010197f:	89 75 f8             	mov    %esi,-0x8(%ebp)
  acquiresleep(&ip->lock);
80101982:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101985:	89 3c 24             	mov    %edi,(%esp)
80101988:	e8 13 2e 00 00       	call   801047a0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010198d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101990:	85 d2                	test   %edx,%edx
80101992:	74 07                	je     8010199b <iput+0x2b>
80101994:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101999:	74 35                	je     801019d0 <iput+0x60>
  releasesleep(&ip->lock);
8010199b:	89 3c 24             	mov    %edi,(%esp)
8010199e:	e8 5d 2e 00 00       	call   80104800 <releasesleep>
  acquire(&icache.lock);
801019a3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801019aa:	e8 f1 30 00 00       	call   80104aa0 <acquire>
  ip->ref--;
801019af:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
801019b2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
801019b9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801019bc:	8b 75 f8             	mov    -0x8(%ebp),%esi
801019bf:	8b 7d fc             	mov    -0x4(%ebp),%edi
801019c2:	89 ec                	mov    %ebp,%esp
801019c4:	5d                   	pop    %ebp
  release(&icache.lock);
801019c5:	e9 66 30 00 00       	jmp    80104a30 <release>
801019ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801019d0:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801019d7:	e8 c4 30 00 00       	call   80104aa0 <acquire>
    int r = ip->ref;
801019dc:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801019df:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801019e6:	e8 45 30 00 00       	call   80104a30 <release>
    if(r == 1){
801019eb:	4e                   	dec    %esi
801019ec:	75 ad                	jne    8010199b <iput+0x2b>
801019ee:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019f1:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801019f7:	89 df                	mov    %ebx,%edi
801019f9:	8d 73 5c             	lea    0x5c(%ebx),%esi
801019fc:	89 cb                	mov    %ecx,%ebx
801019fe:	eb 07                	jmp    80101a07 <iput+0x97>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a00:	83 c6 04             	add    $0x4,%esi
80101a03:	39 de                	cmp    %ebx,%esi
80101a05:	74 19                	je     80101a20 <iput+0xb0>
    if(ip->addrs[i]){
80101a07:	8b 16                	mov    (%esi),%edx
80101a09:	85 d2                	test   %edx,%edx
80101a0b:	74 f3                	je     80101a00 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a0d:	8b 07                	mov    (%edi),%eax
80101a0f:	e8 3c fa ff ff       	call   80101450 <bfree>
      ip->addrs[i] = 0;
80101a14:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101a1a:	eb e4                	jmp    80101a00 <iput+0x90>
80101a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a20:	89 fb                	mov    %edi,%ebx
80101a22:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a25:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101a2b:	85 c0                	test   %eax,%eax
80101a2d:	75 29                	jne    80101a58 <iput+0xe8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101a2f:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101a36:	89 1c 24             	mov    %ebx,(%esp)
80101a39:	e8 42 fd ff ff       	call   80101780 <iupdate>
      ip->type = 0;
80101a3e:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
80101a44:	89 1c 24             	mov    %ebx,(%esp)
80101a47:	e8 34 fd ff ff       	call   80101780 <iupdate>
      ip->valid = 0;
80101a4c:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a53:	e9 43 ff ff ff       	jmp    8010199b <iput+0x2b>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a58:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a5c:	8b 03                	mov    (%ebx),%eax
80101a5e:	89 04 24             	mov    %eax,(%esp)
80101a61:	e8 6a e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101a66:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a69:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a6c:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a72:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a75:	89 cf                	mov    %ecx,%edi
80101a77:	eb 0e                	jmp    80101a87 <iput+0x117>
80101a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a80:	83 c6 04             	add    $0x4,%esi
80101a83:	39 fe                	cmp    %edi,%esi
80101a85:	74 0f                	je     80101a96 <iput+0x126>
      if(a[j])
80101a87:	8b 16                	mov    (%esi),%edx
80101a89:	85 d2                	test   %edx,%edx
80101a8b:	74 f3                	je     80101a80 <iput+0x110>
        bfree(ip->dev, a[j]);
80101a8d:	8b 03                	mov    (%ebx),%eax
80101a8f:	e8 bc f9 ff ff       	call   80101450 <bfree>
80101a94:	eb ea                	jmp    80101a80 <iput+0x110>
    brelse(bp);
80101a96:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a99:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a9c:	89 04 24             	mov    %eax,(%esp)
80101a9f:	e8 3c e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101aa4:	8b 03                	mov    (%ebx),%eax
80101aa6:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101aac:	e8 9f f9 ff ff       	call   80101450 <bfree>
    ip->addrs[NDIRECT] = 0;
80101ab1:	31 c0                	xor    %eax,%eax
80101ab3:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101ab9:	e9 71 ff ff ff       	jmp    80101a2f <iput+0xbf>
80101abe:	66 90                	xchg   %ax,%ax

80101ac0 <iunlockput>:
{
80101ac0:	55                   	push   %ebp
80101ac1:	89 e5                	mov    %esp,%ebp
80101ac3:	83 ec 18             	sub    $0x18,%esp
80101ac6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80101ac9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101acc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101acf:	85 db                	test   %ebx,%ebx
80101ad1:	74 2f                	je     80101b02 <iunlockput+0x42>
80101ad3:	8d 73 0c             	lea    0xc(%ebx),%esi
80101ad6:	89 34 24             	mov    %esi,(%esp)
80101ad9:	e8 62 2d 00 00       	call   80104840 <holdingsleep>
80101ade:	85 c0                	test   %eax,%eax
80101ae0:	74 20                	je     80101b02 <iunlockput+0x42>
80101ae2:	8b 43 08             	mov    0x8(%ebx),%eax
80101ae5:	85 c0                	test   %eax,%eax
80101ae7:	7e 19                	jle    80101b02 <iunlockput+0x42>
  releasesleep(&ip->lock);
80101ae9:	89 34 24             	mov    %esi,(%esp)
80101aec:	e8 0f 2d 00 00       	call   80104800 <releasesleep>
}
80101af1:	8b 75 fc             	mov    -0x4(%ebp),%esi
  iput(ip);
80101af4:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101af7:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80101afa:	89 ec                	mov    %ebp,%esp
80101afc:	5d                   	pop    %ebp
  iput(ip);
80101afd:	e9 6e fe ff ff       	jmp    80101970 <iput>
    panic("iunlock");
80101b02:	c7 04 24 ae 7b 10 80 	movl   $0x80107bae,(%esp)
80101b09:	e8 42 e8 ff ff       	call   80100350 <panic>
80101b0e:	66 90                	xchg   %ax,%ax

80101b10 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	8b 55 08             	mov    0x8(%ebp),%edx
80101b16:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b19:	8b 0a                	mov    (%edx),%ecx
80101b1b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b1e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b21:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b24:	0f bf 4a 50          	movswl 0x50(%edx),%ecx
80101b28:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b2b:	0f bf 4a 56          	movswl 0x56(%edx),%ecx
80101b2f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b33:	8b 52 58             	mov    0x58(%edx),%edx
80101b36:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b39:	5d                   	pop    %ebp
80101b3a:	c3                   	ret
80101b3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101b40 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	57                   	push   %edi
80101b44:	56                   	push   %esi
80101b45:	53                   	push   %ebx
80101b46:	83 ec 2c             	sub    $0x2c,%esp
80101b49:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b4c:	8b 7d 08             	mov    0x8(%ebp),%edi
80101b4f:	8b 75 10             	mov    0x10(%ebp),%esi
80101b52:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101b55:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b58:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
80101b5d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b60:	0f 84 ca 00 00 00    	je     80101c30 <readi+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b66:	8b 47 58             	mov    0x58(%edi),%eax
80101b69:	39 f0                	cmp    %esi,%eax
80101b6b:	0f 82 e3 00 00 00    	jb     80101c54 <readi+0x114>
80101b71:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b74:	31 d2                	xor    %edx,%edx
80101b76:	01 f1                	add    %esi,%ecx
80101b78:	0f 82 dd 00 00 00    	jb     80101c5b <readi+0x11b>
80101b7e:	85 d2                	test   %edx,%edx
80101b80:	0f 85 ce 00 00 00    	jne    80101c54 <readi+0x114>
    return -1;
  if(off + n > ip->size)
80101b86:	39 c8                	cmp    %ecx,%eax
80101b88:	0f 82 92 00 00 00    	jb     80101c20 <readi+0xe0>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b91:	85 c0                	test   %eax,%eax
80101b93:	74 79                	je     80101c0e <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101b95:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80101b98:	89 d6                	mov    %edx,%esi
80101b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ba0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101ba3:	89 f8                	mov    %edi,%eax
80101ba5:	89 da                	mov    %ebx,%edx
80101ba7:	c1 ea 09             	shr    $0x9,%edx
80101baa:	e8 11 f9 ff ff       	call   801014c0 <bmap>
80101baf:	89 44 24 04          	mov    %eax,0x4(%esp)
80101bb3:	8b 07                	mov    (%edi),%eax
80101bb5:	89 04 24             	mov    %eax,(%esp)
80101bb8:	e8 13 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bbd:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bc2:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bc5:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101bc7:	89 d8                	mov    %ebx,%eax
80101bc9:	8b 5d e0             	mov    -0x20(%ebp),%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101bcc:	89 55 d8             	mov    %edx,-0x28(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101bcf:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bd4:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101bd6:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101bda:	89 44 24 04          	mov    %eax,0x4(%esp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101bde:	29 f3                	sub    %esi,%ebx
80101be0:	39 d9                	cmp    %ebx,%ecx
80101be2:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101be5:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101be8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bec:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101bee:	89 0c 24             	mov    %ecx,(%esp)
80101bf1:	e8 3a 30 00 00       	call   80104c30 <memmove>
    brelse(bp);
80101bf6:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101bf9:	89 14 24             	mov    %edx,(%esp)
80101bfc:	e8 df e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c01:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c04:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c07:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c0a:	39 de                	cmp    %ebx,%esi
80101c0c:	72 92                	jb     80101ba0 <readi+0x60>
  }
  return n;
80101c0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c11:	83 c4 2c             	add    $0x2c,%esp
80101c14:	5b                   	pop    %ebx
80101c15:	5e                   	pop    %esi
80101c16:	5f                   	pop    %edi
80101c17:	5d                   	pop    %ebp
80101c18:	c3                   	ret
80101c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = ip->size - off;
80101c20:	29 f0                	sub    %esi,%eax
80101c22:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101c25:	e9 64 ff ff ff       	jmp    80101b8e <readi+0x4e>
80101c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c30:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101c34:	66 83 f8 09          	cmp    $0x9,%ax
80101c38:	77 1a                	ja     80101c54 <readi+0x114>
80101c3a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80101c41:	85 c0                	test   %eax,%eax
80101c43:	74 0f                	je     80101c54 <readi+0x114>
    return devsw[ip->major].read(ip, dst, n);
80101c45:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c48:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c4b:	83 c4 2c             	add    $0x2c,%esp
80101c4e:	5b                   	pop    %ebx
80101c4f:	5e                   	pop    %esi
80101c50:	5f                   	pop    %edi
80101c51:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101c52:	ff e0                	jmp    *%eax
      return -1;
80101c54:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c59:	eb b6                	jmp    80101c11 <readi+0xd1>
80101c5b:	ba 01 00 00 00       	mov    $0x1,%edx
80101c60:	e9 19 ff ff ff       	jmp    80101b7e <readi+0x3e>
80101c65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c6c:	00 
80101c6d:	8d 76 00             	lea    0x0(%esi),%esi

80101c70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	83 ec 2c             	sub    $0x2c,%esp
80101c79:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c7c:	8b 7d 08             	mov    0x8(%ebp),%edi
80101c7f:	8b 75 10             	mov    0x10(%ebp),%esi
80101c82:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c85:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c88:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
80101c8d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(ip->type == T_DEV){
80101c90:	0f 84 da 00 00 00    	je     80101d70 <writei+0x100>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c96:	39 77 58             	cmp    %esi,0x58(%edi)
80101c99:	0f 82 06 01 00 00    	jb     80101da5 <writei+0x135>
80101c9f:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101ca2:	31 c0                	xor    %eax,%eax
80101ca4:	01 f2                	add    %esi,%edx
80101ca6:	0f 82 00 01 00 00    	jb     80101dac <writei+0x13c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101cac:	85 c0                	test   %eax,%eax
80101cae:	0f 85 f1 00 00 00    	jne    80101da5 <writei+0x135>
80101cb4:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101cba:	0f 87 e5 00 00 00    	ja     80101da5 <writei+0x135>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cc0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101cc3:	85 c0                	test   %eax,%eax
80101cc5:	0f 84 94 00 00 00    	je     80101d5f <writei+0xef>
80101ccb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101cd2:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80101cd5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101cdc:	00 
80101cdd:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ce0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101ce3:	89 f8                	mov    %edi,%eax
80101ce5:	89 da                	mov    %ebx,%edx
80101ce7:	c1 ea 09             	shr    $0x9,%edx
80101cea:	e8 d1 f7 ff ff       	call   801014c0 <bmap>
80101cef:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cf3:	8b 07                	mov    (%edi),%eax
80101cf5:	89 04 24             	mov    %eax,(%esp)
80101cf8:	e8 d3 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101cfd:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d00:	b9 00 02 00 00       	mov    $0x200,%ecx
80101d05:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d08:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101d0a:	89 d8                	mov    %ebx,%eax
80101d0c:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101d0f:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d14:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d16:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101d1a:	89 04 24             	mov    %eax,(%esp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101d1d:	29 d3                	sub    %edx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d1f:	8b 55 d8             	mov    -0x28(%ebp),%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101d22:	39 d9                	cmp    %ebx,%ecx
80101d24:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d27:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101d2b:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d2f:	e8 fc 2e 00 00       	call   80104c30 <memmove>
    log_write(bp);
80101d34:	89 34 24             	mov    %esi,(%esp)
80101d37:	e8 b4 12 00 00       	call   80102ff0 <log_write>
    brelse(bp);
80101d3c:	89 34 24             	mov    %esi,(%esp)
80101d3f:	e8 9c e4 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d44:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101d47:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d4a:	01 5d d8             	add    %ebx,-0x28(%ebp)
80101d4d:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101d50:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101d53:	39 d9                	cmp    %ebx,%ecx
80101d55:	72 89                	jb     80101ce0 <writei+0x70>
  }

  if(n > 0 && off > ip->size){
80101d57:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101d5a:	39 77 58             	cmp    %esi,0x58(%edi)
80101d5d:	72 39                	jb     80101d98 <writei+0x128>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d5f:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101d62:	83 c4 2c             	add    $0x2c,%esp
80101d65:	5b                   	pop    %ebx
80101d66:	5e                   	pop    %esi
80101d67:	5f                   	pop    %edi
80101d68:	5d                   	pop    %ebp
80101d69:	c3                   	ret
80101d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d70:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101d74:	66 83 f8 09          	cmp    $0x9,%ax
80101d78:	77 2b                	ja     80101da5 <writei+0x135>
80101d7a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101d81:	85 c0                	test   %eax,%eax
80101d83:	74 20                	je     80101da5 <writei+0x135>
    return devsw[ip->major].write(ip, src, n);
80101d85:	8b 7d dc             	mov    -0x24(%ebp),%edi
80101d88:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101d8b:	83 c4 2c             	add    $0x2c,%esp
80101d8e:	5b                   	pop    %ebx
80101d8f:	5e                   	pop    %esi
80101d90:	5f                   	pop    %edi
80101d91:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101d92:	ff e0                	jmp    *%eax
80101d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101d98:	89 77 58             	mov    %esi,0x58(%edi)
    iupdate(ip);
80101d9b:	89 3c 24             	mov    %edi,(%esp)
80101d9e:	e8 dd f9 ff ff       	call   80101780 <iupdate>
80101da3:	eb ba                	jmp    80101d5f <writei+0xef>
      return -1;
80101da5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101daa:	eb b6                	jmp    80101d62 <writei+0xf2>
80101dac:	b8 01 00 00 00       	mov    $0x1,%eax
80101db1:	e9 f6 fe ff ff       	jmp    80101cac <writei+0x3c>
80101db6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101dbd:	00 
80101dbe:	66 90                	xchg   %ax,%ax

80101dc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101dc0:	55                   	push   %ebp
  return strncmp(s, t, DIRSIZ);
80101dc1:	b8 0e 00 00 00       	mov    $0xe,%eax
{
80101dc6:	89 e5                	mov    %esp,%ebp
80101dc8:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101dcb:	89 44 24 08          	mov    %eax,0x8(%esp)
80101dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dd2:	89 44 24 04          	mov    %eax,0x4(%esp)
80101dd6:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd9:	89 04 24             	mov    %eax,(%esp)
80101ddc:	e8 bf 2e 00 00       	call   80104ca0 <strncmp>
}
80101de1:	89 ec                	mov    %ebp,%esp
80101de3:	5d                   	pop    %ebp
80101de4:	c3                   	ret
80101de5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101dec:	00 
80101ded:	8d 76 00             	lea    0x0(%esi),%esi

80101df0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	57                   	push   %edi
80101df4:	56                   	push   %esi
80101df5:	53                   	push   %ebx
80101df6:	83 ec 2c             	sub    $0x2c,%esp
80101df9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101dfc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101e01:	0f 85 a4 00 00 00    	jne    80101eab <dirlookup+0xbb>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101e07:	8b 43 58             	mov    0x58(%ebx),%eax
80101e0a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e0d:	31 ff                	xor    %edi,%edi
80101e0f:	85 c0                	test   %eax,%eax
80101e11:	74 59                	je     80101e6c <dirlookup+0x7c>
80101e13:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e1a:	00 
80101e1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e20:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101e24:	b9 10 00 00 00       	mov    $0x10,%ecx
80101e29:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101e2d:	89 74 24 04          	mov    %esi,0x4(%esp)
80101e31:	89 1c 24             	mov    %ebx,(%esp)
80101e34:	e8 07 fd ff ff       	call   80101b40 <readi>
80101e39:	83 f8 10             	cmp    $0x10,%eax
80101e3c:	75 61                	jne    80101e9f <dirlookup+0xaf>
      panic("dirlookup read");
    if(de.inum == 0)
80101e3e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e43:	74 1f                	je     80101e64 <dirlookup+0x74>
  return strncmp(s, t, DIRSIZ);
80101e45:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e48:	ba 0e 00 00 00       	mov    $0xe,%edx
80101e4d:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e51:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e54:	89 54 24 08          	mov    %edx,0x8(%esp)
80101e58:	89 04 24             	mov    %eax,(%esp)
80101e5b:	e8 40 2e 00 00       	call   80104ca0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e60:	85 c0                	test   %eax,%eax
80101e62:	74 1c                	je     80101e80 <dirlookup+0x90>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e64:	83 c7 10             	add    $0x10,%edi
80101e67:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e6a:	72 b4                	jb     80101e20 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e6c:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101e6f:	31 c0                	xor    %eax,%eax
}
80101e71:	5b                   	pop    %ebx
80101e72:	5e                   	pop    %esi
80101e73:	5f                   	pop    %edi
80101e74:	5d                   	pop    %ebp
80101e75:	c3                   	ret
80101e76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e7d:	00 
80101e7e:	66 90                	xchg   %ax,%ax
      if(poff)
80101e80:	8b 45 10             	mov    0x10(%ebp),%eax
80101e83:	85 c0                	test   %eax,%eax
80101e85:	74 05                	je     80101e8c <dirlookup+0x9c>
        *poff = off;
80101e87:	8b 45 10             	mov    0x10(%ebp),%eax
80101e8a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101e8c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101e90:	8b 03                	mov    (%ebx),%eax
80101e92:	e8 c9 f4 ff ff       	call   80101360 <iget>
}
80101e97:	83 c4 2c             	add    $0x2c,%esp
80101e9a:	5b                   	pop    %ebx
80101e9b:	5e                   	pop    %esi
80101e9c:	5f                   	pop    %edi
80101e9d:	5d                   	pop    %ebp
80101e9e:	c3                   	ret
      panic("dirlookup read");
80101e9f:	c7 04 24 c8 7b 10 80 	movl   $0x80107bc8,(%esp)
80101ea6:	e8 a5 e4 ff ff       	call   80100350 <panic>
    panic("dirlookup not DIR");
80101eab:	c7 04 24 b6 7b 10 80 	movl   $0x80107bb6,(%esp)
80101eb2:	e8 99 e4 ff ff       	call   80100350 <panic>
80101eb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ebe:	00 
80101ebf:	90                   	nop

80101ec0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
80101ec3:	57                   	push   %edi
80101ec4:	56                   	push   %esi
80101ec5:	53                   	push   %ebx
80101ec6:	89 c3                	mov    %eax,%ebx
80101ec8:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101ecb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101ece:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ed1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101ed4:	0f 84 9a 01 00 00    	je     80102074 <namex+0x1b4>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101eda:	e8 a1 1d 00 00       	call   80103c80 <myproc>
80101edf:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ee2:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101ee9:	e8 b2 2b 00 00       	call   80104aa0 <acquire>
  ip->ref++;
80101eee:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101ef1:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101ef8:	e8 33 2b 00 00       	call   80104a30 <release>
  return ip;
80101efd:	eb 02                	jmp    80101f01 <namex+0x41>
80101eff:	90                   	nop
    path++;
80101f00:	43                   	inc    %ebx
  while(*path == '/')
80101f01:	0f b6 03             	movzbl (%ebx),%eax
80101f04:	3c 2f                	cmp    $0x2f,%al
80101f06:	74 f8                	je     80101f00 <namex+0x40>
  if(*path == 0)
80101f08:	84 c0                	test   %al,%al
80101f0a:	0f 84 18 01 00 00    	je     80102028 <namex+0x168>
  while(*path != '/' && *path != 0)
80101f10:	0f b6 03             	movzbl (%ebx),%eax
80101f13:	84 c0                	test   %al,%al
80101f15:	0f 84 1e 01 00 00    	je     80102039 <namex+0x179>
80101f1b:	3c 2f                	cmp    $0x2f,%al
80101f1d:	89 df                	mov    %ebx,%edi
80101f1f:	0f 84 14 01 00 00    	je     80102039 <namex+0x179>
80101f25:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f2c:	00 
80101f2d:	8d 76 00             	lea    0x0(%esi),%esi
80101f30:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101f34:	47                   	inc    %edi
  while(*path != '/' && *path != 0)
80101f35:	3c 2f                	cmp    $0x2f,%al
80101f37:	74 04                	je     80101f3d <namex+0x7d>
80101f39:	84 c0                	test   %al,%al
80101f3b:	75 f3                	jne    80101f30 <namex+0x70>
  len = path - s;
80101f3d:	89 f8                	mov    %edi,%eax
80101f3f:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101f41:	83 f8 0d             	cmp    $0xd,%eax
80101f44:	0f 8e ae 00 00 00    	jle    80101ff8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101f4a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101f4e:	b8 0e 00 00 00       	mov    $0xe,%eax
80101f53:	89 fb                	mov    %edi,%ebx
80101f55:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101f5c:	89 04 24             	mov    %eax,(%esp)
80101f5f:	e8 cc 2c 00 00       	call   80104c30 <memmove>
  while(*path == '/')
80101f64:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101f67:	75 0d                	jne    80101f76 <namex+0xb6>
80101f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101f70:	43                   	inc    %ebx
  while(*path == '/')
80101f71:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f74:	74 fa                	je     80101f70 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f76:	89 34 24             	mov    %esi,(%esp)
80101f79:	e8 c2 f8 ff ff       	call   80101840 <ilock>
    if(ip->type != T_DIR){
80101f7e:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f83:	0f 85 b9 00 00 00    	jne    80102042 <namex+0x182>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f89:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f8c:	85 c0                	test   %eax,%eax
80101f8e:	74 09                	je     80101f99 <namex+0xd9>
80101f90:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f93:	0f 84 f1 00 00 00    	je     8010208a <namex+0x1ca>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f99:	89 34 24             	mov    %esi,(%esp)
80101f9c:	31 c0                	xor    %eax,%eax
80101f9e:	89 44 24 08          	mov    %eax,0x8(%esp)
80101fa2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101fa5:	89 44 24 04          	mov    %eax,0x4(%esp)
80101fa9:	e8 42 fe ff ff       	call   80101df0 <dirlookup>
80101fae:	85 c0                	test   %eax,%eax
80101fb0:	89 c7                	mov    %eax,%edi
80101fb2:	0f 84 8a 00 00 00    	je     80102042 <namex+0x182>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fb8:	8d 4e 0c             	lea    0xc(%esi),%ecx
80101fbb:	89 0c 24             	mov    %ecx,(%esp)
80101fbe:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101fc1:	e8 7a 28 00 00       	call   80104840 <holdingsleep>
80101fc6:	85 c0                	test   %eax,%eax
80101fc8:	0f 84 e4 00 00 00    	je     801020b2 <namex+0x1f2>
80101fce:	8b 4e 08             	mov    0x8(%esi),%ecx
80101fd1:	85 c9                	test   %ecx,%ecx
80101fd3:	0f 8e d9 00 00 00    	jle    801020b2 <namex+0x1f2>
  releasesleep(&ip->lock);
80101fd9:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101fdc:	89 0c 24             	mov    %ecx,(%esp)
80101fdf:	e8 1c 28 00 00       	call   80104800 <releasesleep>
  iput(ip);
80101fe4:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101fe7:	89 fe                	mov    %edi,%esi
  iput(ip);
80101fe9:	e8 82 f9 ff ff       	call   80101970 <iput>
  while(*path == '/')
80101fee:	e9 0e ff ff ff       	jmp    80101f01 <namex+0x41>
80101ff3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    name[len] = 0;
80101ff8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ffb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80101ffe:	89 44 24 08          	mov    %eax,0x8(%esp)
80102002:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102005:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    name[len] = 0;
80102009:	89 fb                	mov    %edi,%ebx
8010200b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    memmove(name, s, len);
8010200e:	89 04 24             	mov    %eax,(%esp)
80102011:	e8 1a 2c 00 00       	call   80104c30 <memmove>
    name[len] = 0;
80102016:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102019:	c6 01 00             	movb   $0x0,(%ecx)
8010201c:	e9 43 ff ff ff       	jmp    80101f64 <namex+0xa4>
80102021:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  if(nameiparent){
80102028:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010202b:	85 d2                	test   %edx,%edx
8010202d:	75 31                	jne    80102060 <namex+0x1a0>
    iput(ip);
    return 0;
  }
  return ip;
}
8010202f:	83 c4 2c             	add    $0x2c,%esp
80102032:	89 f0                	mov    %esi,%eax
80102034:	5b                   	pop    %ebx
80102035:	5e                   	pop    %esi
80102036:	5f                   	pop    %edi
80102037:	5d                   	pop    %ebp
80102038:	c3                   	ret
  while(*path != '/' && *path != 0)
80102039:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010203c:	89 df                	mov    %ebx,%edi
8010203e:	31 c0                	xor    %eax,%eax
80102040:	eb bc                	jmp    80101ffe <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102042:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102045:	89 1c 24             	mov    %ebx,(%esp)
80102048:	e8 f3 27 00 00       	call   80104840 <holdingsleep>
8010204d:	85 c0                	test   %eax,%eax
8010204f:	74 61                	je     801020b2 <namex+0x1f2>
80102051:	8b 7e 08             	mov    0x8(%esi),%edi
80102054:	85 ff                	test   %edi,%edi
80102056:	7e 5a                	jle    801020b2 <namex+0x1f2>
  releasesleep(&ip->lock);
80102058:	89 1c 24             	mov    %ebx,(%esp)
8010205b:	e8 a0 27 00 00       	call   80104800 <releasesleep>
  iput(ip);
80102060:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102063:	31 f6                	xor    %esi,%esi
  iput(ip);
80102065:	e8 06 f9 ff ff       	call   80101970 <iput>
}
8010206a:	83 c4 2c             	add    $0x2c,%esp
8010206d:	89 f0                	mov    %esi,%eax
8010206f:	5b                   	pop    %ebx
80102070:	5e                   	pop    %esi
80102071:	5f                   	pop    %edi
80102072:	5d                   	pop    %ebp
80102073:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102074:	ba 01 00 00 00       	mov    $0x1,%edx
80102079:	b8 01 00 00 00       	mov    $0x1,%eax
8010207e:	e8 dd f2 ff ff       	call   80101360 <iget>
80102083:	89 c6                	mov    %eax,%esi
80102085:	e9 77 fe ff ff       	jmp    80101f01 <namex+0x41>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010208a:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010208d:	89 1c 24             	mov    %ebx,(%esp)
80102090:	e8 ab 27 00 00       	call   80104840 <holdingsleep>
80102095:	85 c0                	test   %eax,%eax
80102097:	74 19                	je     801020b2 <namex+0x1f2>
80102099:	8b 46 08             	mov    0x8(%esi),%eax
8010209c:	85 c0                	test   %eax,%eax
8010209e:	7e 12                	jle    801020b2 <namex+0x1f2>
  releasesleep(&ip->lock);
801020a0:	89 1c 24             	mov    %ebx,(%esp)
801020a3:	e8 58 27 00 00       	call   80104800 <releasesleep>
}
801020a8:	83 c4 2c             	add    $0x2c,%esp
801020ab:	89 f0                	mov    %esi,%eax
801020ad:	5b                   	pop    %ebx
801020ae:	5e                   	pop    %esi
801020af:	5f                   	pop    %edi
801020b0:	5d                   	pop    %ebp
801020b1:	c3                   	ret
    panic("iunlock");
801020b2:	c7 04 24 ae 7b 10 80 	movl   $0x80107bae,(%esp)
801020b9:	e8 92 e2 ff ff       	call   80100350 <panic>
801020be:	66 90                	xchg   %ax,%ax

801020c0 <dirlink>:
{
801020c0:	55                   	push   %ebp
801020c1:	89 e5                	mov    %esp,%ebp
801020c3:	57                   	push   %edi
801020c4:	56                   	push   %esi
801020c5:	53                   	push   %ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801020c6:	31 db                	xor    %ebx,%ebx
{
801020c8:	83 ec 2c             	sub    $0x2c,%esp
  if((ip = dirlookup(dp, name, 0)) != 0){
801020cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
{
801020cf:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
801020d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801020d5:	89 3c 24             	mov    %edi,(%esp)
801020d8:	89 44 24 04          	mov    %eax,0x4(%esp)
801020dc:	e8 0f fd ff ff       	call   80101df0 <dirlookup>
801020e1:	85 c0                	test   %eax,%eax
801020e3:	0f 85 8e 00 00 00    	jne    80102177 <dirlink+0xb7>
  for(off = 0; off < dp->size; off += sizeof(de)){
801020e9:	8b 5f 58             	mov    0x58(%edi),%ebx
801020ec:	8d 75 d8             	lea    -0x28(%ebp),%esi
801020ef:	85 db                	test   %ebx,%ebx
801020f1:	74 3a                	je     8010212d <dirlink+0x6d>
801020f3:	8d 75 d8             	lea    -0x28(%ebp),%esi
801020f6:	31 db                	xor    %ebx,%ebx
801020f8:	eb 0e                	jmp    80102108 <dirlink+0x48>
801020fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102100:	83 c3 10             	add    $0x10,%ebx
80102103:	3b 5f 58             	cmp    0x58(%edi),%ebx
80102106:	73 25                	jae    8010212d <dirlink+0x6d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102108:	89 5c 24 08          	mov    %ebx,0x8(%esp)
8010210c:	b9 10 00 00 00       	mov    $0x10,%ecx
80102111:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80102115:	89 74 24 04          	mov    %esi,0x4(%esp)
80102119:	89 3c 24             	mov    %edi,(%esp)
8010211c:	e8 1f fa ff ff       	call   80101b40 <readi>
80102121:	83 f8 10             	cmp    $0x10,%eax
80102124:	75 60                	jne    80102186 <dirlink+0xc6>
    if(de.inum == 0)
80102126:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010212b:	75 d3                	jne    80102100 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
8010212d:	b8 0e 00 00 00       	mov    $0xe,%eax
80102132:	89 44 24 08          	mov    %eax,0x8(%esp)
80102136:	8b 45 0c             	mov    0xc(%ebp),%eax
80102139:	89 44 24 04          	mov    %eax,0x4(%esp)
8010213d:	8d 45 da             	lea    -0x26(%ebp),%eax
80102140:	89 04 24             	mov    %eax,(%esp)
80102143:	e8 98 2b 00 00       	call   80104ce0 <strncpy>
  de.inum = inum;
80102148:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010214b:	ba 10 00 00 00       	mov    $0x10,%edx
80102150:	89 54 24 0c          	mov    %edx,0xc(%esp)
80102154:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102158:	89 74 24 04          	mov    %esi,0x4(%esp)
8010215c:	89 3c 24             	mov    %edi,(%esp)
  de.inum = inum;
8010215f:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102163:	e8 08 fb ff ff       	call   80101c70 <writei>
80102168:	83 f8 10             	cmp    $0x10,%eax
8010216b:	75 25                	jne    80102192 <dirlink+0xd2>
  return 0;
8010216d:	31 c0                	xor    %eax,%eax
}
8010216f:	83 c4 2c             	add    $0x2c,%esp
80102172:	5b                   	pop    %ebx
80102173:	5e                   	pop    %esi
80102174:	5f                   	pop    %edi
80102175:	5d                   	pop    %ebp
80102176:	c3                   	ret
    iput(ip);
80102177:	89 04 24             	mov    %eax,(%esp)
8010217a:	e8 f1 f7 ff ff       	call   80101970 <iput>
    return -1;
8010217f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102184:	eb e9                	jmp    8010216f <dirlink+0xaf>
      panic("dirlink read");
80102186:	c7 04 24 d7 7b 10 80 	movl   $0x80107bd7,(%esp)
8010218d:	e8 be e1 ff ff       	call   80100350 <panic>
    panic("dirlink");
80102192:	c7 04 24 6f 7e 10 80 	movl   $0x80107e6f,(%esp)
80102199:	e8 b2 e1 ff ff       	call   80100350 <panic>
8010219e:	66 90                	xchg   %ax,%ax

801021a0 <namei>:

struct inode*
namei(char *path)
{
801021a0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801021a1:	31 d2                	xor    %edx,%edx
{
801021a3:	89 e5                	mov    %esp,%ebp
801021a5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801021a8:	8b 45 08             	mov    0x8(%ebp),%eax
801021ab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801021ae:	e8 0d fd ff ff       	call   80101ec0 <namex>
}
801021b3:	89 ec                	mov    %ebp,%esp
801021b5:	5d                   	pop    %ebp
801021b6:	c3                   	ret
801021b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021be:	00 
801021bf:	90                   	nop

801021c0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801021c0:	55                   	push   %ebp
  return namex(path, 1, name);
801021c1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801021c6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801021c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801021cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801021ce:	5d                   	pop    %ebp
  return namex(path, 1, name);
801021cf:	e9 ec fc ff ff       	jmp    80101ec0 <namex>
801021d4:	66 90                	xchg   %ax,%ax
801021d6:	66 90                	xchg   %ax,%ax
801021d8:	66 90                	xchg   %ax,%ax
801021da:	66 90                	xchg   %ax,%ax
801021dc:	66 90                	xchg   %ax,%ax
801021de:	66 90                	xchg   %ax,%ax

801021e0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801021e0:	55                   	push   %ebp
801021e1:	89 e5                	mov    %esp,%ebp
801021e3:	56                   	push   %esi
801021e4:	53                   	push   %ebx
801021e5:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
801021e8:	85 c0                	test   %eax,%eax
801021ea:	0f 84 a8 00 00 00    	je     80102298 <idestart+0xb8>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801021f0:	8b 48 08             	mov    0x8(%eax),%ecx
801021f3:	89 c6                	mov    %eax,%esi
801021f5:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
801021fb:	0f 87 8b 00 00 00    	ja     8010228c <idestart+0xac>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102201:	bb f7 01 00 00       	mov    $0x1f7,%ebx
80102206:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010220d:	00 
8010220e:	66 90                	xchg   %ax,%ax
80102210:	89 da                	mov    %ebx,%edx
80102212:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102213:	24 c0                	and    $0xc0,%al
80102215:	3c 40                	cmp    $0x40,%al
80102217:	75 f7                	jne    80102210 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102219:	ba f6 03 00 00       	mov    $0x3f6,%edx
8010221e:	31 c0                	xor    %eax,%eax
80102220:	ee                   	out    %al,(%dx)
80102221:	b0 01                	mov    $0x1,%al
80102223:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102228:	ee                   	out    %al,(%dx)
80102229:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010222e:	88 c8                	mov    %cl,%al
80102230:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102231:	c1 f9 08             	sar    $0x8,%ecx
80102234:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102239:	89 c8                	mov    %ecx,%eax
8010223b:	ee                   	out    %al,(%dx)
8010223c:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102241:	31 c0                	xor    %eax,%eax
80102243:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102244:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80102248:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010224d:	c0 e0 04             	shl    $0x4,%al
80102250:	24 10                	and    $0x10,%al
80102252:	0c e0                	or     $0xe0,%al
80102254:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102255:	f6 06 04             	testb  $0x4,(%esi)
80102258:	75 16                	jne    80102270 <idestart+0x90>
8010225a:	b0 20                	mov    $0x20,%al
8010225c:	89 da                	mov    %ebx,%edx
8010225e:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010225f:	83 c4 10             	add    $0x10,%esp
80102262:	5b                   	pop    %ebx
80102263:	5e                   	pop    %esi
80102264:	5d                   	pop    %ebp
80102265:	c3                   	ret
80102266:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010226d:	00 
8010226e:	66 90                	xchg   %ax,%ax
80102270:	b0 30                	mov    $0x30,%al
80102272:	89 da                	mov    %ebx,%edx
80102274:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102275:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
8010227a:	83 c6 5c             	add    $0x5c,%esi
8010227d:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102282:	fc                   	cld
80102283:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102285:	83 c4 10             	add    $0x10,%esp
80102288:	5b                   	pop    %ebx
80102289:	5e                   	pop    %esi
8010228a:	5d                   	pop    %ebp
8010228b:	c3                   	ret
    panic("incorrect blockno");
8010228c:	c7 04 24 ed 7b 10 80 	movl   $0x80107bed,(%esp)
80102293:	e8 b8 e0 ff ff       	call   80100350 <panic>
    panic("idestart");
80102298:	c7 04 24 e4 7b 10 80 	movl   $0x80107be4,(%esp)
8010229f:	e8 ac e0 ff ff       	call   80100350 <panic>
801022a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022ab:	00 
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801022b0 <ideinit>:
{
801022b0:	55                   	push   %ebp
  initlock(&idelock, "ide");
801022b1:	ba ff 7b 10 80       	mov    $0x80107bff,%edx
{
801022b6:	89 e5                	mov    %esp,%ebp
801022b8:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
801022bb:	89 54 24 04          	mov    %edx,0x4(%esp)
801022bf:	c7 04 24 00 26 11 80 	movl   $0x80112600,(%esp)
801022c6:	e8 d5 25 00 00       	call   801048a0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801022cb:	a1 84 27 11 80       	mov    0x80112784,%eax
801022d0:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801022d7:	48                   	dec    %eax
801022d8:	89 44 24 04          	mov    %eax,0x4(%esp)
801022dc:	e8 8f 02 00 00       	call   80102570 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022e1:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022ed:	00 
801022ee:	66 90                	xchg   %ax,%ax
801022f0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022f1:	24 c0                	and    $0xc0,%al
801022f3:	3c 40                	cmp    $0x40,%al
801022f5:	75 f9                	jne    801022f0 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022f7:	b0 f0                	mov    $0xf0,%al
801022f9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022fe:	ee                   	out    %al,(%dx)
801022ff:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102304:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102309:	eb 08                	jmp    80102313 <ideinit+0x63>
8010230b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102310:	49                   	dec    %ecx
80102311:	74 0f                	je     80102322 <ideinit+0x72>
80102313:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102314:	84 c0                	test   %al,%al
80102316:	74 f8                	je     80102310 <ideinit+0x60>
      havedisk1 = 1;
80102318:	b8 01 00 00 00       	mov    $0x1,%eax
8010231d:	a3 e0 25 11 80       	mov    %eax,0x801125e0
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102322:	b0 e0                	mov    $0xe0,%al
80102324:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102329:	ee                   	out    %al,(%dx)
}
8010232a:	89 ec                	mov    %ebp,%esp
8010232c:	5d                   	pop    %ebp
8010232d:	c3                   	ret
8010232e:	66 90                	xchg   %ax,%ax

80102330 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	57                   	push   %edi
80102334:	56                   	push   %esi
80102335:	53                   	push   %ebx
80102336:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102339:	c7 04 24 00 26 11 80 	movl   $0x80112600,(%esp)
80102340:	e8 5b 27 00 00       	call   80104aa0 <acquire>

  if((b = idequeue) == 0){
80102345:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
8010234b:	85 db                	test   %ebx,%ebx
8010234d:	74 60                	je     801023af <ideintr+0x7f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
8010234f:	8b 43 58             	mov    0x58(%ebx),%eax
80102352:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102357:	8b 33                	mov    (%ebx),%esi
80102359:	f7 c6 04 00 00 00    	test   $0x4,%esi
8010235f:	75 30                	jne    80102391 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102361:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102366:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010236d:	00 
8010236e:	66 90                	xchg   %ax,%ax
80102370:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102371:	88 c1                	mov    %al,%cl
80102373:	80 e1 c0             	and    $0xc0,%cl
80102376:	80 f9 40             	cmp    $0x40,%cl
80102379:	75 f5                	jne    80102370 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010237b:	a8 21                	test   $0x21,%al
8010237d:	75 12                	jne    80102391 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010237f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102382:	b9 80 00 00 00       	mov    $0x80,%ecx
80102387:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010238c:	fc                   	cld
8010238d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010238f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102391:	83 e6 fb             	and    $0xfffffffb,%esi
80102394:	83 ce 02             	or     $0x2,%esi
80102397:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102399:	89 1c 24             	mov    %ebx,(%esp)
8010239c:	e8 6f 20 00 00       	call   80104410 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801023a1:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801023a6:	85 c0                	test   %eax,%eax
801023a8:	74 05                	je     801023af <ideintr+0x7f>
    idestart(idequeue);
801023aa:	e8 31 fe ff ff       	call   801021e0 <idestart>
    release(&idelock);
801023af:	c7 04 24 00 26 11 80 	movl   $0x80112600,(%esp)
801023b6:	e8 75 26 00 00       	call   80104a30 <release>

  release(&idelock);
}
801023bb:	83 c4 1c             	add    $0x1c,%esp
801023be:	5b                   	pop    %ebx
801023bf:	5e                   	pop    %esi
801023c0:	5f                   	pop    %edi
801023c1:	5d                   	pop    %ebp
801023c2:	c3                   	ret
801023c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801023ca:	00 
801023cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801023d0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	83 ec 18             	sub    $0x18,%esp
801023d6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
801023d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801023dc:	8d 43 0c             	lea    0xc(%ebx),%eax
801023df:	89 04 24             	mov    %eax,(%esp)
801023e2:	e8 59 24 00 00       	call   80104840 <holdingsleep>
801023e7:	85 c0                	test   %eax,%eax
801023e9:	0f 84 c0 00 00 00    	je     801024af <iderw+0xdf>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801023ef:	8b 03                	mov    (%ebx),%eax
801023f1:	83 e0 06             	and    $0x6,%eax
801023f4:	83 f8 02             	cmp    $0x2,%eax
801023f7:	0f 84 a6 00 00 00    	je     801024a3 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801023fd:	8b 4b 04             	mov    0x4(%ebx),%ecx
80102400:	85 c9                	test   %ecx,%ecx
80102402:	74 0e                	je     80102412 <iderw+0x42>
80102404:	8b 15 e0 25 11 80    	mov    0x801125e0,%edx
8010240a:	85 d2                	test   %edx,%edx
8010240c:	0f 84 85 00 00 00    	je     80102497 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102412:	c7 04 24 00 26 11 80 	movl   $0x80112600,(%esp)
80102419:	e8 82 26 00 00       	call   80104aa0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010241e:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102423:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010242a:	85 c0                	test   %eax,%eax
8010242c:	74 62                	je     80102490 <iderw+0xc0>
8010242e:	66 90                	xchg   %ax,%ax
80102430:	89 c2                	mov    %eax,%edx
80102432:	8b 40 58             	mov    0x58(%eax),%eax
80102435:	85 c0                	test   %eax,%eax
80102437:	75 f7                	jne    80102430 <iderw+0x60>
80102439:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010243c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010243e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102444:	75 1b                	jne    80102461 <iderw+0x91>
80102446:	eb 38                	jmp    80102480 <iderw+0xb0>
80102448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010244f:	00 
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80102450:	89 1c 24             	mov    %ebx,(%esp)
80102453:	b8 00 26 11 80       	mov    $0x80112600,%eax
80102458:	89 44 24 04          	mov    %eax,0x4(%esp)
8010245c:	e8 df 1e 00 00       	call   80104340 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102461:	8b 03                	mov    (%ebx),%eax
80102463:	83 e0 06             	and    $0x6,%eax
80102466:	83 f8 02             	cmp    $0x2,%eax
80102469:	75 e5                	jne    80102450 <iderw+0x80>
  }


  release(&idelock);
8010246b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102472:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102475:	89 ec                	mov    %ebp,%esp
80102477:	5d                   	pop    %ebp
  release(&idelock);
80102478:	e9 b3 25 00 00       	jmp    80104a30 <release>
8010247d:	8d 76 00             	lea    0x0(%esi),%esi
    idestart(b);
80102480:	89 d8                	mov    %ebx,%eax
80102482:	e8 59 fd ff ff       	call   801021e0 <idestart>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102487:	eb d8                	jmp    80102461 <iderw+0x91>
80102489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102490:	ba e4 25 11 80       	mov    $0x801125e4,%edx
80102495:	eb a5                	jmp    8010243c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102497:	c7 04 24 2e 7c 10 80 	movl   $0x80107c2e,(%esp)
8010249e:	e8 ad de ff ff       	call   80100350 <panic>
    panic("iderw: nothing to do");
801024a3:	c7 04 24 19 7c 10 80 	movl   $0x80107c19,(%esp)
801024aa:	e8 a1 de ff ff       	call   80100350 <panic>
    panic("iderw: buf not locked");
801024af:	c7 04 24 03 7c 10 80 	movl   $0x80107c03,(%esp)
801024b6:	e8 95 de ff ff       	call   80100350 <panic>
801024bb:	66 90                	xchg   %ax,%ax
801024bd:	66 90                	xchg   %ax,%ax
801024bf:	90                   	nop

801024c0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801024c0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801024c1:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
{
801024c6:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801024c8:	ba 01 00 00 00       	mov    $0x1,%edx
{
801024cd:	56                   	push   %esi
801024ce:	53                   	push   %ebx
801024cf:	83 ec 10             	sub    $0x10,%esp
  ioapic = (volatile struct ioapic*)IOAPIC;
801024d2:	a3 34 26 11 80       	mov    %eax,0x80112634
  ioapic->reg = reg;
801024d7:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
801024dd:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801024e3:	8b 42 10             	mov    0x10(%edx),%eax
  ioapic->reg = reg;
801024e6:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801024ec:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  return ioapic->data;
801024f3:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801024f9:	c1 e8 10             	shr    $0x10,%eax
801024fc:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801024ff:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102502:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102505:	39 c2                	cmp    %eax,%edx
80102507:	74 12                	je     8010251b <ioapicinit+0x5b>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102509:	c7 04 24 24 80 10 80 	movl   $0x80108024,(%esp)
80102510:	e8 6b e1 ff ff       	call   80100680 <cprintf>
  ioapic->reg = reg;
80102515:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
{
8010251b:	ba 10 00 00 00       	mov    $0x10,%edx
80102520:	31 c0                	xor    %eax,%eax
80102522:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102529:	00 
8010252a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102530:	89 13                	mov    %edx,(%ebx)
80102532:	8d 48 20             	lea    0x20(%eax),%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102535:	40                   	inc    %eax
  ioapic->data = data;
80102536:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
8010253c:	81 c9 00 00 01 00    	or     $0x10000,%ecx
80102542:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
80102545:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80102548:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010254b:	89 0b                	mov    %ecx,(%ebx)
  for(i = 0; i <= maxintr; i++){
8010254d:	39 c6                	cmp    %eax,%esi
  ioapic->data = data;
8010254f:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102555:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
8010255c:	7d d2                	jge    80102530 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010255e:	83 c4 10             	add    $0x10,%esp
80102561:	5b                   	pop    %ebx
80102562:	5e                   	pop    %esi
80102563:	5d                   	pop    %ebp
80102564:	c3                   	ret
80102565:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010256c:	00 
8010256d:	8d 76 00             	lea    0x0(%esi),%esi

80102570 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102570:	55                   	push   %ebp
  ioapic->reg = reg;
80102571:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102577:	89 e5                	mov    %esp,%ebp
80102579:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010257c:	8d 50 20             	lea    0x20(%eax),%edx
8010257f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102583:	89 01                	mov    %eax,(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102585:	40                   	inc    %eax
  ioapic->data = data;
80102586:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010258c:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010258f:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102592:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102594:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102599:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010259c:	89 50 10             	mov    %edx,0x10(%eax)
}
8010259f:	5d                   	pop    %ebp
801025a0:	c3                   	ret
801025a1:	66 90                	xchg   %ax,%ax
801025a3:	66 90                	xchg   %ax,%ax
801025a5:	66 90                	xchg   %ax,%ax
801025a7:	66 90                	xchg   %ax,%ax
801025a9:	66 90                	xchg   %ax,%ax
801025ab:	66 90                	xchg   %ax,%ax
801025ad:	66 90                	xchg   %ax,%ax
801025af:	90                   	nop

801025b0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	83 ec 18             	sub    $0x18,%esp
801025b6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
801025b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801025bc:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801025c2:	75 7e                	jne    80102642 <kfree+0x92>
801025c4:	81 fb d0 64 11 80    	cmp    $0x801164d0,%ebx
801025ca:	72 76                	jb     80102642 <kfree+0x92>
801025cc:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801025d2:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801025d7:	77 69                	ja     80102642 <kfree+0x92>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801025d9:	89 1c 24             	mov    %ebx,(%esp)
801025dc:	ba 00 10 00 00       	mov    $0x1000,%edx
801025e1:	b9 01 00 00 00       	mov    $0x1,%ecx
801025e6:	89 54 24 08          	mov    %edx,0x8(%esp)
801025ea:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801025ee:	e8 ad 25 00 00       	call   80104ba0 <memset>

  if(kmem.use_lock)
801025f3:	a1 74 26 11 80       	mov    0x80112674,%eax
801025f8:	85 c0                	test   %eax,%eax
801025fa:	75 24                	jne    80102620 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801025fc:	a1 78 26 11 80       	mov    0x80112678,%eax
80102601:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
80102603:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102609:	a1 74 26 11 80       	mov    0x80112674,%eax
8010260e:	85 c0                	test   %eax,%eax
80102610:	75 1e                	jne    80102630 <kfree+0x80>
    release(&kmem.lock);
}
80102612:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102615:	89 ec                	mov    %ebp,%esp
80102617:	5d                   	pop    %ebp
80102618:	c3                   	ret
80102619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102620:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102627:	e8 74 24 00 00       	call   80104aa0 <acquire>
8010262c:	eb ce                	jmp    801025fc <kfree+0x4c>
8010262e:	66 90                	xchg   %ax,%ax
    release(&kmem.lock);
80102630:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102637:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010263a:	89 ec                	mov    %ebp,%esp
8010263c:	5d                   	pop    %ebp
    release(&kmem.lock);
8010263d:	e9 ee 23 00 00       	jmp    80104a30 <release>
    panic("kfree");
80102642:	c7 04 24 4c 7c 10 80 	movl   $0x80107c4c,(%esp)
80102649:	e8 02 dd ff ff       	call   80100350 <panic>
8010264e:	66 90                	xchg   %ax,%ax

80102650 <freerange>:
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
80102653:	56                   	push   %esi
80102654:	53                   	push   %ebx
80102655:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102658:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010265b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010265e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102664:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010266a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102670:	39 de                	cmp    %ebx,%esi
80102672:	72 24                	jb     80102698 <freerange+0x48>
80102674:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010267b:	00 
8010267c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102680:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102686:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010268c:	89 04 24             	mov    %eax,(%esp)
8010268f:	e8 1c ff ff ff       	call   801025b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102694:	39 de                	cmp    %ebx,%esi
80102696:	73 e8                	jae    80102680 <freerange+0x30>
}
80102698:	83 c4 10             	add    $0x10,%esp
8010269b:	5b                   	pop    %ebx
8010269c:	5e                   	pop    %esi
8010269d:	5d                   	pop    %ebp
8010269e:	c3                   	ret
8010269f:	90                   	nop

801026a0 <kinit2>:
{
801026a0:	55                   	push   %ebp
801026a1:	89 e5                	mov    %esp,%ebp
801026a3:	56                   	push   %esi
801026a4:	53                   	push   %ebx
801026a5:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
801026a8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801026ae:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026b4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026ba:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026c0:	39 de                	cmp    %ebx,%esi
801026c2:	72 24                	jb     801026e8 <kinit2+0x48>
801026c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026cb:	00 
801026cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801026d0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026d6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026dc:	89 04 24             	mov    %eax,(%esp)
801026df:	e8 cc fe ff ff       	call   801025b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026e4:	39 de                	cmp    %ebx,%esi
801026e6:	73 e8                	jae    801026d0 <kinit2+0x30>
  kmem.use_lock = 1;
801026e8:	b8 01 00 00 00       	mov    $0x1,%eax
801026ed:	a3 74 26 11 80       	mov    %eax,0x80112674
}
801026f2:	83 c4 10             	add    $0x10,%esp
801026f5:	5b                   	pop    %ebx
801026f6:	5e                   	pop    %esi
801026f7:	5d                   	pop    %ebp
801026f8:	c3                   	ret
801026f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102700 <kinit1>:
{
80102700:	55                   	push   %ebp
  initlock(&kmem.lock, "kmem");
80102701:	b8 52 7c 10 80       	mov    $0x80107c52,%eax
{
80102706:	89 e5                	mov    %esp,%ebp
80102708:	56                   	push   %esi
80102709:	53                   	push   %ebx
8010270a:	83 ec 10             	sub    $0x10,%esp
  initlock(&kmem.lock, "kmem");
8010270d:	89 44 24 04          	mov    %eax,0x4(%esp)
{
80102711:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102714:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
8010271b:	e8 80 21 00 00       	call   801048a0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102720:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102723:	31 d2                	xor    %edx,%edx
80102725:	89 15 74 26 11 80    	mov    %edx,0x80112674
  p = (char*)PGROUNDUP((uint)vstart);
8010272b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102731:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102737:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010273d:	39 de                	cmp    %ebx,%esi
8010273f:	72 27                	jb     80102768 <kinit1+0x68>
80102741:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102748:	00 
80102749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102750:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102756:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010275c:	89 04 24             	mov    %eax,(%esp)
8010275f:	e8 4c fe ff ff       	call   801025b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102764:	39 de                	cmp    %ebx,%esi
80102766:	73 e8                	jae    80102750 <kinit1+0x50>
}
80102768:	83 c4 10             	add    $0x10,%esp
8010276b:	5b                   	pop    %ebx
8010276c:	5e                   	pop    %esi
8010276d:	5d                   	pop    %ebp
8010276e:	c3                   	ret
8010276f:	90                   	nop

80102770 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102770:	a1 74 26 11 80       	mov    0x80112674,%eax
80102775:	85 c0                	test   %eax,%eax
80102777:	75 1f                	jne    80102798 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102779:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010277e:	85 c0                	test   %eax,%eax
80102780:	74 0e                	je     80102790 <kalloc+0x20>
    kmem.freelist = r->next;
80102782:	8b 10                	mov    (%eax),%edx
80102784:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
8010278a:	c3                   	ret
8010278b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    release(&kmem.lock);
  return (char*)r;
}
80102790:	c3                   	ret
80102791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102798:	55                   	push   %ebp
80102799:	89 e5                	mov    %esp,%ebp
8010279b:	83 ec 28             	sub    $0x28,%esp
    acquire(&kmem.lock);
8010279e:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801027a5:	e8 f6 22 00 00       	call   80104aa0 <acquire>
  r = kmem.freelist;
801027aa:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
801027af:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
801027b5:	85 c0                	test   %eax,%eax
801027b7:	74 08                	je     801027c1 <kalloc+0x51>
    kmem.freelist = r->next;
801027b9:	8b 08                	mov    (%eax),%ecx
801027bb:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801027c1:	85 d2                	test   %edx,%edx
801027c3:	74 12                	je     801027d7 <kalloc+0x67>
801027c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    release(&kmem.lock);
801027c8:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801027cf:	e8 5c 22 00 00       	call   80104a30 <release>
801027d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801027d7:	89 ec                	mov    %ebp,%esp
801027d9:	5d                   	pop    %ebp
801027da:	c3                   	ret
801027db:	66 90                	xchg   %ax,%ax
801027dd:	66 90                	xchg   %ax,%ax
801027df:	90                   	nop

801027e0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027e0:	ba 64 00 00 00       	mov    $0x64,%edx
801027e5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801027e6:	24 01                	and    $0x1,%al
801027e8:	0f 84 b2 00 00 00    	je     801028a0 <kbdgetc+0xc0>
{
801027ee:	55                   	push   %ebp
801027ef:	ba 60 00 00 00       	mov    $0x60,%edx
801027f4:	89 e5                	mov    %esp,%ebp
801027f6:	53                   	push   %ebx
801027f7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
801027f8:	3c e0                	cmp    $0xe0,%al
    shift |= E0ESC;
801027fa:	8b 0d 7c 26 11 80    	mov    0x8011267c,%ecx
  data = inb(KBDATAP);
80102800:	0f b6 d8             	movzbl %al,%ebx
  if(data == 0xE0){
80102803:	74 5b                	je     80102860 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102805:	89 ca                	mov    %ecx,%edx
80102807:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010280a:	84 c0                	test   %al,%al
8010280c:	78 62                	js     80102870 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010280e:	85 d2                	test   %edx,%edx
80102810:	74 08                	je     8010281a <kbdgetc+0x3a>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102812:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
80102814:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102817:	0f b6 d8             	movzbl %al,%ebx
  }

  shift |= shiftcode[data];
8010281a:	0f b6 93 c0 82 10 80 	movzbl -0x7fef7d40(%ebx),%edx
  shift ^= togglecode[data];
80102821:	0f b6 83 c0 81 10 80 	movzbl -0x7fef7e40(%ebx),%eax
  shift |= shiftcode[data];
80102828:	09 ca                	or     %ecx,%edx
  shift ^= togglecode[data];
8010282a:	31 c2                	xor    %eax,%edx
8010282c:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80102832:	89 d0                	mov    %edx,%eax
80102834:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102837:	f6 c2 08             	test   $0x8,%dl
  c = charcode[shift & (CTL | SHIFT)][data];
8010283a:	8b 04 85 a0 81 10 80 	mov    -0x7fef7e60(,%eax,4),%eax
80102841:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
  if(shift & CAPSLOCK){
80102845:	74 13                	je     8010285a <kbdgetc+0x7a>
    if('a' <= c && c <= 'z')
80102847:	8d 50 9f             	lea    -0x61(%eax),%edx
8010284a:	83 fa 19             	cmp    $0x19,%edx
8010284d:	76 49                	jbe    80102898 <kbdgetc+0xb8>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
8010284f:	8d 50 bf             	lea    -0x41(%eax),%edx
80102852:	83 fa 19             	cmp    $0x19,%edx
80102855:	77 03                	ja     8010285a <kbdgetc+0x7a>
      c += 'a' - 'A';
80102857:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
8010285a:	5b                   	pop    %ebx
8010285b:	5d                   	pop    %ebp
8010285c:	c3                   	ret
8010285d:	8d 76 00             	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102860:	83 c9 40             	or     $0x40,%ecx
    return 0;
80102863:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102865:	89 0d 7c 26 11 80    	mov    %ecx,0x8011267c
}
8010286b:	5b                   	pop    %ebx
8010286c:	5d                   	pop    %ebp
8010286d:	c3                   	ret
8010286e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102870:	85 d2                	test   %edx,%edx
80102872:	75 05                	jne    80102879 <kbdgetc+0x99>
80102874:	24 7f                	and    $0x7f,%al
80102876:	0f b6 d8             	movzbl %al,%ebx
    shift &= ~(shiftcode[data] | E0ESC);
80102879:	0f b6 83 c0 82 10 80 	movzbl -0x7fef7d40(%ebx),%eax
80102880:	0c 40                	or     $0x40,%al
80102882:	0f b6 c0             	movzbl %al,%eax
80102885:	f7 d0                	not    %eax
80102887:	21 c8                	and    %ecx,%eax
80102889:	a3 7c 26 11 80       	mov    %eax,0x8011267c
    return 0;
8010288e:	31 c0                	xor    %eax,%eax
80102890:	eb d9                	jmp    8010286b <kbdgetc+0x8b>
80102892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80102898:	5b                   	pop    %ebx
      c += 'A' - 'a';
80102899:	83 e8 20             	sub    $0x20,%eax
}
8010289c:	5d                   	pop    %ebp
8010289d:	c3                   	ret
8010289e:	66 90                	xchg   %ax,%ax
    return -1;
801028a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801028a5:	c3                   	ret
801028a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028ad:	00 
801028ae:	66 90                	xchg   %ax,%ax

801028b0 <kbdintr>:

void
kbdintr(void)
{
801028b0:	55                   	push   %ebp
801028b1:	89 e5                	mov    %esp,%ebp
801028b3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801028b6:	c7 04 24 e0 27 10 80 	movl   $0x801027e0,(%esp)
801028bd:	e8 ae df ff ff       	call   80100870 <consoleintr>
}
801028c2:	89 ec                	mov    %ebp,%esp
801028c4:	5d                   	pop    %ebp
801028c5:	c3                   	ret
801028c6:	66 90                	xchg   %ax,%ax
801028c8:	66 90                	xchg   %ax,%ax
801028ca:	66 90                	xchg   %ax,%ax
801028cc:	66 90                	xchg   %ax,%ax
801028ce:	66 90                	xchg   %ax,%ax

801028d0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801028d0:	a1 80 26 11 80       	mov    0x80112680,%eax
801028d5:	85 c0                	test   %eax,%eax
801028d7:	0f 84 c9 00 00 00    	je     801029a6 <lapicinit+0xd6>
  lapic[index] = value;
801028dd:	ba 3f 01 00 00       	mov    $0x13f,%edx
801028e2:	b9 0b 00 00 00       	mov    $0xb,%ecx
801028e7:	89 90 f0 00 00 00    	mov    %edx,0xf0(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ed:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028f0:	89 88 e0 03 00 00    	mov    %ecx,0x3e0(%eax)
801028f6:	b9 80 96 98 00       	mov    $0x989680,%ecx
  lapic[ID];  // wait for write to finish, by reading
801028fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028fe:	ba 20 00 02 00       	mov    $0x20020,%edx
80102903:	89 90 20 03 00 00    	mov    %edx,0x320(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102909:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010290c:	89 88 80 03 00 00    	mov    %ecx,0x380(%eax)
80102912:	b9 00 00 01 00       	mov    $0x10000,%ecx
  lapic[ID];  // wait for write to finish, by reading
80102917:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010291a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010291f:	89 90 50 03 00 00    	mov    %edx,0x350(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102925:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102928:	89 88 60 03 00 00    	mov    %ecx,0x360(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010292e:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102931:	8b 50 30             	mov    0x30(%eax),%edx
80102934:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
8010293a:	75 74                	jne    801029b0 <lapicinit+0xe0>
  lapic[index] = value;
8010293c:	b9 33 00 00 00       	mov    $0x33,%ecx
80102941:	89 88 70 03 00 00    	mov    %ecx,0x370(%eax)
80102947:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
80102949:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010294c:	31 d2                	xor    %edx,%edx
8010294e:	89 90 80 02 00 00    	mov    %edx,0x280(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102954:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102957:	89 88 80 02 00 00    	mov    %ecx,0x280(%eax)
8010295d:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010295f:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102962:	31 d2                	xor    %edx,%edx
80102964:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010296a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010296d:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102973:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102976:	ba 00 85 08 00       	mov    $0x88500,%edx
8010297b:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102981:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102984:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010298b:	00 
8010298c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102990:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102996:	f6 c6 10             	test   $0x10,%dh
80102999:	75 f5                	jne    80102990 <lapicinit+0xc0>
  lapic[index] = value;
8010299b:	31 d2                	xor    %edx,%edx
8010299d:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029a3:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801029a6:	c3                   	ret
801029a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ae:	00 
801029af:	90                   	nop
  lapic[index] = value;
801029b0:	b9 00 00 01 00       	mov    $0x10000,%ecx
801029b5:	89 88 40 03 00 00    	mov    %ecx,0x340(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029bb:	8b 50 20             	mov    0x20(%eax),%edx
}
801029be:	e9 79 ff ff ff       	jmp    8010293c <lapicinit+0x6c>
801029c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ca:	00 
801029cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801029d0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801029d0:	a1 80 26 11 80       	mov    0x80112680,%eax
801029d5:	85 c0                	test   %eax,%eax
801029d7:	74 07                	je     801029e0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801029d9:	8b 40 20             	mov    0x20(%eax),%eax
801029dc:	c1 e8 18             	shr    $0x18,%eax
801029df:	c3                   	ret
801029e0:	31 c0                	xor    %eax,%eax
}
801029e2:	c3                   	ret
801029e3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ea:	00 
801029eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801029f0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801029f0:	a1 80 26 11 80       	mov    0x80112680,%eax
801029f5:	85 c0                	test   %eax,%eax
801029f7:	74 0b                	je     80102a04 <lapiceoi+0x14>
  lapic[index] = value;
801029f9:	31 d2                	xor    %edx,%edx
801029fb:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a01:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102a04:	c3                   	ret
80102a05:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a0c:	00 
80102a0d:	8d 76 00             	lea    0x0(%esi),%esi

80102a10 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102a10:	c3                   	ret
80102a11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a18:	00 
80102a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102a20 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102a20:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a21:	b0 0f                	mov    $0xf,%al
80102a23:	89 e5                	mov    %esp,%ebp
80102a25:	ba 70 00 00 00       	mov    $0x70,%edx
80102a2a:	53                   	push   %ebx
80102a2b:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
80102a2f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102a32:	ee                   	out    %al,(%dx)
80102a33:	b0 0a                	mov    $0xa,%al
80102a35:	ba 71 00 00 00       	mov    $0x71,%edx
80102a3a:	ee                   	out    %al,(%dx)
  lapic[index] = value;
80102a3b:	c1 e1 18             	shl    $0x18,%ecx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102a3e:	31 c0                	xor    %eax,%eax
80102a40:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102a46:	89 d8                	mov    %ebx,%eax
80102a48:	c1 e8 04             	shr    $0x4,%eax
80102a4b:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a51:	c1 eb 0c             	shr    $0xc,%ebx
  lapic[index] = value;
80102a54:	a1 80 26 11 80       	mov    0x80112680,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a59:	81 cb 00 06 00 00    	or     $0x600,%ebx
  lapic[index] = value;
80102a5f:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a65:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a68:	ba 00 c5 00 00       	mov    $0xc500,%edx
80102a6d:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a73:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a76:	ba 00 85 00 00       	mov    $0x8500,%edx
80102a7b:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a81:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a84:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a8a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a8d:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a93:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a96:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a9c:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a9f:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
    microdelay(200);
  }
}
80102aa5:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102aa6:	8b 40 20             	mov    0x20(%eax),%eax
}
80102aa9:	5d                   	pop    %ebp
80102aaa:	c3                   	ret
80102aab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102ab0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102ab0:	55                   	push   %ebp
80102ab1:	b0 0b                	mov    $0xb,%al
80102ab3:	89 e5                	mov    %esp,%ebp
80102ab5:	ba 70 00 00 00       	mov    $0x70,%edx
80102aba:	57                   	push   %edi
80102abb:	56                   	push   %esi
80102abc:	53                   	push   %ebx
80102abd:	83 ec 5c             	sub    $0x5c,%esp
80102ac0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ac1:	ba 71 00 00 00       	mov    $0x71,%edx
80102ac6:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102ac7:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102aca:	24 04                	and    $0x4,%al
80102acc:	88 45 b2             	mov    %al,-0x4e(%ebp)
80102acf:	8d 75 b8             	lea    -0x48(%ebp),%esi
80102ad2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ad9:	00 
80102ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ae0:	31 c0                	xor    %eax,%eax
80102ae2:	ba 70 00 00 00       	mov    $0x70,%edx
80102ae7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae8:	bb 71 00 00 00       	mov    $0x71,%ebx
80102aed:	89 da                	mov    %ebx,%edx
80102aef:	ec                   	in     (%dx),%al
80102af0:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102af3:	ba 70 00 00 00       	mov    $0x70,%edx
80102af8:	b0 02                	mov    $0x2,%al
80102afa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102afb:	89 da                	mov    %ebx,%edx
80102afd:	ec                   	in     (%dx),%al
80102afe:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b01:	ba 70 00 00 00       	mov    $0x70,%edx
80102b06:	b0 04                	mov    $0x4,%al
80102b08:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b09:	89 da                	mov    %ebx,%edx
80102b0b:	ec                   	in     (%dx),%al
80102b0c:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b0f:	ba 70 00 00 00       	mov    $0x70,%edx
80102b14:	b0 07                	mov    $0x7,%al
80102b16:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b17:	89 da                	mov    %ebx,%edx
80102b19:	ec                   	in     (%dx),%al
80102b1a:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b1d:	ba 70 00 00 00       	mov    $0x70,%edx
80102b22:	b0 08                	mov    $0x8,%al
80102b24:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b25:	89 da                	mov    %ebx,%edx
80102b27:	ec                   	in     (%dx),%al
80102b28:	88 45 b3             	mov    %al,-0x4d(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b2b:	ba 70 00 00 00       	mov    $0x70,%edx
80102b30:	b0 09                	mov    $0x9,%al
80102b32:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b33:	89 da                	mov    %ebx,%edx
80102b35:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b36:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b3b:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b3e:	b0 0a                	mov    $0xa,%al
80102b40:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b41:	89 da                	mov    %ebx,%edx
80102b43:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102b44:	84 c0                	test   %al,%al
80102b46:	78 98                	js     80102ae0 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102b48:	89 4d cc             	mov    %ecx,-0x34(%ebp)
80102b4b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b4f:	ba 70 00 00 00       	mov    $0x70,%edx
80102b54:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102b57:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102b5b:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102b5e:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102b62:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102b65:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102b69:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102b6c:	0f b6 45 b3          	movzbl -0x4d(%ebp),%eax
80102b70:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102b73:	31 c0                	xor    %eax,%eax
80102b75:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b76:	89 da                	mov    %ebx,%edx
80102b78:	ec                   	in     (%dx),%al
80102b79:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b7c:	ba 70 00 00 00       	mov    $0x70,%edx
80102b81:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102b84:	b0 02                	mov    $0x2,%al
80102b86:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b87:	89 da                	mov    %ebx,%edx
80102b89:	ec                   	in     (%dx),%al
80102b8a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b8d:	ba 70 00 00 00       	mov    $0x70,%edx
80102b92:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102b95:	b0 04                	mov    $0x4,%al
80102b97:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b98:	89 da                	mov    %ebx,%edx
80102b9a:	ec                   	in     (%dx),%al
80102b9b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b9e:	ba 70 00 00 00       	mov    $0x70,%edx
80102ba3:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ba6:	b0 07                	mov    $0x7,%al
80102ba8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ba9:	89 da                	mov    %ebx,%edx
80102bab:	ec                   	in     (%dx),%al
80102bac:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102baf:	ba 70 00 00 00       	mov    $0x70,%edx
80102bb4:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102bb7:	b0 08                	mov    $0x8,%al
80102bb9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bba:	89 da                	mov    %ebx,%edx
80102bbc:	ec                   	in     (%dx),%al
80102bbd:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bc0:	ba 70 00 00 00       	mov    $0x70,%edx
80102bc5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102bc8:	b0 09                	mov    $0x9,%al
80102bca:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bcb:	89 da                	mov    %ebx,%edx
80102bcd:	ec                   	in     (%dx),%al
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102bce:	89 7c 24 04          	mov    %edi,0x4(%esp)
  return inb(CMOS_RETURN);
80102bd2:	0f b6 c0             	movzbl %al,%eax
80102bd5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102bd8:	b8 18 00 00 00       	mov    $0x18,%eax
80102bdd:	89 44 24 08          	mov    %eax,0x8(%esp)
80102be1:	89 34 24             	mov    %esi,(%esp)
80102be4:	e8 f7 1f 00 00       	call   80104be0 <memcmp>
80102be9:	85 c0                	test   %eax,%eax
80102beb:	0f 85 ef fe ff ff    	jne    80102ae0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102bf1:	80 7d b2 00          	cmpb   $0x0,-0x4e(%ebp)
80102bf5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102bf8:	75 78                	jne    80102c72 <cmostime+0x1c2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102bfa:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102bfd:	89 c2                	mov    %eax,%edx
80102bff:	83 e0 0f             	and    $0xf,%eax
80102c02:	c1 ea 04             	shr    $0x4,%edx
80102c05:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c08:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c0b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102c0e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c11:	89 c2                	mov    %eax,%edx
80102c13:	83 e0 0f             	and    $0xf,%eax
80102c16:	c1 ea 04             	shr    $0x4,%edx
80102c19:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c1c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c1f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102c22:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c25:	89 c2                	mov    %eax,%edx
80102c27:	83 e0 0f             	and    $0xf,%eax
80102c2a:	c1 ea 04             	shr    $0x4,%edx
80102c2d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c30:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c33:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102c36:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c39:	89 c2                	mov    %eax,%edx
80102c3b:	83 e0 0f             	and    $0xf,%eax
80102c3e:	c1 ea 04             	shr    $0x4,%edx
80102c41:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c44:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c47:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102c4a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c4d:	89 c2                	mov    %eax,%edx
80102c4f:	83 e0 0f             	and    $0xf,%eax
80102c52:	c1 ea 04             	shr    $0x4,%edx
80102c55:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c58:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c5b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102c5e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c61:	89 c2                	mov    %eax,%edx
80102c63:	83 e0 0f             	and    $0xf,%eax
80102c66:	c1 ea 04             	shr    $0x4,%edx
80102c69:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c6c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c6f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102c72:	31 c0                	xor    %eax,%eax
80102c74:	8b 54 05 b8          	mov    -0x48(%ebp,%eax,1),%edx
80102c78:	89 14 03             	mov    %edx,(%ebx,%eax,1)
80102c7b:	83 c0 04             	add    $0x4,%eax
80102c7e:	83 f8 18             	cmp    $0x18,%eax
80102c81:	72 f1                	jb     80102c74 <cmostime+0x1c4>
  r->year += 2000;
80102c83:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102c8a:	83 c4 5c             	add    $0x5c,%esp
80102c8d:	5b                   	pop    %ebx
80102c8e:	5e                   	pop    %esi
80102c8f:	5f                   	pop    %edi
80102c90:	5d                   	pop    %ebp
80102c91:	c3                   	ret
80102c92:	66 90                	xchg   %ax,%ax
80102c94:	66 90                	xchg   %ax,%ax
80102c96:	66 90                	xchg   %ax,%ax
80102c98:	66 90                	xchg   %ax,%ax
80102c9a:	66 90                	xchg   %ax,%ax
80102c9c:	66 90                	xchg   %ax,%ax
80102c9e:	66 90                	xchg   %ax,%ax

80102ca0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ca0:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102ca6:	85 d2                	test   %edx,%edx
80102ca8:	0f 8e 92 00 00 00    	jle    80102d40 <install_trans+0xa0>
{
80102cae:	55                   	push   %ebp
80102caf:	89 e5                	mov    %esp,%ebp
80102cb1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102cb2:	31 ff                	xor    %edi,%edi
{
80102cb4:	56                   	push   %esi
80102cb5:	53                   	push   %ebx
80102cb6:	83 ec 1c             	sub    $0x1c,%esp
80102cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102cc0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102cc5:	01 f8                	add    %edi,%eax
80102cc7:	40                   	inc    %eax
80102cc8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ccc:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102cd1:	89 04 24             	mov    %eax,(%esp)
80102cd4:	e8 f7 d3 ff ff       	call   801000d0 <bread>
80102cd9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cdb:	8b 04 bd ec 26 11 80 	mov    -0x7feed914(,%edi,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102ce2:	47                   	inc    %edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102ce3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ce7:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102cec:	89 04 24             	mov    %eax,(%esp)
80102cef:	e8 dc d3 ff ff       	call   801000d0 <bread>
80102cf4:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102cf6:	b8 00 02 00 00       	mov    $0x200,%eax
80102cfb:	89 44 24 08          	mov    %eax,0x8(%esp)
80102cff:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d02:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d06:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102d09:	89 04 24             	mov    %eax,(%esp)
80102d0c:	e8 1f 1f 00 00       	call   80104c30 <memmove>
    bwrite(dbuf);  // write dst to disk
80102d11:	89 1c 24             	mov    %ebx,(%esp)
80102d14:	e8 87 d4 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102d19:	89 34 24             	mov    %esi,(%esp)
80102d1c:	e8 bf d4 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102d21:	89 1c 24             	mov    %ebx,(%esp)
80102d24:	e8 b7 d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d29:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102d2f:	7f 8f                	jg     80102cc0 <install_trans+0x20>
  }
}
80102d31:	83 c4 1c             	add    $0x1c,%esp
80102d34:	5b                   	pop    %ebx
80102d35:	5e                   	pop    %esi
80102d36:	5f                   	pop    %edi
80102d37:	5d                   	pop    %ebp
80102d38:	c3                   	ret
80102d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d40:	c3                   	ret
80102d41:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d48:	00 
80102d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d50 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102d50:	55                   	push   %ebp
80102d51:	89 e5                	mov    %esp,%ebp
80102d53:	83 ec 18             	sub    $0x18,%esp
80102d56:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct buf *buf = bread(log.dev, log.start);
80102d59:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102d5e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d62:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102d67:	89 04 24             	mov    %eax,(%esp)
80102d6a:	e8 61 d3 ff ff       	call   801000d0 <bread>
80102d6f:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102d71:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102d76:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102d79:	85 c0                	test   %eax,%eax
80102d7b:	7e 13                	jle    80102d90 <write_head+0x40>
80102d7d:	31 d2                	xor    %edx,%edx
80102d7f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102d80:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102d87:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d8b:	42                   	inc    %edx
80102d8c:	39 d0                	cmp    %edx,%eax
80102d8e:	75 f0                	jne    80102d80 <write_head+0x30>
  }
  bwrite(buf);
80102d90:	89 1c 24             	mov    %ebx,(%esp)
80102d93:	e8 08 d4 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102d98:	89 1c 24             	mov    %ebx,(%esp)
80102d9b:	e8 40 d4 ff ff       	call   801001e0 <brelse>
}
80102da0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102da3:	89 ec                	mov    %ebp,%esp
80102da5:	5d                   	pop    %ebp
80102da6:	c3                   	ret
80102da7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dae:	00 
80102daf:	90                   	nop

80102db0 <initlog>:
{
80102db0:	55                   	push   %ebp
  initlock(&log.lock, "log");
80102db1:	ba 57 7c 10 80       	mov    $0x80107c57,%edx
{
80102db6:	89 e5                	mov    %esp,%ebp
80102db8:	83 ec 38             	sub    $0x38,%esp
80102dbb:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80102dbe:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102dc1:	89 54 24 04          	mov    %edx,0x4(%esp)
80102dc5:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dcc:	e8 cf 1a 00 00       	call   801048a0 <initlock>
  readsb(dev, &sb);
80102dd1:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102dd4:	89 44 24 04          	mov    %eax,0x4(%esp)
80102dd8:	89 1c 24             	mov    %ebx,(%esp)
80102ddb:	e8 b0 e7 ff ff       	call   80101590 <readsb>
  log.start = sb.logstart;
80102de0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.dev = dev;
80102de3:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102de9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102dec:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102df1:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102df7:	89 1c 24             	mov    %ebx,(%esp)
80102dfa:	89 44 24 04          	mov    %eax,0x4(%esp)
80102dfe:	e8 cd d2 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102e03:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102e06:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102e0c:	85 db                	test   %ebx,%ebx
80102e0e:	7e 20                	jle    80102e30 <initlog+0x80>
80102e10:	31 d2                	xor    %edx,%edx
80102e12:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e19:	00 
80102e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102e20:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102e24:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102e2b:	42                   	inc    %edx
80102e2c:	39 d3                	cmp    %edx,%ebx
80102e2e:	75 f0                	jne    80102e20 <initlog+0x70>
  brelse(buf);
80102e30:	89 04 24             	mov    %eax,(%esp)
80102e33:	e8 a8 d3 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102e38:	e8 63 fe ff ff       	call   80102ca0 <install_trans>
  log.lh.n = 0;
80102e3d:	31 c0                	xor    %eax,%eax
80102e3f:	a3 e8 26 11 80       	mov    %eax,0x801126e8
  write_head(); // clear the log
80102e44:	e8 07 ff ff ff       	call   80102d50 <write_head>
}
80102e49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e4c:	89 ec                	mov    %ebp,%esp
80102e4e:	5d                   	pop    %ebp
80102e4f:	c3                   	ret

80102e50 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102e56:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e5d:	e8 3e 1c 00 00       	call   80104aa0 <acquire>
80102e62:	eb 19                	jmp    80102e7d <begin_op+0x2d>
80102e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102e68:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e6f:	b8 a0 26 11 80       	mov    $0x801126a0,%eax
80102e74:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e78:	e8 c3 14 00 00       	call   80104340 <sleep>
    if(log.committing){
80102e7d:	8b 15 e0 26 11 80    	mov    0x801126e0,%edx
80102e83:	85 d2                	test   %edx,%edx
80102e85:	75 e1                	jne    80102e68 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102e87:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102e8c:	8d 54 80 05          	lea    0x5(%eax,%eax,4),%edx
80102e90:	8d 48 01             	lea    0x1(%eax),%ecx
80102e93:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102e98:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e9b:	83 f8 1e             	cmp    $0x1e,%eax
80102e9e:	7f c8                	jg     80102e68 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102ea0:	89 0d dc 26 11 80    	mov    %ecx,0x801126dc
      release(&log.lock);
80102ea6:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102ead:	e8 7e 1b 00 00       	call   80104a30 <release>
      break;
    }
  }
}
80102eb2:	89 ec                	mov    %ebp,%esp
80102eb4:	5d                   	pop    %ebp
80102eb5:	c3                   	ret
80102eb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ebd:	00 
80102ebe:	66 90                	xchg   %ax,%ax

80102ec0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ec0:	55                   	push   %ebp
80102ec1:	89 e5                	mov    %esp,%ebp
80102ec3:	57                   	push   %edi
80102ec4:	56                   	push   %esi
80102ec5:	53                   	push   %ebx
80102ec6:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ec9:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102ed0:	e8 cb 1b 00 00       	call   80104aa0 <acquire>
  log.outstanding -= 1;
80102ed5:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102eda:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102edd:	a1 e0 26 11 80       	mov    0x801126e0,%eax
  log.outstanding -= 1;
80102ee2:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102ee8:	85 c0                	test   %eax,%eax
80102eea:	0f 85 ed 00 00 00    	jne    80102fdd <end_op+0x11d>
    panic("log.committing");
  if(log.outstanding == 0){
80102ef0:	85 db                	test   %ebx,%ebx
80102ef2:	75 34                	jne    80102f28 <end_op+0x68>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102ef4:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 1;
80102efb:	be 01 00 00 00       	mov    $0x1,%esi
80102f00:	89 35 e0 26 11 80    	mov    %esi,0x801126e0
  release(&log.lock);
80102f06:	e8 25 1b 00 00       	call   80104a30 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102f0b:	8b 3d e8 26 11 80    	mov    0x801126e8,%edi
80102f11:	85 ff                	test   %edi,%edi
80102f13:	7f 3b                	jg     80102f50 <end_op+0x90>
    acquire(&log.lock);
80102f15:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f1c:	e8 7f 1b 00 00       	call   80104aa0 <acquire>
    log.committing = 0;
80102f21:	31 c0                	xor    %eax,%eax
80102f23:	a3 e0 26 11 80       	mov    %eax,0x801126e0
    wakeup(&log);
80102f28:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f2f:	e8 dc 14 00 00       	call   80104410 <wakeup>
    release(&log.lock);
80102f34:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f3b:	e8 f0 1a 00 00       	call   80104a30 <release>
}
80102f40:	83 c4 1c             	add    $0x1c,%esp
80102f43:	5b                   	pop    %ebx
80102f44:	5e                   	pop    %esi
80102f45:	5f                   	pop    %edi
80102f46:	5d                   	pop    %ebp
80102f47:	c3                   	ret
80102f48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f4f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102f50:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102f55:	01 d8                	add    %ebx,%eax
80102f57:	40                   	inc    %eax
80102f58:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f5c:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102f61:	89 04 24             	mov    %eax,(%esp)
80102f64:	e8 67 d1 ff ff       	call   801000d0 <bread>
80102f69:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f6b:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102f72:	43                   	inc    %ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f73:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f77:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102f7c:	89 04 24             	mov    %eax,(%esp)
80102f7f:	e8 4c d1 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102f84:	b9 00 02 00 00       	mov    $0x200,%ecx
80102f89:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f8d:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102f8f:	8d 40 5c             	lea    0x5c(%eax),%eax
80102f92:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f96:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f99:	89 04 24             	mov    %eax,(%esp)
80102f9c:	e8 8f 1c 00 00       	call   80104c30 <memmove>
    bwrite(to);  // write the log
80102fa1:	89 34 24             	mov    %esi,(%esp)
80102fa4:	e8 f7 d1 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102fa9:	89 3c 24             	mov    %edi,(%esp)
80102fac:	e8 2f d2 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102fb1:	89 34 24             	mov    %esi,(%esp)
80102fb4:	e8 27 d2 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102fb9:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102fbf:	7c 8f                	jl     80102f50 <end_op+0x90>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102fc1:	e8 8a fd ff ff       	call   80102d50 <write_head>
    install_trans(); // Now install writes to home locations
80102fc6:	e8 d5 fc ff ff       	call   80102ca0 <install_trans>
    log.lh.n = 0;
80102fcb:	31 d2                	xor    %edx,%edx
80102fcd:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
    write_head();    // Erase the transaction from the log
80102fd3:	e8 78 fd ff ff       	call   80102d50 <write_head>
80102fd8:	e9 38 ff ff ff       	jmp    80102f15 <end_op+0x55>
    panic("log.committing");
80102fdd:	c7 04 24 5b 7c 10 80 	movl   $0x80107c5b,(%esp)
80102fe4:	e8 67 d3 ff ff       	call   80100350 <panic>
80102fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ff0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	83 ec 18             	sub    $0x18,%esp
80102ff6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ff9:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102fff:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103002:	83 fa 1d             	cmp    $0x1d,%edx
80103005:	7f 79                	jg     80103080 <log_write+0x90>
80103007:	a1 d8 26 11 80       	mov    0x801126d8,%eax
8010300c:	48                   	dec    %eax
8010300d:	39 c2                	cmp    %eax,%edx
8010300f:	7d 6f                	jge    80103080 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103011:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80103016:	85 c0                	test   %eax,%eax
80103018:	7e 72                	jle    8010308c <log_write+0x9c>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010301a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80103021:	e8 7a 1a 00 00       	call   80104aa0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103026:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
8010302c:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
8010302e:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103031:	85 d2                	test   %edx,%edx
80103033:	7f 10                	jg     80103045 <log_write+0x55>
80103035:	eb 17                	jmp    8010304e <log_write+0x5e>
80103037:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010303e:	00 
8010303f:	90                   	nop
80103040:	40                   	inc    %eax
80103041:	39 d0                	cmp    %edx,%eax
80103043:	74 2b                	je     80103070 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103045:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
8010304c:	75 f2                	jne    80103040 <log_write+0x50>
  log.lh.block[i] = b->blockno;
8010304e:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
80103055:	39 c2                	cmp    %eax,%edx
80103057:	74 1e                	je     80103077 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103059:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
8010305c:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80103063:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103066:	89 ec                	mov    %ebp,%esp
80103068:	5d                   	pop    %ebp
  release(&log.lock);
80103069:	e9 c2 19 00 00       	jmp    80104a30 <release>
8010306e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103070:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80103077:	42                   	inc    %edx
80103078:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
8010307e:	eb d9                	jmp    80103059 <log_write+0x69>
    panic("too big a transaction");
80103080:	c7 04 24 6a 7c 10 80 	movl   $0x80107c6a,(%esp)
80103087:	e8 c4 d2 ff ff       	call   80100350 <panic>
    panic("log_write outside of trans");
8010308c:	c7 04 24 80 7c 10 80 	movl   $0x80107c80,(%esp)
80103093:	e8 b8 d2 ff ff       	call   80100350 <panic>
80103098:	66 90                	xchg   %ax,%ax
8010309a:	66 90                	xchg   %ax,%ax
8010309c:	66 90                	xchg   %ax,%ax
8010309e:	66 90                	xchg   %ax,%ax

801030a0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	53                   	push   %ebx
801030a4:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801030a7:	e8 04 0b 00 00       	call   80103bb0 <cpuid>
801030ac:	89 c3                	mov    %eax,%ebx
801030ae:	e8 fd 0a 00 00       	call   80103bb0 <cpuid>
801030b3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801030b7:	c7 04 24 9b 7c 10 80 	movl   $0x80107c9b,(%esp)
801030be:	89 44 24 04          	mov    %eax,0x4(%esp)
801030c2:	e8 b9 d5 ff ff       	call   80100680 <cprintf>
  idtinit();       // load idt register
801030c7:	e8 14 2f 00 00       	call   80105fe0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801030cc:	e8 6f 0a 00 00       	call   80103b40 <mycpu>
801030d1:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801030d3:	b8 01 00 00 00       	mov    $0x1,%eax
801030d8:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801030df:	e8 6c 0e 00 00       	call   80103f50 <scheduler>
801030e4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801030eb:	00 
801030ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801030f0 <mpenter>:
{
801030f0:	55                   	push   %ebp
801030f1:	89 e5                	mov    %esp,%ebp
801030f3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801030f6:	e8 65 40 00 00       	call   80107160 <switchkvm>
  seginit();
801030fb:	e8 d0 3f 00 00       	call   801070d0 <seginit>
  lapicinit();
80103100:	e8 cb f7 ff ff       	call   801028d0 <lapicinit>
  mpmain();
80103105:	e8 96 ff ff ff       	call   801030a0 <mpmain>
8010310a:	66 90                	xchg   %ax,%ax
8010310c:	66 90                	xchg   %ax,%ax
8010310e:	66 90                	xchg   %ax,%ax

80103110 <main>:
{
80103110:	55                   	push   %ebp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103111:	b8 00 00 40 80       	mov    $0x80400000,%eax
{
80103116:	89 e5                	mov    %esp,%ebp
80103118:	53                   	push   %ebx
80103119:	83 e4 f0             	and    $0xfffffff0,%esp
8010311c:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010311f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103123:	c7 04 24 d0 64 11 80 	movl   $0x801164d0,(%esp)
8010312a:	e8 d1 f5 ff ff       	call   80102700 <kinit1>
  kvmalloc();      // kernel page table
8010312f:	e8 fc 44 00 00       	call   80107630 <kvmalloc>
  mpinit();        // detect other processors
80103134:	e8 97 01 00 00       	call   801032d0 <mpinit>
  lapicinit();     // interrupt controller
80103139:	e8 92 f7 ff ff       	call   801028d0 <lapicinit>
  seginit();       // segment descriptors
8010313e:	66 90                	xchg   %ax,%ax
80103140:	e8 8b 3f 00 00       	call   801070d0 <seginit>
  picinit();       // disable pic
80103145:	e8 76 03 00 00       	call   801034c0 <picinit>
  ioapicinit();    // another interrupt controller
8010314a:	e8 71 f3 ff ff       	call   801024c0 <ioapicinit>
  consoleinit();   // console hardware
8010314f:	90                   	nop
80103150:	e8 fb d8 ff ff       	call   80100a50 <consoleinit>
  uartinit();      // serial port
80103155:	e8 06 32 00 00       	call   80106360 <uartinit>
  pinit();         // process table
8010315a:	e8 c1 09 00 00       	call   80103b20 <pinit>
  tvinit();        // trap vectors
8010315f:	90                   	nop
80103160:	e8 fb 2d 00 00       	call   80105f60 <tvinit>
  binit();         // buffer cache
80103165:	e8 d6 ce ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010316a:	e8 e1 dc ff ff       	call   80100e50 <fileinit>
  ideinit();       // disk 
8010316f:	90                   	nop
80103170:	e8 3b f1 ff ff       	call   801022b0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103175:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010317a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010317e:	b8 8c b4 10 80       	mov    $0x8010b48c,%eax
80103183:	89 44 24 04          	mov    %eax,0x4(%esp)
80103187:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
8010318e:	e8 9d 1a 00 00       	call   80104c30 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103193:	a1 84 27 11 80       	mov    0x80112784,%eax
80103198:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010319b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010319e:	c1 e0 04             	shl    $0x4,%eax
801031a1:	05 a0 27 11 80       	add    $0x801127a0,%eax
801031a6:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
801031ab:	0f 86 7f 00 00 00    	jbe    80103230 <main+0x120>
801031b1:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
801031b6:	eb 25                	jmp    801031dd <main+0xcd>
801031b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031bf:	00 
801031c0:	a1 84 27 11 80       	mov    0x80112784,%eax
801031c5:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801031cb:	8d 14 80             	lea    (%eax,%eax,4),%edx
801031ce:	8d 04 50             	lea    (%eax,%edx,2),%eax
801031d1:	c1 e0 04             	shl    $0x4,%eax
801031d4:	05 a0 27 11 80       	add    $0x801127a0,%eax
801031d9:	39 c3                	cmp    %eax,%ebx
801031db:	73 53                	jae    80103230 <main+0x120>
    if(c == mycpu())  // We've started already.
801031dd:	e8 5e 09 00 00       	call   80103b40 <mycpu>
801031e2:	39 c3                	cmp    %eax,%ebx
801031e4:	74 da                	je     801031c0 <main+0xb0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801031e6:	e8 85 f5 ff ff       	call   80102770 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
801031eb:	ba f0 30 10 80       	mov    $0x801030f0,%edx
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801031f0:	b9 00 a0 10 00       	mov    $0x10a000,%ecx
    *(void(**)(void))(code-8) = mpenter;
801031f5:	89 15 f8 6f 00 80    	mov    %edx,0x80006ff8
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801031fb:	89 0d f4 6f 00 80    	mov    %ecx,0x80006ff4
    *(void**)(code-4) = stack + KSTACKSIZE;
80103201:	05 00 10 00 00       	add    $0x1000,%eax
80103206:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010320b:	b8 00 70 00 00       	mov    $0x7000,%eax
80103210:	89 44 24 04          	mov    %eax,0x4(%esp)
80103214:	0f b6 03             	movzbl (%ebx),%eax
80103217:	89 04 24             	mov    %eax,(%esp)
8010321a:	e8 01 f8 ff ff       	call   80102a20 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
8010321f:	90                   	nop
80103220:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103226:	85 c0                	test   %eax,%eax
80103228:	74 f6                	je     80103220 <main+0x110>
8010322a:	eb 94                	jmp    801031c0 <main+0xb0>
8010322c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103230:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103237:	b8 00 00 00 8e       	mov    $0x8e000000,%eax
8010323c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103240:	e8 5b f4 ff ff       	call   801026a0 <kinit2>
  userinit();      // first user process
80103245:	e8 66 0a 00 00       	call   80103cb0 <userinit>
  mpmain();        // finish this processor's setup
8010324a:	e8 51 fe ff ff       	call   801030a0 <mpmain>
8010324f:	90                   	nop

80103250 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	57                   	push   %edi
80103254:	56                   	push   %esi
80103255:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
80103256:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010325c:	83 ec 1c             	sub    $0x1c,%esp
  e = addr+len;
8010325f:	8d 9c 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
80103266:	39 de                	cmp    %ebx,%esi
80103268:	72 0c                	jb     80103276 <mpsearch1+0x26>
8010326a:	eb 54                	jmp    801032c0 <mpsearch1+0x70>
8010326c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103270:	39 d9                	cmp    %ebx,%ecx
80103272:	89 ce                	mov    %ecx,%esi
80103274:	73 4a                	jae    801032c0 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103276:	89 34 24             	mov    %esi,(%esp)
80103279:	b8 04 00 00 00       	mov    $0x4,%eax
8010327e:	ba af 7c 10 80       	mov    $0x80107caf,%edx
80103283:	89 44 24 08          	mov    %eax,0x8(%esp)
80103287:	89 54 24 04          	mov    %edx,0x4(%esp)
8010328b:	e8 50 19 00 00       	call   80104be0 <memcmp>
80103290:	8d 4e 10             	lea    0x10(%esi),%ecx
80103293:	85 c0                	test   %eax,%eax
80103295:	75 d9                	jne    80103270 <mpsearch1+0x20>
80103297:	89 f2                	mov    %esi,%edx
80103299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801032a0:	0f b6 3a             	movzbl (%edx),%edi
  for(i=0; i<len; i++)
801032a3:	42                   	inc    %edx
    sum += addr[i];
801032a4:	01 f8                	add    %edi,%eax
  for(i=0; i<len; i++)
801032a6:	39 ca                	cmp    %ecx,%edx
801032a8:	75 f6                	jne    801032a0 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801032aa:	84 c0                	test   %al,%al
801032ac:	75 c2                	jne    80103270 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801032ae:	83 c4 1c             	add    $0x1c,%esp
801032b1:	89 f0                	mov    %esi,%eax
801032b3:	5b                   	pop    %ebx
801032b4:	5e                   	pop    %esi
801032b5:	5f                   	pop    %edi
801032b6:	5d                   	pop    %ebp
801032b7:	c3                   	ret
801032b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032bf:	00 
801032c0:	83 c4 1c             	add    $0x1c,%esp
  return 0;
801032c3:	31 f6                	xor    %esi,%esi
}
801032c5:	5b                   	pop    %ebx
801032c6:	89 f0                	mov    %esi,%eax
801032c8:	5e                   	pop    %esi
801032c9:	5f                   	pop    %edi
801032ca:	5d                   	pop    %ebp
801032cb:	c3                   	ret
801032cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032d0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801032d0:	55                   	push   %ebp
801032d1:	89 e5                	mov    %esp,%ebp
801032d3:	57                   	push   %edi
801032d4:	56                   	push   %esi
801032d5:	53                   	push   %ebx
801032d6:	83 ec 2c             	sub    $0x2c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801032d9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801032e0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801032e7:	c1 e0 08             	shl    $0x8,%eax
801032ea:	09 d0                	or     %edx,%eax
801032ec:	c1 e0 04             	shl    $0x4,%eax
801032ef:	75 1b                	jne    8010330c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801032f1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801032f8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801032ff:	c1 e0 08             	shl    $0x8,%eax
80103302:	09 d0                	or     %edx,%eax
80103304:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103307:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010330c:	ba 00 04 00 00       	mov    $0x400,%edx
80103311:	e8 3a ff ff ff       	call   80103250 <mpsearch1>
80103316:	85 c0                	test   %eax,%eax
80103318:	89 c3                	mov    %eax,%ebx
8010331a:	0f 84 40 01 00 00    	je     80103460 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103320:	8b 73 04             	mov    0x4(%ebx),%esi
80103323:	85 f6                	test   %esi,%esi
80103325:	0f 84 25 01 00 00    	je     80103450 <mpinit+0x180>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010332b:	8d 8e 00 00 00 80    	lea    -0x80000000(%esi),%ecx
  if(memcmp(conf, "PCMP", 4) != 0)
80103331:	ba b4 7c 10 80       	mov    $0x80107cb4,%edx
80103336:	89 54 24 04          	mov    %edx,0x4(%esp)
8010333a:	b8 04 00 00 00       	mov    $0x4,%eax
8010333f:	89 44 24 08          	mov    %eax,0x8(%esp)
80103343:	89 0c 24             	mov    %ecx,(%esp)
80103346:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103349:	e8 92 18 00 00       	call   80104be0 <memcmp>
8010334e:	85 c0                	test   %eax,%eax
80103350:	89 c2                	mov    %eax,%edx
80103352:	0f 85 f8 00 00 00    	jne    80103450 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
80103358:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
8010335f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103362:	3c 01                	cmp    $0x1,%al
80103364:	74 08                	je     8010336e <mpinit+0x9e>
80103366:	3c 04                	cmp    $0x4,%al
80103368:	0f 85 e2 00 00 00    	jne    80103450 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
8010336e:	0f b7 be 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edi
  for(i=0; i<len; i++)
80103375:	85 ff                	test   %edi,%edi
80103377:	74 20                	je     80103399 <mpinit+0xc9>
80103379:	89 75 e4             	mov    %esi,-0x1c(%ebp)
8010337c:	89 f0                	mov    %esi,%eax
8010337e:	01 f7                	add    %esi,%edi
    sum += addr[i];
80103380:	0f b6 b0 00 00 00 80 	movzbl -0x80000000(%eax),%esi
  for(i=0; i<len; i++)
80103387:	40                   	inc    %eax
    sum += addr[i];
80103388:	01 f2                	add    %esi,%edx
  for(i=0; i<len; i++)
8010338a:	39 c7                	cmp    %eax,%edi
8010338c:	75 f2                	jne    80103380 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
8010338e:	84 d2                	test   %dl,%dl
80103390:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103393:	0f 85 b7 00 00 00    	jne    80103450 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103399:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
8010339f:	89 df                	mov    %ebx,%edi
801033a1:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033a6:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801033ac:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801033b3:	01 d1                	add    %edx,%ecx
801033b5:	39 c8                	cmp    %ecx,%eax
801033b7:	72 12                	jb     801033cb <mpinit+0xfb>
801033b9:	eb 40                	jmp    801033fb <mpinit+0x12b>
801033bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    switch(*p){
801033c0:	84 d2                	test   %dl,%dl
801033c2:	74 5c                	je     80103420 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801033c4:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033c7:	39 c8                	cmp    %ecx,%eax
801033c9:	73 2e                	jae    801033f9 <mpinit+0x129>
    switch(*p){
801033cb:	0f b6 10             	movzbl (%eax),%edx
801033ce:	80 fa 02             	cmp    $0x2,%dl
801033d1:	74 15                	je     801033e8 <mpinit+0x118>
801033d3:	76 eb                	jbe    801033c0 <mpinit+0xf0>
801033d5:	80 ea 03             	sub    $0x3,%dl
801033d8:	80 fa 01             	cmp    $0x1,%dl
801033db:	76 e7                	jbe    801033c4 <mpinit+0xf4>
801033dd:	8d 76 00             	lea    0x0(%esi),%esi
801033e0:	eb fb                	jmp    801033dd <mpinit+0x10d>
801033e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
801033e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801033ec:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033ef:	39 c8                	cmp    %ecx,%eax
      ioapicid = ioapic->apicno;
801033f1:	88 15 80 27 11 80    	mov    %dl,0x80112780
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033f7:	72 d2                	jb     801033cb <mpinit+0xfb>
801033f9:	89 fb                	mov    %edi,%ebx
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801033fb:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801033ff:	74 11                	je     80103412 <mpinit+0x142>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103401:	b0 70                	mov    $0x70,%al
80103403:	ba 22 00 00 00       	mov    $0x22,%edx
80103408:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103409:	ba 23 00 00 00       	mov    $0x23,%edx
8010340e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010340f:	0c 01                	or     $0x1,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103411:	ee                   	out    %al,(%dx)
  }
}
80103412:	83 c4 2c             	add    $0x2c,%esp
80103415:	5b                   	pop    %ebx
80103416:	5e                   	pop    %esi
80103417:	5f                   	pop    %edi
80103418:	5d                   	pop    %ebp
80103419:	c3                   	ret
8010341a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103420:	8b 15 84 27 11 80    	mov    0x80112784,%edx
80103426:	83 fa 07             	cmp    $0x7,%edx
80103429:	7f 1a                	jg     80103445 <mpinit+0x175>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010342b:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
8010342f:	8d 34 92             	lea    (%edx,%edx,4),%esi
80103432:	8d 34 72             	lea    (%edx,%esi,2),%esi
        ncpu++;
80103435:	42                   	inc    %edx
80103436:	89 15 84 27 11 80    	mov    %edx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010343c:	c1 e6 04             	shl    $0x4,%esi
8010343f:	88 9e a0 27 11 80    	mov    %bl,-0x7feed860(%esi)
      p += sizeof(struct mpproc);
80103445:	83 c0 14             	add    $0x14,%eax
      continue;
80103448:	e9 7a ff ff ff       	jmp    801033c7 <mpinit+0xf7>
8010344d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103450:	c7 04 24 b9 7c 10 80 	movl   $0x80107cb9,(%esp)
80103457:	e8 f4 ce ff ff       	call   80100350 <panic>
8010345c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
80103460:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103465:	eb 13                	jmp    8010347a <mpinit+0x1aa>
80103467:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010346e:	00 
8010346f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103470:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103476:	89 f3                	mov    %esi,%ebx
80103478:	74 d6                	je     80103450 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010347a:	89 1c 24             	mov    %ebx,(%esp)
8010347d:	b9 04 00 00 00       	mov    $0x4,%ecx
80103482:	be af 7c 10 80       	mov    $0x80107caf,%esi
80103487:	89 74 24 04          	mov    %esi,0x4(%esp)
8010348b:	8d 73 10             	lea    0x10(%ebx),%esi
8010348e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103492:	e8 49 17 00 00       	call   80104be0 <memcmp>
80103497:	85 c0                	test   %eax,%eax
80103499:	75 d5                	jne    80103470 <mpinit+0x1a0>
8010349b:	89 da                	mov    %ebx,%edx
8010349d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801034a0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801034a3:	42                   	inc    %edx
    sum += addr[i];
801034a4:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801034a6:	39 d6                	cmp    %edx,%esi
801034a8:	75 f6                	jne    801034a0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801034aa:	84 c0                	test   %al,%al
801034ac:	75 c2                	jne    80103470 <mpinit+0x1a0>
801034ae:	e9 6d fe ff ff       	jmp    80103320 <mpinit+0x50>
801034b3:	66 90                	xchg   %ax,%ax
801034b5:	66 90                	xchg   %ax,%ax
801034b7:	66 90                	xchg   %ax,%ax
801034b9:	66 90                	xchg   %ax,%ax
801034bb:	66 90                	xchg   %ax,%ax
801034bd:	66 90                	xchg   %ax,%ax
801034bf:	90                   	nop

801034c0 <picinit>:
801034c0:	b0 ff                	mov    $0xff,%al
801034c2:	ba 21 00 00 00       	mov    $0x21,%edx
801034c7:	ee                   	out    %al,(%dx)
801034c8:	ba a1 00 00 00       	mov    $0xa1,%edx
801034cd:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801034ce:	c3                   	ret
801034cf:	90                   	nop

801034d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	57                   	push   %edi
801034d4:	56                   	push   %esi
801034d5:	53                   	push   %ebx
801034d6:	83 ec 1c             	sub    $0x1c,%esp
801034d9:	8b 75 08             	mov    0x8(%ebp),%esi
801034dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801034df:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
801034e5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801034eb:	e8 80 d9 ff ff       	call   80100e70 <filealloc>
801034f0:	89 06                	mov    %eax,(%esi)
801034f2:	85 c0                	test   %eax,%eax
801034f4:	0f 84 9f 00 00 00    	je     80103599 <pipealloc+0xc9>
801034fa:	e8 71 d9 ff ff       	call   80100e70 <filealloc>
801034ff:	89 07                	mov    %eax,(%edi)
80103501:	85 c0                	test   %eax,%eax
80103503:	0f 84 82 00 00 00    	je     8010358b <pipealloc+0xbb>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103509:	e8 62 f2 ff ff       	call   80102770 <kalloc>
8010350e:	85 c0                	test   %eax,%eax
80103510:	89 c3                	mov    %eax,%ebx
80103512:	0f 84 96 00 00 00    	je     801035ae <pipealloc+0xde>
    goto bad;
  p->readopen = 1;
80103518:	b8 01 00 00 00       	mov    $0x1,%eax
  p->writeopen = 1;
8010351d:	ba 01 00 00 00       	mov    $0x1,%edx
  p->readopen = 1;
80103522:	89 83 3c 02 00 00    	mov    %eax,0x23c(%ebx)
  p->nwrite = 0;
  p->nread = 0;
80103528:	31 c0                	xor    %eax,%eax
  p->nwrite = 0;
8010352a:	31 c9                	xor    %ecx,%ecx
  p->nread = 0;
8010352c:	89 83 34 02 00 00    	mov    %eax,0x234(%ebx)
  initlock(&p->lock, "pipe");
80103532:	b8 d1 7c 10 80       	mov    $0x80107cd1,%eax
  p->writeopen = 1;
80103537:	89 93 40 02 00 00    	mov    %edx,0x240(%ebx)
  p->nwrite = 0;
8010353d:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
  initlock(&p->lock, "pipe");
80103543:	89 44 24 04          	mov    %eax,0x4(%esp)
80103547:	89 1c 24             	mov    %ebx,(%esp)
8010354a:	e8 51 13 00 00       	call   801048a0 <initlock>
  (*f0)->type = FD_PIPE;
8010354f:	8b 06                	mov    (%esi),%eax
80103551:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103557:	8b 06                	mov    (%esi),%eax
80103559:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010355d:	8b 06                	mov    (%esi),%eax
8010355f:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103563:	8b 06                	mov    (%esi),%eax
80103565:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103568:	8b 07                	mov    (%edi),%eax
8010356a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103570:	8b 07                	mov    (%edi),%eax
80103572:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103576:	8b 07                	mov    (%edi),%eax
80103578:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010357c:	8b 07                	mov    (%edi),%eax
8010357e:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103581:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103583:	83 c4 1c             	add    $0x1c,%esp
80103586:	5b                   	pop    %ebx
80103587:	5e                   	pop    %esi
80103588:	5f                   	pop    %edi
80103589:	5d                   	pop    %ebp
8010358a:	c3                   	ret
  if(*f0)
8010358b:	8b 06                	mov    (%esi),%eax
8010358d:	85 c0                	test   %eax,%eax
8010358f:	74 16                	je     801035a7 <pipealloc+0xd7>
    fileclose(*f0);
80103591:	89 04 24             	mov    %eax,(%esp)
80103594:	e8 97 d9 ff ff       	call   80100f30 <fileclose>
  if(*f1)
80103599:	8b 07                	mov    (%edi),%eax
8010359b:	85 c0                	test   %eax,%eax
8010359d:	74 08                	je     801035a7 <pipealloc+0xd7>
    fileclose(*f1);
8010359f:	89 04 24             	mov    %eax,(%esp)
801035a2:	e8 89 d9 ff ff       	call   80100f30 <fileclose>
  return -1;
801035a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035ac:	eb d5                	jmp    80103583 <pipealloc+0xb3>
  if(*f0)
801035ae:	8b 06                	mov    (%esi),%eax
801035b0:	85 c0                	test   %eax,%eax
801035b2:	75 dd                	jne    80103591 <pipealloc+0xc1>
801035b4:	eb e3                	jmp    80103599 <pipealloc+0xc9>
801035b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801035bd:	00 
801035be:	66 90                	xchg   %ax,%ax

801035c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801035c0:	55                   	push   %ebp
801035c1:	89 e5                	mov    %esp,%ebp
801035c3:	83 ec 18             	sub    $0x18,%esp
801035c6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801035c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
801035cf:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801035d2:	89 1c 24             	mov    %ebx,(%esp)
801035d5:	e8 c6 14 00 00       	call   80104aa0 <acquire>
  if(writable){
801035da:	85 f6                	test   %esi,%esi
801035dc:	74 42                	je     80103620 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801035de:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801035e4:	31 f6                	xor    %esi,%esi
801035e6:	89 b3 40 02 00 00    	mov    %esi,0x240(%ebx)
    wakeup(&p->nread);
801035ec:	89 04 24             	mov    %eax,(%esp)
801035ef:	e8 1c 0e 00 00       	call   80104410 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801035f4:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801035fa:	85 d2                	test   %edx,%edx
801035fc:	75 0a                	jne    80103608 <pipeclose+0x48>
801035fe:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103604:	85 c0                	test   %eax,%eax
80103606:	74 38                	je     80103640 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103608:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010360b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010360e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103611:	89 ec                	mov    %ebp,%esp
80103613:	5d                   	pop    %ebp
    release(&p->lock);
80103614:	e9 17 14 00 00       	jmp    80104a30 <release>
80103619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103620:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103626:	31 c9                	xor    %ecx,%ecx
80103628:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
8010362e:	89 04 24             	mov    %eax,(%esp)
80103631:	e8 da 0d 00 00       	call   80104410 <wakeup>
80103636:	eb bc                	jmp    801035f4 <pipeclose+0x34>
80103638:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010363f:	00 
    release(&p->lock);
80103640:	89 1c 24             	mov    %ebx,(%esp)
80103643:	e8 e8 13 00 00       	call   80104a30 <release>
}
80103648:	8b 75 fc             	mov    -0x4(%ebp),%esi
    kfree((char*)p);
8010364b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010364e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103651:	89 ec                	mov    %ebp,%esp
80103653:	5d                   	pop    %ebp
    kfree((char*)p);
80103654:	e9 57 ef ff ff       	jmp    801025b0 <kfree>
80103659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103660 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103660:	55                   	push   %ebp
80103661:	89 e5                	mov    %esp,%ebp
80103663:	57                   	push   %edi
80103664:	56                   	push   %esi
80103665:	53                   	push   %ebx
80103666:	83 ec 2c             	sub    $0x2c,%esp
80103669:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010366c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010366f:	89 1c 24             	mov    %ebx,(%esp)
80103672:	e8 29 14 00 00       	call   80104aa0 <acquire>
  for(i = 0; i < n; i++){
80103677:	85 ff                	test   %edi,%edi
80103679:	0f 8e c5 00 00 00    	jle    80103744 <pipewrite+0xe4>
8010367f:	89 7d 10             	mov    %edi,0x10(%ebp)
80103682:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103685:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
8010368b:	8d 34 39             	lea    (%ecx,%edi,1),%esi
8010368e:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103691:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
80103697:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010369a:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801036a0:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036a6:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801036ac:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801036af:	0f 85 a9 00 00 00    	jne    8010375e <pipewrite+0xfe>
801036b5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801036b8:	eb 3b                	jmp    801036f5 <pipewrite+0x95>
801036ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
801036c0:	e8 bb 05 00 00       	call   80103c80 <myproc>
801036c5:	8b 40 24             	mov    0x24(%eax),%eax
801036c8:	85 c0                	test   %eax,%eax
801036ca:	75 33                	jne    801036ff <pipewrite+0x9f>
      wakeup(&p->nread);
801036cc:	89 34 24             	mov    %esi,(%esp)
801036cf:	e8 3c 0d 00 00       	call   80104410 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801036d4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801036d8:	89 3c 24             	mov    %edi,(%esp)
801036db:	e8 60 0c 00 00       	call   80104340 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036e0:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036e6:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801036ec:	05 00 02 00 00       	add    $0x200,%eax
801036f1:	39 c2                	cmp    %eax,%edx
801036f3:	75 23                	jne    80103718 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
801036f5:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801036fb:	85 d2                	test   %edx,%edx
801036fd:	75 c1                	jne    801036c0 <pipewrite+0x60>
        release(&p->lock);
801036ff:	89 1c 24             	mov    %ebx,(%esp)
80103702:	e8 29 13 00 00       	call   80104a30 <release>
        return -1;
80103707:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010370c:	83 c4 2c             	add    $0x2c,%esp
8010370f:	5b                   	pop    %ebx
80103710:	5e                   	pop    %esi
80103711:	5f                   	pop    %edi
80103712:	5d                   	pop    %ebp
80103713:	c3                   	ret
80103714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103718:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010371b:	8d 42 01             	lea    0x1(%edx),%eax
8010371e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103724:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
  for(i = 0; i < n; i++){
8010372a:	41                   	inc    %ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010372b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010372e:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
80103732:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103736:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103739:	39 c1                	cmp    %eax,%ecx
8010373b:	0f 85 59 ff ff ff    	jne    8010369a <pipewrite+0x3a>
80103741:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103744:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010374a:	89 04 24             	mov    %eax,(%esp)
8010374d:	e8 be 0c 00 00       	call   80104410 <wakeup>
  release(&p->lock);
80103752:	89 1c 24             	mov    %ebx,(%esp)
80103755:	e8 d6 12 00 00       	call   80104a30 <release>
  return n;
8010375a:	89 f8                	mov    %edi,%eax
8010375c:	eb ae                	jmp    8010370c <pipewrite+0xac>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010375e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103761:	eb b8                	jmp    8010371b <pipewrite+0xbb>
80103763:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010376a:	00 
8010376b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103770 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	57                   	push   %edi
80103774:	56                   	push   %esi
80103775:	53                   	push   %ebx
80103776:	83 ec 1c             	sub    $0x1c,%esp
80103779:	8b 75 08             	mov    0x8(%ebp),%esi
8010377c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010377f:	89 34 24             	mov    %esi,(%esp)
80103782:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103788:	e8 13 13 00 00       	call   80104aa0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010378d:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103793:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103799:	74 2f                	je     801037ca <piperead+0x5a>
8010379b:	eb 37                	jmp    801037d4 <piperead+0x64>
8010379d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed){
801037a0:	e8 db 04 00 00       	call   80103c80 <myproc>
801037a5:	8b 40 24             	mov    0x24(%eax),%eax
801037a8:	85 c0                	test   %eax,%eax
801037aa:	0f 85 80 00 00 00    	jne    80103830 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801037b0:	89 74 24 04          	mov    %esi,0x4(%esp)
801037b4:	89 1c 24             	mov    %ebx,(%esp)
801037b7:	e8 84 0b 00 00       	call   80104340 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037bc:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801037c2:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801037c8:	75 0a                	jne    801037d4 <piperead+0x64>
801037ca:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801037d0:	85 d2                	test   %edx,%edx
801037d2:	75 cc                	jne    801037a0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037d4:	8b 4d 10             	mov    0x10(%ebp),%ecx
801037d7:	31 db                	xor    %ebx,%ebx
801037d9:	85 c9                	test   %ecx,%ecx
801037db:	7f 25                	jg     80103802 <piperead+0x92>
801037dd:	eb 2b                	jmp    8010380a <piperead+0x9a>
801037df:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801037e0:	8d 48 01             	lea    0x1(%eax),%ecx
801037e3:	25 ff 01 00 00       	and    $0x1ff,%eax
801037e8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801037ee:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801037f3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037f6:	43                   	inc    %ebx
801037f7:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801037fa:	74 0e                	je     8010380a <piperead+0x9a>
801037fc:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103802:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103808:	75 d6                	jne    801037e0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010380a:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103810:	89 04 24             	mov    %eax,(%esp)
80103813:	e8 f8 0b 00 00       	call   80104410 <wakeup>
  release(&p->lock);
80103818:	89 34 24             	mov    %esi,(%esp)
8010381b:	e8 10 12 00 00       	call   80104a30 <release>
  return i;
}
80103820:	83 c4 1c             	add    $0x1c,%esp
80103823:	89 d8                	mov    %ebx,%eax
80103825:	5b                   	pop    %ebx
80103826:	5e                   	pop    %esi
80103827:	5f                   	pop    %edi
80103828:	5d                   	pop    %ebp
80103829:	c3                   	ret
8010382a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&p->lock);
80103830:	89 34 24             	mov    %esi,(%esp)
      return -1;
80103833:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103838:	e8 f3 11 00 00       	call   80104a30 <release>
}
8010383d:	83 c4 1c             	add    $0x1c,%esp
80103840:	89 d8                	mov    %ebx,%eax
80103842:	5b                   	pop    %ebx
80103843:	5e                   	pop    %esi
80103844:	5f                   	pop    %edi
80103845:	5d                   	pop    %ebp
80103846:	c3                   	ret
80103847:	66 90                	xchg   %ax,%ax
80103849:	66 90                	xchg   %ax,%ax
8010384b:	66 90                	xchg   %ax,%ax
8010384d:	66 90                	xchg   %ax,%ax
8010384f:	90                   	nop

80103850 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	83 ec 18             	sub    $0x18,%esp
80103856:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103859:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  acquire(&ptable.lock);
8010385e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103865:	e8 36 12 00 00       	call   80104aa0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010386a:	eb 0f                	jmp    8010387b <allocproc+0x2b>
8010386c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103870:	83 c3 7c             	add    $0x7c,%ebx
80103873:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103879:	74 7d                	je     801038f8 <allocproc+0xa8>
    if(p->state == UNUSED)
8010387b:	8b 4b 0c             	mov    0xc(%ebx),%ecx
8010387e:	85 c9                	test   %ecx,%ecx
80103880:	75 ee                	jne    80103870 <allocproc+0x20>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103882:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103889:	a1 04 b0 10 80       	mov    0x8010b004,%eax
8010388e:	89 43 10             	mov    %eax,0x10(%ebx)
80103891:	8d 50 01             	lea    0x1(%eax),%edx
80103894:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
8010389a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801038a1:	e8 8a 11 00 00       	call   80104a30 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801038a6:	e8 c5 ee ff ff       	call   80102770 <kalloc>
801038ab:	89 43 08             	mov    %eax,0x8(%ebx)
801038ae:	85 c0                	test   %eax,%eax
801038b0:	74 5d                	je     8010390f <allocproc+0xbf>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801038b2:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801038b8:	b9 14 00 00 00       	mov    $0x14,%ecx
  sp -= sizeof *p->tf;
801038bd:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801038c0:	ba 48 5f 10 80       	mov    $0x80105f48,%edx
  sp -= sizeof *p->context;
801038c5:	05 9c 0f 00 00       	add    $0xf9c,%eax
  *(uint*)sp = (uint)trapret;
801038ca:	89 50 14             	mov    %edx,0x14(%eax)
  memset(p->context, 0, sizeof *p->context);
801038cd:	31 d2                	xor    %edx,%edx
  p->context = (struct context*)sp;
801038cf:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801038d2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801038d6:	89 54 24 04          	mov    %edx,0x4(%esp)
801038da:	89 04 24             	mov    %eax,(%esp)
801038dd:	e8 be 12 00 00       	call   80104ba0 <memset>
  p->context->eip = (uint)forkret;
801038e2:	8b 43 1c             	mov    0x1c(%ebx),%eax
801038e5:	c7 40 10 20 39 10 80 	movl   $0x80103920,0x10(%eax)

  return p;
}
801038ec:	89 d8                	mov    %ebx,%eax
801038ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038f1:	89 ec                	mov    %ebp,%esp
801038f3:	5d                   	pop    %ebp
801038f4:	c3                   	ret
801038f5:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
801038f8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  return 0;
801038ff:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103901:	e8 2a 11 00 00       	call   80104a30 <release>
}
80103906:	89 d8                	mov    %ebx,%eax
80103908:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010390b:	89 ec                	mov    %ebp,%esp
8010390d:	5d                   	pop    %ebp
8010390e:	c3                   	ret
    p->state = UNUSED;
8010390f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103916:	31 db                	xor    %ebx,%ebx
80103918:	eb ec                	jmp    80103906 <allocproc+0xb6>
8010391a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103920 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103926:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010392d:	e8 fe 10 00 00       	call   80104a30 <release>

  if (first) {
80103932:	8b 15 00 b0 10 80    	mov    0x8010b000,%edx
80103938:	85 d2                	test   %edx,%edx
8010393a:	75 04                	jne    80103940 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010393c:	89 ec                	mov    %ebp,%esp
8010393e:	5d                   	pop    %ebp
8010393f:	c3                   	ret
    first = 0;
80103940:	31 c0                	xor    %eax,%eax
80103942:	a3 00 b0 10 80       	mov    %eax,0x8010b000
    iinit(ROOTDEV);
80103947:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010394e:	e8 8d dc ff ff       	call   801015e0 <iinit>
    initlog(ROOTDEV);
80103953:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010395a:	e8 51 f4 ff ff       	call   80102db0 <initlog>
}
8010395f:	89 ec                	mov    %ebp,%esp
80103961:	5d                   	pop    %ebp
80103962:	c3                   	ret
80103963:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010396a:	00 
8010396b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103970 <getpasize>:
getpasize(int pid) {
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	56                   	push   %esi
80103974:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103975:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
getpasize(int pid) {
8010397a:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010397d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
getpasize(int pid) {
80103984:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
80103987:	e8 14 11 00 00       	call   80104aa0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010398c:	eb 0d                	jmp    8010399b <getpasize+0x2b>
8010398e:	66 90                	xchg   %ax,%ax
80103990:	83 c3 7c             	add    $0x7c,%ebx
80103993:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103999:	74 25                	je     801039c0 <getpasize+0x50>
    if (p->pid == pid) {
8010399b:	39 73 10             	cmp    %esi,0x10(%ebx)
8010399e:	75 f0                	jne    80103990 <getpasize+0x20>
      release(&ptable.lock);
801039a0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039a7:	e8 84 10 00 00       	call   80104a30 <release>
      return getpapages(p->pgdir);
801039ac:	8b 43 04             	mov    0x4(%ebx),%eax
801039af:	89 45 08             	mov    %eax,0x8(%ebp)
}
801039b2:	83 c4 10             	add    $0x10,%esp
801039b5:	5b                   	pop    %ebx
801039b6:	5e                   	pop    %esi
801039b7:	5d                   	pop    %ebp
      return getpapages(p->pgdir);
801039b8:	e9 23 40 00 00       	jmp    801079e0 <getpapages>
801039bd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
801039c0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039c7:	e8 64 10 00 00       	call   80104a30 <release>
}
801039cc:	83 c4 10             	add    $0x10,%esp
801039cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039d4:	5b                   	pop    %ebx
801039d5:	5e                   	pop    %esi
801039d6:	5d                   	pop    %ebp
801039d7:	c3                   	ret
801039d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039df:	00 

801039e0 <getvasize>:
getvasize(int pid) {
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	56                   	push   %esi
801039e4:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801039e5:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
getvasize(int pid) {
801039ea:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801039ed:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
getvasize(int pid) {
801039f4:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
801039f7:	e8 a4 10 00 00       	call   80104aa0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801039fc:	eb 0d                	jmp    80103a0b <getvasize+0x2b>
801039fe:	66 90                	xchg   %ax,%ax
80103a00:	83 c3 7c             	add    $0x7c,%ebx
80103a03:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103a09:	74 1d                	je     80103a28 <getvasize+0x48>
    if (p->pid == pid) {
80103a0b:	39 73 10             	cmp    %esi,0x10(%ebx)
80103a0e:	75 f0                	jne    80103a00 <getvasize+0x20>
      release(&ptable.lock);
80103a10:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a17:	e8 14 10 00 00       	call   80104a30 <release>
      return p->sz;
80103a1c:	8b 03                	mov    (%ebx),%eax
}
80103a1e:	83 c4 10             	add    $0x10,%esp
80103a21:	5b                   	pop    %ebx
80103a22:	5e                   	pop    %esi
80103a23:	5d                   	pop    %ebp
80103a24:	c3                   	ret
80103a25:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103a28:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a2f:	e8 fc 0f 00 00       	call   80104a30 <release>
}
80103a34:	83 c4 10             	add    $0x10,%esp
  return -1;
80103a37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103a3c:	5b                   	pop    %ebx
80103a3d:	5e                   	pop    %esi
80103a3e:	5d                   	pop    %ebp
80103a3f:	c3                   	ret

80103a40 <whatsthestatus>:
whatsthestatus(int pid) {
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	56                   	push   %esi
80103a44:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a45:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
whatsthestatus(int pid) {
80103a4a:	83 ec 20             	sub    $0x20,%esp
  acquire(&ptable.lock);
80103a4d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
whatsthestatus(int pid) {
80103a54:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
80103a57:	e8 44 10 00 00       	call   80104aa0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103a5c:	eb 0d                	jmp    80103a6b <whatsthestatus+0x2b>
80103a5e:	66 90                	xchg   %ax,%ax
80103a60:	83 c3 7c             	add    $0x7c,%ebx
80103a63:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103a69:	74 65                	je     80103ad0 <whatsthestatus+0x90>
    if(p->pid == pid){
80103a6b:	8b 43 10             	mov    0x10(%ebx),%eax
80103a6e:	39 f0                	cmp    %esi,%eax
80103a70:	75 ee                	jne    80103a60 <whatsthestatus+0x20>
      switch(p->state) {
80103a72:	8b 4b 0c             	mov    0xc(%ebx),%ecx
80103a75:	ba 6c 7f 10 80       	mov    $0x80107f6c,%edx
80103a7a:	83 f9 05             	cmp    $0x5,%ecx
80103a7d:	76 41                	jbe    80103ac0 <whatsthestatus+0x80>
      cprintf("%d %s %d %s\n", p->pid, state, p->parent->pid, p->name);
80103a7f:	8d 4b 6c             	lea    0x6c(%ebx),%ecx
80103a82:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80103a86:	8b 4b 14             	mov    0x14(%ebx),%ecx
80103a89:	8b 49 10             	mov    0x10(%ecx),%ecx
80103a8c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a90:	89 54 24 08          	mov    %edx,0x8(%esp)
80103a94:	c7 04 24 d6 7c 10 80 	movl   $0x80107cd6,(%esp)
80103a9b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80103a9f:	e8 dc cb ff ff       	call   80100680 <cprintf>
      release(&ptable.lock);
80103aa4:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103aab:	e8 80 0f 00 00       	call   80104a30 <release>
      return p->parent->pid;
80103ab0:	8b 43 14             	mov    0x14(%ebx),%eax
80103ab3:	8b 40 10             	mov    0x10(%eax),%eax
}
80103ab6:	83 c4 20             	add    $0x20,%esp
80103ab9:	5b                   	pop    %ebx
80103aba:	5e                   	pop    %esi
80103abb:	5d                   	pop    %ebp
80103abc:	c3                   	ret
80103abd:	8d 76 00             	lea    0x0(%esi),%esi
80103ac0:	8b 14 8d c0 83 10 80 	mov    -0x7fef7c40(,%ecx,4),%edx
80103ac7:	eb b6                	jmp    80103a7f <whatsthestatus+0x3f>
80103ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103ad0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ad7:	e8 54 0f 00 00       	call   80104a30 <release>
}
80103adc:	83 c4 20             	add    $0x20,%esp
  return -1;
80103adf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103ae4:	5b                   	pop    %ebx
80103ae5:	5e                   	pop    %esi
80103ae6:	5d                   	pop    %ebp
80103ae7:	c3                   	ret
80103ae8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103aef:	00 

80103af0 <numberofprocesses>:
  int count = 0;
80103af0:	31 d2                	xor    %edx,%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103af2:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103af7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103afe:	00 
80103aff:	90                   	nop
    if(p->state == RUNNABLE)
80103b00:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103b04:	75 01                	jne    80103b07 <numberofprocesses+0x17>
      count++;
80103b06:	42                   	inc    %edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b07:	83 c0 7c             	add    $0x7c,%eax
80103b0a:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103b0f:	75 ef                	jne    80103b00 <numberofprocesses+0x10>
}
80103b11:	89 d0                	mov    %edx,%eax
80103b13:	c3                   	ret
80103b14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b1b:	00 
80103b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b20 <pinit>:
{
80103b20:	55                   	push   %ebp
  initlock(&ptable.lock, "ptable");
80103b21:	b8 e3 7c 10 80       	mov    $0x80107ce3,%eax
{
80103b26:	89 e5                	mov    %esp,%ebp
80103b28:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80103b2b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b2f:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b36:	e8 65 0d 00 00       	call   801048a0 <initlock>
}
80103b3b:	89 ec                	mov    %ebp,%esp
80103b3d:	5d                   	pop    %ebp
80103b3e:	c3                   	ret
80103b3f:	90                   	nop

80103b40 <mycpu>:
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	56                   	push   %esi
80103b44:	53                   	push   %ebx
80103b45:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b48:	9c                   	pushf
80103b49:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b4a:	f6 c4 02             	test   $0x2,%ah
80103b4d:	75 4a                	jne    80103b99 <mycpu+0x59>
  apicid = lapicid();
80103b4f:	e8 7c ee ff ff       	call   801029d0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103b54:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103b5a:	85 f6                	test   %esi,%esi
  apicid = lapicid();
80103b5c:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103b5e:	7e 2d                	jle    80103b8d <mycpu+0x4d>
80103b60:	31 d2                	xor    %edx,%edx
80103b62:	eb 09                	jmp    80103b6d <mycpu+0x2d>
80103b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b68:	42                   	inc    %edx
80103b69:	39 f2                	cmp    %esi,%edx
80103b6b:	74 20                	je     80103b8d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103b6d:	8d 04 92             	lea    (%edx,%edx,4),%eax
80103b70:	8d 04 42             	lea    (%edx,%eax,2),%eax
80103b73:	c1 e0 04             	shl    $0x4,%eax
80103b76:	0f b6 88 a0 27 11 80 	movzbl -0x7feed860(%eax),%ecx
80103b7d:	39 d9                	cmp    %ebx,%ecx
80103b7f:	75 e7                	jne    80103b68 <mycpu+0x28>
}
80103b81:	83 c4 10             	add    $0x10,%esp
      return &cpus[i];
80103b84:	05 a0 27 11 80       	add    $0x801127a0,%eax
}
80103b89:	5b                   	pop    %ebx
80103b8a:	5e                   	pop    %esi
80103b8b:	5d                   	pop    %ebp
80103b8c:	c3                   	ret
  panic("unknown apicid\n");
80103b8d:	c7 04 24 ea 7c 10 80 	movl   $0x80107cea,(%esp)
80103b94:	e8 b7 c7 ff ff       	call   80100350 <panic>
    panic("mycpu called with interrupts enabled\n");
80103b99:	c7 04 24 58 80 10 80 	movl   $0x80108058,(%esp)
80103ba0:	e8 ab c7 ff ff       	call   80100350 <panic>
80103ba5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bac:	00 
80103bad:	8d 76 00             	lea    0x0(%esi),%esi

80103bb0 <cpuid>:
cpuid() {
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103bb6:	e8 85 ff ff ff       	call   80103b40 <mycpu>
}
80103bbb:	89 ec                	mov    %ebp,%esp
80103bbd:	5d                   	pop    %ebp
  return mycpu()-cpus;
80103bbe:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103bc3:	c1 f8 04             	sar    $0x4,%eax
80103bc6:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103bcc:	c3                   	ret
80103bcd:	8d 76 00             	lea    0x0(%esi),%esi

80103bd0 <get_sibling>:
get_sibling(void) {
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	57                   	push   %edi
80103bd4:	56                   	push   %esi
80103bd5:	53                   	push   %ebx
80103bd6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103bd9:	e8 52 0d 00 00       	call   80104930 <pushcli>
  c = mycpu();
80103bde:	e8 5d ff ff ff       	call   80103b40 <mycpu>
  p = c->proc;
80103be3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103be9:	e8 92 0d 00 00       	call   80104980 <popcli>
  int parent_pid = curproc->parent->pid;
80103bee:	8b 43 14             	mov    0x14(%ebx),%eax
  int curr_pid = curproc->pid;
80103bf1:	8b 73 10             	mov    0x10(%ebx),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103bf4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  int parent_pid = curproc->parent->pid;
80103bf9:	8b 78 10             	mov    0x10(%eax),%edi
  acquire(&ptable.lock);
80103bfc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c03:	e8 98 0e 00 00       	call   80104aa0 <acquire>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103c08:	eb 11                	jmp    80103c1b <get_sibling+0x4b>
80103c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c10:	83 c3 7c             	add    $0x7c,%ebx
80103c13:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103c19:	74 42                	je     80103c5d <get_sibling+0x8d>
    if (p->parent->pid == parent_pid && p->pid != curr_pid) {
80103c1b:	8b 43 14             	mov    0x14(%ebx),%eax
80103c1e:	39 78 10             	cmp    %edi,0x10(%eax)
80103c21:	75 ed                	jne    80103c10 <get_sibling+0x40>
80103c23:	8b 43 10             	mov    0x10(%ebx),%eax
80103c26:	39 f0                	cmp    %esi,%eax
80103c28:	74 e6                	je     80103c10 <get_sibling+0x40>
      switch(p->state) {
80103c2a:	8b 4b 0c             	mov    0xc(%ebx),%ecx
80103c2d:	ba 6c 7f 10 80       	mov    $0x80107f6c,%edx
80103c32:	83 f9 05             	cmp    $0x5,%ecx
80103c35:	77 07                	ja     80103c3e <get_sibling+0x6e>
80103c37:	8b 14 8d c0 83 10 80 	mov    -0x7fef7c40(,%ecx,4),%edx
      cprintf("%d %s\n", p->pid, state);
80103c3e:	89 54 24 08          	mov    %edx,0x8(%esp)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103c42:	83 c3 7c             	add    $0x7c,%ebx
      cprintf("%d %s\n", p->pid, state);
80103c45:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c49:	c7 04 24 dc 7c 10 80 	movl   $0x80107cdc,(%esp)
80103c50:	e8 2b ca ff ff       	call   80100680 <cprintf>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103c55:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103c5b:	75 be                	jne    80103c1b <get_sibling+0x4b>
  release(&ptable.lock);
80103c5d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c64:	e8 c7 0d 00 00       	call   80104a30 <release>
}
80103c69:	83 c4 1c             	add    $0x1c,%esp
80103c6c:	31 c0                	xor    %eax,%eax
80103c6e:	5b                   	pop    %ebx
80103c6f:	5e                   	pop    %esi
80103c70:	5f                   	pop    %edi
80103c71:	5d                   	pop    %ebp
80103c72:	c3                   	ret
80103c73:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c7a:	00 
80103c7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103c80 <myproc>:
myproc(void) {
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	83 ec 08             	sub    $0x8,%esp
80103c86:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  pushcli();
80103c89:	e8 a2 0c 00 00       	call   80104930 <pushcli>
  c = mycpu();
80103c8e:	e8 ad fe ff ff       	call   80103b40 <mycpu>
  p = c->proc;
80103c93:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c99:	e8 e2 0c 00 00       	call   80104980 <popcli>
}
80103c9e:	89 d8                	mov    %ebx,%eax
80103ca0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ca3:	89 ec                	mov    %ebp,%esp
80103ca5:	5d                   	pop    %ebp
80103ca6:	c3                   	ret
80103ca7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103cae:	00 
80103caf:	90                   	nop

80103cb0 <userinit>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	83 ec 18             	sub    $0x18,%esp
80103cb6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  p = allocproc();
80103cb9:	e8 92 fb ff ff       	call   80103850 <allocproc>
  initproc = p;
80103cbe:	a3 54 4c 11 80       	mov    %eax,0x80114c54
  p = allocproc();
80103cc3:	89 c3                	mov    %eax,%ebx
  if((p->pgdir = setupkvm()) == 0)
80103cc5:	e8 e6 38 00 00       	call   801075b0 <setupkvm>
80103cca:	89 43 04             	mov    %eax,0x4(%ebx)
80103ccd:	85 c0                	test   %eax,%eax
80103ccf:	0f 84 d0 00 00 00    	je     80103da5 <userinit+0xf5>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103cd5:	89 04 24             	mov    %eax,(%esp)
80103cd8:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103cdd:	b9 60 b4 10 80       	mov    $0x8010b460,%ecx
80103ce2:	89 54 24 08          	mov    %edx,0x8(%esp)
80103ce6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103cea:	e8 81 35 00 00       	call   80107270 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103cef:	b8 4c 00 00 00       	mov    $0x4c,%eax
  p->sz = PGSIZE;
80103cf4:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103cfa:	89 44 24 08          	mov    %eax,0x8(%esp)
80103cfe:	31 c0                	xor    %eax,%eax
80103d00:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d04:	8b 43 18             	mov    0x18(%ebx),%eax
80103d07:	89 04 24             	mov    %eax,(%esp)
80103d0a:	e8 91 0e 00 00       	call   80104ba0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103d0f:	8b 43 18             	mov    0x18(%ebx),%eax
80103d12:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103d18:	8b 43 18             	mov    0x18(%ebx),%eax
80103d1b:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103d21:	8b 43 18             	mov    0x18(%ebx),%eax
80103d24:	8b 50 2c             	mov    0x2c(%eax),%edx
80103d27:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103d2b:	8b 43 18             	mov    0x18(%ebx),%eax
80103d2e:	8b 48 2c             	mov    0x2c(%eax),%ecx
80103d31:	66 89 48 48          	mov    %cx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103d35:	8b 43 18             	mov    0x18(%ebx),%eax
80103d38:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103d3f:	8b 43 18             	mov    0x18(%ebx),%eax
80103d42:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103d49:	8b 43 18             	mov    0x18(%ebx),%eax
80103d4c:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d53:	b8 10 00 00 00       	mov    $0x10,%eax
80103d58:	89 44 24 08          	mov    %eax,0x8(%esp)
80103d5c:	b8 13 7d 10 80       	mov    $0x80107d13,%eax
80103d61:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d65:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103d68:	89 04 24             	mov    %eax,(%esp)
80103d6b:	e8 d0 0f 00 00       	call   80104d40 <safestrcpy>
  p->cwd = namei("/");
80103d70:	c7 04 24 1c 7d 10 80 	movl   $0x80107d1c,(%esp)
80103d77:	e8 24 e4 ff ff       	call   801021a0 <namei>
80103d7c:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103d7f:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d86:	e8 15 0d 00 00       	call   80104aa0 <acquire>
  p->state = RUNNABLE;
80103d8b:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103d92:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d99:	e8 92 0c 00 00       	call   80104a30 <release>
}
80103d9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103da1:	89 ec                	mov    %ebp,%esp
80103da3:	5d                   	pop    %ebp
80103da4:	c3                   	ret
    panic("userinit: out of memory?");
80103da5:	c7 04 24 fa 7c 10 80 	movl   $0x80107cfa,(%esp)
80103dac:	e8 9f c5 ff ff       	call   80100350 <panic>
80103db1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103db8:	00 
80103db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103dc0 <growproc>:
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	56                   	push   %esi
80103dc4:	53                   	push   %ebx
80103dc5:	83 ec 10             	sub    $0x10,%esp
80103dc8:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103dcb:	e8 60 0b 00 00       	call   80104930 <pushcli>
  c = mycpu();
80103dd0:	e8 6b fd ff ff       	call   80103b40 <mycpu>
  p = c->proc;
80103dd5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ddb:	e8 a0 0b 00 00       	call   80104980 <popcli>
  if(n > 0){
80103de0:	85 f6                	test   %esi,%esi
  sz = curproc->sz;
80103de2:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103de4:	7f 1a                	jg     80103e00 <growproc+0x40>
  } else if(n < 0){
80103de6:	75 38                	jne    80103e20 <growproc+0x60>
  curproc->sz = sz;
80103de8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103dea:	89 1c 24             	mov    %ebx,(%esp)
80103ded:	e8 7e 33 00 00       	call   80107170 <switchuvm>
  return 0;
80103df2:	31 c0                	xor    %eax,%eax
}
80103df4:	83 c4 10             	add    $0x10,%esp
80103df7:	5b                   	pop    %ebx
80103df8:	5e                   	pop    %esi
80103df9:	5d                   	pop    %ebp
80103dfa:	c3                   	ret
80103dfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103e00:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e04:	01 c6                	add    %eax,%esi
80103e06:	89 74 24 08          	mov    %esi,0x8(%esp)
80103e0a:	8b 43 04             	mov    0x4(%ebx),%eax
80103e0d:	89 04 24             	mov    %eax,(%esp)
80103e10:	e8 db 35 00 00       	call   801073f0 <allocuvm>
80103e15:	85 c0                	test   %eax,%eax
80103e17:	75 cf                	jne    80103de8 <growproc+0x28>
      return -1;
80103e19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e1e:	eb d4                	jmp    80103df4 <growproc+0x34>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103e20:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e24:	01 c6                	add    %eax,%esi
80103e26:	89 74 24 08          	mov    %esi,0x8(%esp)
80103e2a:	8b 43 04             	mov    0x4(%ebx),%eax
80103e2d:	89 04 24             	mov    %eax,(%esp)
80103e30:	e8 cb 36 00 00       	call   80107500 <deallocuvm>
80103e35:	85 c0                	test   %eax,%eax
80103e37:	75 af                	jne    80103de8 <growproc+0x28>
80103e39:	eb de                	jmp    80103e19 <growproc+0x59>
80103e3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103e40 <fork>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	57                   	push   %edi
80103e44:	56                   	push   %esi
80103e45:	53                   	push   %ebx
80103e46:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e49:	e8 e2 0a 00 00       	call   80104930 <pushcli>
  c = mycpu();
80103e4e:	e8 ed fc ff ff       	call   80103b40 <mycpu>
  p = c->proc;
80103e53:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80103e59:	e8 22 0b 00 00       	call   80104980 <popcli>
  if((np = allocproc()) == 0){
80103e5e:	e8 ed f9 ff ff       	call   80103850 <allocproc>
80103e63:	85 c0                	test   %eax,%eax
80103e65:	0f 84 dd 00 00 00    	je     80103f48 <fork+0x108>
80103e6b:	89 c6                	mov    %eax,%esi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103e6d:	8b 07                	mov    (%edi),%eax
80103e6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e73:	8b 47 04             	mov    0x4(%edi),%eax
80103e76:	89 04 24             	mov    %eax,(%esp)
80103e79:	e8 22 38 00 00       	call   801076a0 <copyuvm>
80103e7e:	89 46 04             	mov    %eax,0x4(%esi)
80103e81:	85 c0                	test   %eax,%eax
80103e83:	0f 84 a6 00 00 00    	je     80103f2f <fork+0xef>
  np->sz = curproc->sz;
80103e89:	8b 07                	mov    (%edi),%eax
  np->parent = curproc;
80103e8b:	89 7e 14             	mov    %edi,0x14(%esi)
  *np->tf = *curproc->tf;
80103e8e:	8b 56 18             	mov    0x18(%esi),%edx
  np->sz = curproc->sz;
80103e91:	89 06                	mov    %eax,(%esi)
  *np->tf = *curproc->tf;
80103e93:	31 c0                	xor    %eax,%eax
80103e95:	8b 4f 18             	mov    0x18(%edi),%ecx
80103e98:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103e9b:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103e9e:	83 c0 04             	add    $0x4,%eax
80103ea1:	83 f8 4c             	cmp    $0x4c,%eax
80103ea4:	72 f2                	jb     80103e98 <fork+0x58>
  np->tf->eax = 0;
80103ea6:	8b 46 18             	mov    0x18(%esi),%eax
  for(i = 0; i < NOFILE; i++)
80103ea9:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103eab:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103eb2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103eb9:	00 
80103eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[i])
80103ec0:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103ec4:	85 c0                	test   %eax,%eax
80103ec6:	74 0c                	je     80103ed4 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ec8:	89 04 24             	mov    %eax,(%esp)
80103ecb:	e8 10 d0 ff ff       	call   80100ee0 <filedup>
80103ed0:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103ed4:	43                   	inc    %ebx
80103ed5:	83 fb 10             	cmp    $0x10,%ebx
80103ed8:	75 e6                	jne    80103ec0 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103eda:	8b 47 68             	mov    0x68(%edi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103edd:	83 c7 6c             	add    $0x6c,%edi
  np->cwd = idup(curproc->cwd);
80103ee0:	89 04 24             	mov    %eax,(%esp)
80103ee3:	e8 28 d9 ff ff       	call   80101810 <idup>
80103ee8:	89 46 68             	mov    %eax,0x68(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103eeb:	b8 10 00 00 00       	mov    $0x10,%eax
80103ef0:	89 44 24 08          	mov    %eax,0x8(%esp)
80103ef4:	8d 46 6c             	lea    0x6c(%esi),%eax
80103ef7:	89 7c 24 04          	mov    %edi,0x4(%esp)
80103efb:	89 04 24             	mov    %eax,(%esp)
80103efe:	e8 3d 0e 00 00       	call   80104d40 <safestrcpy>
  pid = np->pid;
80103f03:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&ptable.lock);
80103f06:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f0d:	e8 8e 0b 00 00       	call   80104aa0 <acquire>
  np->state = RUNNABLE;
80103f12:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  release(&ptable.lock);
80103f19:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f20:	e8 0b 0b 00 00       	call   80104a30 <release>
}
80103f25:	83 c4 1c             	add    $0x1c,%esp
80103f28:	89 d8                	mov    %ebx,%eax
80103f2a:	5b                   	pop    %ebx
80103f2b:	5e                   	pop    %esi
80103f2c:	5f                   	pop    %edi
80103f2d:	5d                   	pop    %ebp
80103f2e:	c3                   	ret
    kfree(np->kstack);
80103f2f:	8b 46 08             	mov    0x8(%esi),%eax
80103f32:	89 04 24             	mov    %eax,(%esp)
80103f35:	e8 76 e6 ff ff       	call   801025b0 <kfree>
    np->kstack = 0;
80103f3a:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
80103f41:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103f48:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f4d:	eb d6                	jmp    80103f25 <fork+0xe5>
80103f4f:	90                   	nop

80103f50 <scheduler>:
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	57                   	push   %edi
80103f54:	56                   	push   %esi
80103f55:	53                   	push   %ebx
80103f56:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103f59:	e8 e2 fb ff ff       	call   80103b40 <mycpu>
  c->proc = 0;
80103f5e:	31 d2                	xor    %edx,%edx
80103f60:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80103f66:	8d 78 04             	lea    0x4(%eax),%edi
  struct cpu *c = mycpu();
80103f69:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103f6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80103f70:	fb                   	sti
    acquire(&ptable.lock);
80103f71:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f78:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103f7d:	e8 1e 0b 00 00       	call   80104aa0 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f82:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f89:	00 
80103f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103f90:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103f94:	75 31                	jne    80103fc7 <scheduler+0x77>
      c->proc = p;
80103f96:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103f9c:	89 1c 24             	mov    %ebx,(%esp)
80103f9f:	e8 cc 31 00 00       	call   80107170 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103fa4:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103fa7:	89 3c 24             	mov    %edi,(%esp)
      p->state = RUNNING;
80103faa:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103fb1:	89 44 24 04          	mov    %eax,0x4(%esp)
80103fb5:	e8 df 0d 00 00       	call   80104d99 <swtch>
      switchkvm();
80103fba:	e8 a1 31 00 00       	call   80107160 <switchkvm>
      c->proc = 0;
80103fbf:	31 c0                	xor    %eax,%eax
80103fc1:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fc7:	83 c3 7c             	add    $0x7c,%ebx
80103fca:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103fd0:	75 be                	jne    80103f90 <scheduler+0x40>
    release(&ptable.lock);
80103fd2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103fd9:	e8 52 0a 00 00       	call   80104a30 <release>
    sti();
80103fde:	eb 90                	jmp    80103f70 <scheduler+0x20>

80103fe0 <sched>:
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	56                   	push   %esi
80103fe4:	53                   	push   %ebx
80103fe5:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80103fe8:	e8 43 09 00 00       	call   80104930 <pushcli>
  c = mycpu();
80103fed:	e8 4e fb ff ff       	call   80103b40 <mycpu>
  p = c->proc;
80103ff2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ff8:	e8 83 09 00 00       	call   80104980 <popcli>
  if(!holding(&ptable.lock))
80103ffd:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104004:	e8 d7 09 00 00       	call   801049e0 <holding>
80104009:	85 c0                	test   %eax,%eax
8010400b:	74 4f                	je     8010405c <sched+0x7c>
  if(mycpu()->ncli != 1)
8010400d:	e8 2e fb ff ff       	call   80103b40 <mycpu>
80104012:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104019:	75 65                	jne    80104080 <sched+0xa0>
  if(p->state == RUNNING)
8010401b:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
8010401f:	74 53                	je     80104074 <sched+0x94>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104021:	9c                   	pushf
80104022:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104023:	f6 c4 02             	test   $0x2,%ah
80104026:	75 40                	jne    80104068 <sched+0x88>
  intena = mycpu()->intena;
80104028:	e8 13 fb ff ff       	call   80103b40 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010402d:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104030:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104036:	e8 05 fb ff ff       	call   80103b40 <mycpu>
8010403b:	8b 40 04             	mov    0x4(%eax),%eax
8010403e:	89 1c 24             	mov    %ebx,(%esp)
80104041:	89 44 24 04          	mov    %eax,0x4(%esp)
80104045:	e8 4f 0d 00 00       	call   80104d99 <swtch>
  mycpu()->intena = intena;
8010404a:	e8 f1 fa ff ff       	call   80103b40 <mycpu>
8010404f:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104055:	83 c4 10             	add    $0x10,%esp
80104058:	5b                   	pop    %ebx
80104059:	5e                   	pop    %esi
8010405a:	5d                   	pop    %ebp
8010405b:	c3                   	ret
    panic("sched ptable.lock");
8010405c:	c7 04 24 1e 7d 10 80 	movl   $0x80107d1e,(%esp)
80104063:	e8 e8 c2 ff ff       	call   80100350 <panic>
    panic("sched interruptible");
80104068:	c7 04 24 4a 7d 10 80 	movl   $0x80107d4a,(%esp)
8010406f:	e8 dc c2 ff ff       	call   80100350 <panic>
    panic("sched running");
80104074:	c7 04 24 3c 7d 10 80 	movl   $0x80107d3c,(%esp)
8010407b:	e8 d0 c2 ff ff       	call   80100350 <panic>
    panic("sched locks");
80104080:	c7 04 24 30 7d 10 80 	movl   $0x80107d30,(%esp)
80104087:	e8 c4 c2 ff ff       	call   80100350 <panic>
8010408c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104090 <exit>:
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	57                   	push   %edi
80104094:	56                   	push   %esi
80104095:	53                   	push   %ebx
80104096:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *curproc = myproc();
80104099:	e8 e2 fb ff ff       	call   80103c80 <myproc>
  if(curproc == initproc)
8010409e:	39 05 54 4c 11 80    	cmp    %eax,0x80114c54
801040a4:	0f 84 fc 00 00 00    	je     801041a6 <exit+0x116>
801040aa:	8d 70 28             	lea    0x28(%eax),%esi
801040ad:	89 c3                	mov    %eax,%ebx
801040af:	8d 78 68             	lea    0x68(%eax),%edi
801040b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040b9:	00 
801040ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
801040c0:	8b 06                	mov    (%esi),%eax
801040c2:	85 c0                	test   %eax,%eax
801040c4:	74 0e                	je     801040d4 <exit+0x44>
      fileclose(curproc->ofile[fd]);
801040c6:	89 04 24             	mov    %eax,(%esp)
801040c9:	e8 62 ce ff ff       	call   80100f30 <fileclose>
      curproc->ofile[fd] = 0;
801040ce:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(fd = 0; fd < NOFILE; fd++){
801040d4:	83 c6 04             	add    $0x4,%esi
801040d7:	39 f7                	cmp    %esi,%edi
801040d9:	75 e5                	jne    801040c0 <exit+0x30>
  begin_op();
801040db:	e8 70 ed ff ff       	call   80102e50 <begin_op>
  iput(curproc->cwd);
801040e0:	8b 43 68             	mov    0x68(%ebx),%eax
801040e3:	89 04 24             	mov    %eax,(%esp)
801040e6:	e8 85 d8 ff ff       	call   80101970 <iput>
  end_op();
801040eb:	e8 d0 ed ff ff       	call   80102ec0 <end_op>
  curproc->cwd = 0;
801040f0:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
801040f7:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040fe:	e8 9d 09 00 00       	call   80104aa0 <acquire>
  wakeup1(curproc->parent);
80104103:	8b 53 14             	mov    0x14(%ebx),%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104106:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010410b:	eb 0d                	jmp    8010411a <exit+0x8a>
8010410d:	8d 76 00             	lea    0x0(%esi),%esi
80104110:	83 c0 7c             	add    $0x7c,%eax
80104113:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104118:	74 1c                	je     80104136 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
8010411a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010411e:	75 f0                	jne    80104110 <exit+0x80>
80104120:	3b 50 20             	cmp    0x20(%eax),%edx
80104123:	75 eb                	jne    80104110 <exit+0x80>
      p->state = RUNNABLE;
80104125:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010412c:	83 c0 7c             	add    $0x7c,%eax
8010412f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104134:	75 e4                	jne    8010411a <exit+0x8a>
      p->parent = initproc;
80104136:	8b 0d 54 4c 11 80    	mov    0x80114c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010413c:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80104141:	eb 10                	jmp    80104153 <exit+0xc3>
80104143:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104148:	83 c2 7c             	add    $0x7c,%edx
8010414b:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80104151:	74 3b                	je     8010418e <exit+0xfe>
    if(p->parent == curproc){
80104153:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104156:	75 f0                	jne    80104148 <exit+0xb8>
      if(p->state == ZOMBIE)
80104158:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010415c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010415f:	75 e7                	jne    80104148 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104161:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104166:	eb 12                	jmp    8010417a <exit+0xea>
80104168:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010416f:	00 
80104170:	83 c0 7c             	add    $0x7c,%eax
80104173:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104178:	74 ce                	je     80104148 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
8010417a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010417e:	75 f0                	jne    80104170 <exit+0xe0>
80104180:	3b 48 20             	cmp    0x20(%eax),%ecx
80104183:	75 eb                	jne    80104170 <exit+0xe0>
      p->state = RUNNABLE;
80104185:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010418c:	eb e2                	jmp    80104170 <exit+0xe0>
  curproc->state = ZOMBIE;
8010418e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104195:	e8 46 fe ff ff       	call   80103fe0 <sched>
  panic("zombie exit");
8010419a:	c7 04 24 6b 7d 10 80 	movl   $0x80107d6b,(%esp)
801041a1:	e8 aa c1 ff ff       	call   80100350 <panic>
    panic("init exiting");
801041a6:	c7 04 24 5e 7d 10 80 	movl   $0x80107d5e,(%esp)
801041ad:	e8 9e c1 ff ff       	call   80100350 <panic>
801041b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041b9:	00 
801041ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041c0 <wait>:
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	56                   	push   %esi
801041c4:	53                   	push   %ebx
801041c5:	83 ec 10             	sub    $0x10,%esp
  pushcli();
801041c8:	e8 63 07 00 00       	call   80104930 <pushcli>
  c = mycpu();
801041cd:	e8 6e f9 ff ff       	call   80103b40 <mycpu>
  p = c->proc;
801041d2:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801041d8:	e8 a3 07 00 00       	call   80104980 <popcli>
  acquire(&ptable.lock);
801041dd:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801041e4:	e8 b7 08 00 00       	call   80104aa0 <acquire>
    havekids = 0;
801041e9:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041eb:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
801041f0:	eb 11                	jmp    80104203 <wait+0x43>
801041f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041f8:	83 c3 7c             	add    $0x7c,%ebx
801041fb:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104201:	74 1b                	je     8010421e <wait+0x5e>
      if(p->parent != curproc)
80104203:	39 73 14             	cmp    %esi,0x14(%ebx)
80104206:	75 f0                	jne    801041f8 <wait+0x38>
      if(p->state == ZOMBIE){
80104208:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010420c:	74 62                	je     80104270 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010420e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104211:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104216:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
8010421c:	75 e5                	jne    80104203 <wait+0x43>
    if(!havekids || curproc->killed){
8010421e:	85 c0                	test   %eax,%eax
80104220:	0f 84 9f 00 00 00    	je     801042c5 <wait+0x105>
80104226:	8b 46 24             	mov    0x24(%esi),%eax
80104229:	85 c0                	test   %eax,%eax
8010422b:	0f 85 94 00 00 00    	jne    801042c5 <wait+0x105>
  pushcli();
80104231:	e8 fa 06 00 00       	call   80104930 <pushcli>
  c = mycpu();
80104236:	e8 05 f9 ff ff       	call   80103b40 <mycpu>
  p = c->proc;
8010423b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104241:	e8 3a 07 00 00       	call   80104980 <popcli>
  if(p == 0)
80104246:	85 db                	test   %ebx,%ebx
80104248:	0f 84 8a 00 00 00    	je     801042d8 <wait+0x118>
  p->chan = chan;
8010424e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104251:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104258:	e8 83 fd ff ff       	call   80103fe0 <sched>
  p->chan = 0;
8010425d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104264:	eb 83                	jmp    801041e9 <wait+0x29>
80104266:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010426d:	00 
8010426e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104270:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104273:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104276:	89 04 24             	mov    %eax,(%esp)
80104279:	e8 32 e3 ff ff       	call   801025b0 <kfree>
        freevm(p->pgdir);
8010427e:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104281:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104288:	89 04 24             	mov    %eax,(%esp)
8010428b:	e8 a0 32 00 00       	call   80107530 <freevm>
        p->pid = 0;
80104290:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104297:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010429e:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801042a2:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801042a9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801042b0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801042b7:	e8 74 07 00 00       	call   80104a30 <release>
}
801042bc:	83 c4 10             	add    $0x10,%esp
801042bf:	89 f0                	mov    %esi,%eax
801042c1:	5b                   	pop    %ebx
801042c2:	5e                   	pop    %esi
801042c3:	5d                   	pop    %ebp
801042c4:	c3                   	ret
      release(&ptable.lock);
801042c5:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
      return -1;
801042cc:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801042d1:	e8 5a 07 00 00       	call   80104a30 <release>
      return -1;
801042d6:	eb e4                	jmp    801042bc <wait+0xfc>
    panic("sleep");
801042d8:	c7 04 24 77 7d 10 80 	movl   $0x80107d77,(%esp)
801042df:	e8 6c c0 ff ff       	call   80100350 <panic>
801042e4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042eb:	00 
801042ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042f0 <yield>:
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	83 ec 18             	sub    $0x18,%esp
801042f6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  acquire(&ptable.lock);  //DOC: yieldlock
801042f9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104300:	e8 9b 07 00 00       	call   80104aa0 <acquire>
  pushcli();
80104305:	e8 26 06 00 00       	call   80104930 <pushcli>
  c = mycpu();
8010430a:	e8 31 f8 ff ff       	call   80103b40 <mycpu>
  p = c->proc;
8010430f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104315:	e8 66 06 00 00       	call   80104980 <popcli>
  myproc()->state = RUNNABLE;
8010431a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104321:	e8 ba fc ff ff       	call   80103fe0 <sched>
  release(&ptable.lock);
80104326:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010432d:	e8 fe 06 00 00       	call   80104a30 <release>
}
80104332:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104335:	89 ec                	mov    %ebp,%esp
80104337:	5d                   	pop    %ebp
80104338:	c3                   	ret
80104339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104340 <sleep>:
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	83 ec 28             	sub    $0x28,%esp
80104346:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104349:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010434c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010434f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104352:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
80104355:	e8 d6 05 00 00       	call   80104930 <pushcli>
  c = mycpu();
8010435a:	e8 e1 f7 ff ff       	call   80103b40 <mycpu>
  p = c->proc;
8010435f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104365:	e8 16 06 00 00       	call   80104980 <popcli>
  if(p == 0)
8010436a:	85 db                	test   %ebx,%ebx
8010436c:	0f 84 8d 00 00 00    	je     801043ff <sleep+0xbf>
  if(lk == 0)
80104372:	85 f6                	test   %esi,%esi
80104374:	74 7d                	je     801043f3 <sleep+0xb3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104376:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
8010437c:	74 52                	je     801043d0 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010437e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104385:	e8 16 07 00 00       	call   80104aa0 <acquire>
    release(lk);
8010438a:	89 34 24             	mov    %esi,(%esp)
8010438d:	e8 9e 06 00 00       	call   80104a30 <release>
  p->chan = chan;
80104392:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104395:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010439c:	e8 3f fc ff ff       	call   80103fe0 <sched>
  p->chan = 0;
801043a1:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801043a8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801043af:	e8 7c 06 00 00       	call   80104a30 <release>
}
801043b4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    acquire(lk);
801043b7:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043ba:	8b 7d fc             	mov    -0x4(%ebp),%edi
801043bd:	8b 75 f8             	mov    -0x8(%ebp),%esi
801043c0:	89 ec                	mov    %ebp,%esp
801043c2:	5d                   	pop    %ebp
    acquire(lk);
801043c3:	e9 d8 06 00 00       	jmp    80104aa0 <acquire>
801043c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043cf:	00 
  p->chan = chan;
801043d0:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801043d3:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801043da:	e8 01 fc ff ff       	call   80103fe0 <sched>
  p->chan = 0;
801043df:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801043e6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801043e9:	8b 75 f8             	mov    -0x8(%ebp),%esi
801043ec:	8b 7d fc             	mov    -0x4(%ebp),%edi
801043ef:	89 ec                	mov    %ebp,%esp
801043f1:	5d                   	pop    %ebp
801043f2:	c3                   	ret
    panic("sleep without lk");
801043f3:	c7 04 24 7d 7d 10 80 	movl   $0x80107d7d,(%esp)
801043fa:	e8 51 bf ff ff       	call   80100350 <panic>
    panic("sleep");
801043ff:	c7 04 24 77 7d 10 80 	movl   $0x80107d77,(%esp)
80104406:	e8 45 bf ff ff       	call   80100350 <panic>
8010440b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104410 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	83 ec 18             	sub    $0x18,%esp
80104416:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80104419:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010441c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104423:	e8 78 06 00 00       	call   80104aa0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104428:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010442d:	eb 0b                	jmp    8010443a <wakeup+0x2a>
8010442f:	90                   	nop
80104430:	83 c0 7c             	add    $0x7c,%eax
80104433:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104438:	74 1c                	je     80104456 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010443a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010443e:	75 f0                	jne    80104430 <wakeup+0x20>
80104440:	3b 58 20             	cmp    0x20(%eax),%ebx
80104443:	75 eb                	jne    80104430 <wakeup+0x20>
      p->state = RUNNABLE;
80104445:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010444c:	83 c0 7c             	add    $0x7c,%eax
8010444f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104454:	75 e4                	jne    8010443a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104456:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
8010445d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104460:	89 ec                	mov    %ebp,%esp
80104462:	5d                   	pop    %ebp
  release(&ptable.lock);
80104463:	e9 c8 05 00 00       	jmp    80104a30 <release>
80104468:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010446f:	00 

80104470 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	83 ec 18             	sub    $0x18,%esp
80104476:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80104479:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010447c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104483:	e8 18 06 00 00       	call   80104aa0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104488:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010448d:	eb 0b                	jmp    8010449a <kill+0x2a>
8010448f:	90                   	nop
80104490:	83 c0 7c             	add    $0x7c,%eax
80104493:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104498:	74 36                	je     801044d0 <kill+0x60>
    if(p->pid == pid){
8010449a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010449d:	75 f1                	jne    80104490 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010449f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801044a3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801044aa:	75 07                	jne    801044b3 <kill+0x43>
        p->state = RUNNABLE;
801044ac:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801044b3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801044ba:	e8 71 05 00 00       	call   80104a30 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801044bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044c2:	89 ec                	mov    %ebp,%esp
801044c4:	5d                   	pop    %ebp
      return 0;
801044c5:	31 c0                	xor    %eax,%eax
}
801044c7:	c3                   	ret
801044c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044cf:	00 
  release(&ptable.lock);
801044d0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801044d7:	e8 54 05 00 00       	call   80104a30 <release>
}
801044dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044df:	89 ec                	mov    %ebp,%esp
801044e1:	5d                   	pop    %ebp
  return -1;
801044e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801044e7:	c3                   	ret
801044e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044ef:	00 

801044f0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	57                   	push   %edi
801044f4:	56                   	push   %esi
801044f5:	53                   	push   %ebx
801044f6:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
801044fb:	8d 75 c0             	lea    -0x40(%ebp),%esi
{
801044fe:	83 ec 4c             	sub    $0x4c,%esp
80104501:	eb 20                	jmp    80104523 <procdump+0x33>
80104503:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104508:	c7 04 24 6b 7f 10 80 	movl   $0x80107f6b,(%esp)
8010450f:	e8 6c c1 ff ff       	call   80100680 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104514:	83 c3 7c             	add    $0x7c,%ebx
80104517:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
8010451d:	0f 84 85 00 00 00    	je     801045a8 <procdump+0xb8>
    if(p->state == UNUSED)
80104523:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104526:	85 c0                	test   %eax,%eax
80104528:	74 ea                	je     80104514 <procdump+0x24>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010452a:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
8010452d:	ba 8e 7d 10 80       	mov    $0x80107d8e,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104532:	77 11                	ja     80104545 <procdump+0x55>
80104534:	8b 14 85 d8 83 10 80 	mov    -0x7fef7c28(,%eax,4),%edx
      state = "???";
8010453b:	b8 8e 7d 10 80       	mov    $0x80107d8e,%eax
80104540:	85 d2                	test   %edx,%edx
80104542:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104545:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80104549:	89 54 24 08          	mov    %edx,0x8(%esp)
8010454d:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80104550:	c7 04 24 92 7d 10 80 	movl   $0x80107d92,(%esp)
80104557:	89 44 24 04          	mov    %eax,0x4(%esp)
8010455b:	e8 20 c1 ff ff       	call   80100680 <cprintf>
    if(p->state == SLEEPING){
80104560:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104564:	75 a2                	jne    80104508 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104566:	89 74 24 04          	mov    %esi,0x4(%esp)
8010456a:	89 f7                	mov    %esi,%edi
8010456c:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010456f:	8b 40 0c             	mov    0xc(%eax),%eax
80104572:	83 c0 08             	add    $0x8,%eax
80104575:	89 04 24             	mov    %eax,(%esp)
80104578:	e8 43 03 00 00       	call   801048c0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010457d:	8d 76 00             	lea    0x0(%esi),%esi
80104580:	8b 07                	mov    (%edi),%eax
80104582:	85 c0                	test   %eax,%eax
80104584:	74 82                	je     80104508 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104586:	89 44 24 04          	mov    %eax,0x4(%esp)
      for(i=0; i<10 && pc[i] != 0; i++)
8010458a:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010458d:	c7 04 24 c1 7a 10 80 	movl   $0x80107ac1,(%esp)
80104594:	e8 e7 c0 ff ff       	call   80100680 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104599:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010459c:	39 c7                	cmp    %eax,%edi
8010459e:	75 e0                	jne    80104580 <procdump+0x90>
801045a0:	e9 63 ff ff ff       	jmp    80104508 <procdump+0x18>
801045a5:	8d 76 00             	lea    0x0(%esi),%esi
  }
}
801045a8:	83 c4 4c             	add    $0x4c,%esp
801045ab:	5b                   	pop    %ebx
801045ac:	5e                   	pop    %esi
801045ad:	5f                   	pop    %edi
801045ae:	5d                   	pop    %ebp
801045af:	c3                   	ret

801045b0 <spawn>:

int
spawn(int n, int* pids) {
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	57                   	push   %edi
801045b4:	56                   	push   %esi
801045b5:	53                   	push   %ebx
801045b6:	83 ec 3c             	sub    $0x3c,%esp
  pushcli();
801045b9:	e8 72 03 00 00       	call   80104930 <pushcli>
  c = mycpu();
801045be:	e8 7d f5 ff ff       	call   80103b40 <mycpu>
  p = c->proc;
801045c3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801045c9:	e8 b2 03 00 00       	call   80104980 <popcli>
  int count = 0;
  struct proc *curproc = myproc();

  int temp[n];
801045ce:	8b 45 08             	mov    0x8(%ebp),%eax

  for (int i = 0; i < n; i++) {
801045d1:	8b 55 08             	mov    0x8(%ebp),%edx
  int temp[n];
801045d4:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
801045db:	8d 43 0f             	lea    0xf(%ebx),%eax
801045de:	83 e0 f0             	and    $0xfffffff0,%eax
801045e1:	29 c4                	sub    %eax,%esp
  for (int i = 0; i < n; i++) {
801045e3:	85 d2                	test   %edx,%edx
  int temp[n];
801045e5:	8d 44 24 0c          	lea    0xc(%esp),%eax
801045e9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for (int i = 0; i < n; i++) {
801045ec:	0f 8e 58 01 00 00    	jle    8010474a <spawn+0x19a>
801045f2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for (int i_file = 0; i_file < NOFILE; i_file++)
      if (curproc->ofile[i_file])
        np->ofile[i_file] = filedup(curproc->ofile[i_file]);
    np->cwd = idup(curproc->cwd);

    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801045f9:	8d 46 6c             	lea    0x6c(%esi),%eax
  int count = 0;
801045fc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104603:	89 45 d8             	mov    %eax,-0x28(%ebp)
80104606:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
80104609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((np = allocproc()) == 0)
80104610:	e8 3b f2 ff ff       	call   80103850 <allocproc>
80104615:	85 c0                	test   %eax,%eax
80104617:	89 c3                	mov    %eax,%ebx
80104619:	0f 84 c2 00 00 00    	je     801046e1 <spawn+0x131>
    if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0) {
8010461f:	8b 06                	mov    (%esi),%eax
80104621:	89 44 24 04          	mov    %eax,0x4(%esp)
80104625:	8b 46 04             	mov    0x4(%esi),%eax
80104628:	89 04 24             	mov    %eax,(%esp)
8010462b:	e8 70 30 00 00       	call   801076a0 <copyuvm>
80104630:	89 43 04             	mov    %eax,0x4(%ebx)
80104633:	85 c0                	test   %eax,%eax
80104635:	0f 84 e5 00 00 00    	je     80104720 <spawn+0x170>
    np->sz = curproc->sz;
8010463b:	8b 06                	mov    (%esi),%eax
    np->parent = curproc;
8010463d:	89 73 14             	mov    %esi,0x14(%ebx)
    *np->tf = *curproc->tf;
80104640:	8b 53 18             	mov    0x18(%ebx),%edx
    np->sz = curproc->sz;
80104643:	89 03                	mov    %eax,(%ebx)
    *np->tf = *curproc->tf;
80104645:	31 c0                	xor    %eax,%eax
80104647:	8b 4e 18             	mov    0x18(%esi),%ecx
8010464a:	8b 3c 01             	mov    (%ecx,%eax,1),%edi
8010464d:	89 3c 02             	mov    %edi,(%edx,%eax,1)
80104650:	83 c0 04             	add    $0x4,%eax
80104653:	83 f8 4c             	cmp    $0x4c,%eax
80104656:	72 f2                	jb     8010464a <spawn+0x9a>
    np->tf->eax = 0;
80104658:	8b 43 18             	mov    0x18(%ebx),%eax
    for (int i_file = 0; i_file < NOFILE; i_file++)
8010465b:	31 ff                	xor    %edi,%edi
    np->tf->eax = 0;
8010465d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    for (int i_file = 0; i_file < NOFILE; i_file++)
80104664:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010466b:	00 
8010466c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if (curproc->ofile[i_file])
80104670:	8b 44 be 28          	mov    0x28(%esi,%edi,4),%eax
80104674:	85 c0                	test   %eax,%eax
80104676:	74 0c                	je     80104684 <spawn+0xd4>
        np->ofile[i_file] = filedup(curproc->ofile[i_file]);
80104678:	89 04 24             	mov    %eax,(%esp)
8010467b:	e8 60 c8 ff ff       	call   80100ee0 <filedup>
80104680:	89 44 bb 28          	mov    %eax,0x28(%ebx,%edi,4)
    for (int i_file = 0; i_file < NOFILE; i_file++)
80104684:	47                   	inc    %edi
80104685:	83 ff 10             	cmp    $0x10,%edi
80104688:	75 e6                	jne    80104670 <spawn+0xc0>
    np->cwd = idup(curproc->cwd);
8010468a:	8b 46 68             	mov    0x68(%esi),%eax
8010468d:	89 04 24             	mov    %eax,(%esp)
80104690:	e8 7b d1 ff ff       	call   80101810 <idup>
80104695:	89 43 68             	mov    %eax,0x68(%ebx)
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104698:	b8 10 00 00 00       	mov    $0x10,%eax
8010469d:	89 44 24 08          	mov    %eax,0x8(%esp)
801046a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
801046a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801046a8:	8d 43 6c             	lea    0x6c(%ebx),%eax
801046ab:	89 04 24             	mov    %eax,(%esp)
801046ae:	e8 8d 06 00 00       	call   80104d40 <safestrcpy>
    // pids[i] = np->pid;
    temp[i] = np->pid;
801046b3:	8b 43 10             	mov    0x10(%ebx),%eax
801046b6:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801046b9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801046bc:	89 04 91             	mov    %eax,(%ecx,%edx,4)

    acquire(&ptable.lock);
801046bf:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801046c6:	e8 d5 03 00 00       	call   80104aa0 <acquire>
    np->state = RUNNABLE;
801046cb:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    release(&ptable.lock);
801046d2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801046d9:	e8 52 03 00 00       	call   80104a30 <release>

    count++;
801046de:	ff 45 e0             	incl   -0x20(%ebp)
  for (int i = 0; i < n; i++) {
801046e1:	ff 45 e4             	incl   -0x1c(%ebp)
801046e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801046e7:	39 45 08             	cmp    %eax,0x8(%ebp)
801046ea:	0f 85 20 ff ff ff    	jne    80104610 <spawn+0x60>
801046f0:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
  }

  for (int i = 0; i < n; i++) {
801046f3:	8b 45 dc             	mov    -0x24(%ebp),%eax
801046f6:	8b 55 0c             	mov    0xc(%ebp),%edx
801046f9:	01 c3                	add    %eax,%ebx
801046fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    pids[i] = temp[i];
80104700:	8b 08                	mov    (%eax),%ecx
  for (int i = 0; i < n; i++) {
80104702:	83 c0 04             	add    $0x4,%eax
80104705:	83 c2 04             	add    $0x4,%edx
    pids[i] = temp[i];
80104708:	89 4a fc             	mov    %ecx,-0x4(%edx)
  for (int i = 0; i < n; i++) {
8010470b:	39 d8                	cmp    %ebx,%eax
8010470d:	75 f1                	jne    80104700 <spawn+0x150>
  }

  return count;
}
8010470f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104712:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104715:	5b                   	pop    %ebx
80104716:	5e                   	pop    %esi
80104717:	5f                   	pop    %edi
80104718:	5d                   	pop    %ebp
80104719:	c3                   	ret
8010471a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      kfree(np->kstack);
80104720:	8b 43 08             	mov    0x8(%ebx),%eax
80104723:	89 04 24             	mov    %eax,(%esp)
80104726:	e8 85 de ff ff       	call   801025b0 <kfree>
  for (int i = 0; i < n; i++) {
8010472b:	ff 45 e4             	incl   -0x1c(%ebp)
      np->kstack = 0;
8010472e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
      np->state = UNUSED;
80104735:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  for (int i = 0; i < n; i++) {
8010473c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010473f:	39 45 08             	cmp    %eax,0x8(%ebp)
80104742:	0f 85 c8 fe ff ff    	jne    80104610 <spawn+0x60>
80104748:	eb a6                	jmp    801046f0 <spawn+0x140>
  int count = 0;
8010474a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80104751:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104754:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104757:	5b                   	pop    %ebx
80104758:	5e                   	pop    %esi
80104759:	5f                   	pop    %edi
8010475a:	5d                   	pop    %ebp
8010475b:	c3                   	ret
8010475c:	66 90                	xchg   %ax,%ax
8010475e:	66 90                	xchg   %ax,%ax

80104760 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104760:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80104761:	b8 f4 7d 10 80       	mov    $0x80107df4,%eax
{
80104766:	89 e5                	mov    %esp,%ebp
80104768:	83 ec 18             	sub    $0x18,%esp
8010476b:	89 5d fc             	mov    %ebx,-0x4(%ebp)
8010476e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104771:	89 44 24 04          	mov    %eax,0x4(%esp)
80104775:	8d 43 04             	lea    0x4(%ebx),%eax
80104778:	89 04 24             	mov    %eax,(%esp)
8010477b:	e8 20 01 00 00       	call   801048a0 <initlock>
  lk->name = name;
80104780:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104783:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104789:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104790:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104793:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104796:	89 ec                	mov    %ebp,%esp
80104798:	5d                   	pop    %ebp
80104799:	c3                   	ret
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047a0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	56                   	push   %esi
801047a4:	53                   	push   %ebx
801047a5:	83 ec 10             	sub    $0x10,%esp
801047a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801047ab:	8d 73 04             	lea    0x4(%ebx),%esi
801047ae:	89 34 24             	mov    %esi,(%esp)
801047b1:	e8 ea 02 00 00       	call   80104aa0 <acquire>
  while (lk->locked) {
801047b6:	8b 13                	mov    (%ebx),%edx
801047b8:	85 d2                	test   %edx,%edx
801047ba:	74 16                	je     801047d2 <acquiresleep+0x32>
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801047c0:	89 74 24 04          	mov    %esi,0x4(%esp)
801047c4:	89 1c 24             	mov    %ebx,(%esp)
801047c7:	e8 74 fb ff ff       	call   80104340 <sleep>
  while (lk->locked) {
801047cc:	8b 03                	mov    (%ebx),%eax
801047ce:	85 c0                	test   %eax,%eax
801047d0:	75 ee                	jne    801047c0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801047d2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801047d8:	e8 a3 f4 ff ff       	call   80103c80 <myproc>
801047dd:	8b 40 10             	mov    0x10(%eax),%eax
801047e0:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801047e3:	89 75 08             	mov    %esi,0x8(%ebp)
}
801047e6:	83 c4 10             	add    $0x10,%esp
801047e9:	5b                   	pop    %ebx
801047ea:	5e                   	pop    %esi
801047eb:	5d                   	pop    %ebp
  release(&lk->lk);
801047ec:	e9 3f 02 00 00       	jmp    80104a30 <release>
801047f1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047f8:	00 
801047f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104800 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	83 ec 18             	sub    $0x18,%esp
80104806:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104809:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010480c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010480f:	8d 73 04             	lea    0x4(%ebx),%esi
80104812:	89 34 24             	mov    %esi,(%esp)
80104815:	e8 86 02 00 00       	call   80104aa0 <acquire>
  lk->locked = 0;
8010481a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104820:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104827:	89 1c 24             	mov    %ebx,(%esp)
8010482a:	e8 e1 fb ff ff       	call   80104410 <wakeup>
  release(&lk->lk);
}
8010482f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
80104832:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104835:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104838:	89 ec                	mov    %ebp,%esp
8010483a:	5d                   	pop    %ebp
  release(&lk->lk);
8010483b:	e9 f0 01 00 00       	jmp    80104a30 <release>

80104840 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	83 ec 28             	sub    $0x28,%esp
80104846:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104849:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010484c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010484f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104852:	31 ff                	xor    %edi,%edi
  int r;
  
  acquire(&lk->lk);
80104854:	8d 73 04             	lea    0x4(%ebx),%esi
80104857:	89 34 24             	mov    %esi,(%esp)
8010485a:	e8 41 02 00 00       	call   80104aa0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010485f:	8b 03                	mov    (%ebx),%eax
80104861:	85 c0                	test   %eax,%eax
80104863:	75 1b                	jne    80104880 <holdingsleep+0x40>
  release(&lk->lk);
80104865:	89 34 24             	mov    %esi,(%esp)
80104868:	e8 c3 01 00 00       	call   80104a30 <release>
  return r;
}
8010486d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104870:	89 f8                	mov    %edi,%eax
80104872:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104875:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104878:	89 ec                	mov    %ebp,%esp
8010487a:	5d                   	pop    %ebp
8010487b:	c3                   	ret
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104880:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104883:	e8 f8 f3 ff ff       	call   80103c80 <myproc>
80104888:	39 58 10             	cmp    %ebx,0x10(%eax)
8010488b:	0f 94 c0             	sete   %al
8010488e:	0f b6 f8             	movzbl %al,%edi
80104891:	eb d2                	jmp    80104865 <holdingsleep+0x25>
80104893:	66 90                	xchg   %ax,%ax
80104895:	66 90                	xchg   %ax,%ax
80104897:	66 90                	xchg   %ax,%ax
80104899:	66 90                	xchg   %ax,%ax
8010489b:	66 90                	xchg   %ax,%ax
8010489d:	66 90                	xchg   %ax,%ax
8010489f:	90                   	nop

801048a0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801048a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801048a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801048af:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801048b2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801048b9:	5d                   	pop    %ebp
801048ba:	c3                   	ret
801048bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801048c0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801048c0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801048c1:	31 d2                	xor    %edx,%edx
{
801048c3:	89 e5                	mov    %esp,%ebp
801048c5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801048c6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801048c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801048cc:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801048cf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801048d0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801048d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801048dc:	77 12                	ja     801048f0 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
801048de:	8b 58 04             	mov    0x4(%eax),%ebx
801048e1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801048e4:	42                   	inc    %edx
801048e5:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801048e8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801048ea:	75 e4                	jne    801048d0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801048ec:	5b                   	pop    %ebx
801048ed:	5d                   	pop    %ebp
801048ee:	c3                   	ret
801048ef:	90                   	nop
  for(; i < 10; i++)
801048f0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801048f3:	83 c1 28             	add    $0x28,%ecx
801048f6:	89 ca                	mov    %ecx,%edx
801048f8:	29 c2                	sub    %eax,%edx
801048fa:	f6 c2 04             	test   $0x4,%dl
801048fd:	74 11                	je     80104910 <getcallerpcs+0x50>
    pcs[i] = 0;
801048ff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104905:	83 c0 04             	add    $0x4,%eax
80104908:	39 c8                	cmp    %ecx,%eax
8010490a:	74 e0                	je     801048ec <getcallerpcs+0x2c>
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104910:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104916:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104919:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104920:	39 c8                	cmp    %ecx,%eax
80104922:	75 ec                	jne    80104910 <getcallerpcs+0x50>
80104924:	eb c6                	jmp    801048ec <getcallerpcs+0x2c>
80104926:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010492d:	00 
8010492e:	66 90                	xchg   %ax,%ax

80104930 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	83 ec 08             	sub    $0x8,%esp
80104936:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80104939:	9c                   	pushf
8010493a:	5b                   	pop    %ebx
  asm volatile("cli");
8010493b:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010493c:	e8 ff f1 ff ff       	call   80103b40 <mycpu>
80104941:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104947:	85 c0                	test   %eax,%eax
80104949:	74 15                	je     80104960 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
8010494b:	e8 f0 f1 ff ff       	call   80103b40 <mycpu>
80104950:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80104956:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104959:	89 ec                	mov    %ebp,%esp
8010495b:	5d                   	pop    %ebp
8010495c:	c3                   	ret
8010495d:	8d 76 00             	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104960:	e8 db f1 ff ff       	call   80103b40 <mycpu>
80104965:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010496b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104971:	eb d8                	jmp    8010494b <pushcli+0x1b>
80104973:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010497a:	00 
8010497b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104980 <popcli>:

void
popcli(void)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104986:	9c                   	pushf
80104987:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104988:	f6 c4 02             	test   $0x2,%ah
8010498b:	75 37                	jne    801049c4 <popcli+0x44>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010498d:	e8 ae f1 ff ff       	call   80103b40 <mycpu>
80104992:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80104998:	78 36                	js     801049d0 <popcli+0x50>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010499a:	e8 a1 f1 ff ff       	call   80103b40 <mycpu>
8010499f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801049a5:	85 d2                	test   %edx,%edx
801049a7:	74 07                	je     801049b0 <popcli+0x30>
    sti();
}
801049a9:	89 ec                	mov    %ebp,%esp
801049ab:	5d                   	pop    %ebp
801049ac:	c3                   	ret
801049ad:	8d 76 00             	lea    0x0(%esi),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801049b0:	e8 8b f1 ff ff       	call   80103b40 <mycpu>
801049b5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801049bb:	85 c0                	test   %eax,%eax
801049bd:	74 ea                	je     801049a9 <popcli+0x29>
  asm volatile("sti");
801049bf:	fb                   	sti
}
801049c0:	89 ec                	mov    %ebp,%esp
801049c2:	5d                   	pop    %ebp
801049c3:	c3                   	ret
    panic("popcli - interruptible");
801049c4:	c7 04 24 ff 7d 10 80 	movl   $0x80107dff,(%esp)
801049cb:	e8 80 b9 ff ff       	call   80100350 <panic>
    panic("popcli");
801049d0:	c7 04 24 16 7e 10 80 	movl   $0x80107e16,(%esp)
801049d7:	e8 74 b9 ff ff       	call   80100350 <panic>
801049dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049e0 <holding>:
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	83 ec 08             	sub    $0x8,%esp
801049e6:	89 75 fc             	mov    %esi,-0x4(%ebp)
801049e9:	8b 75 08             	mov    0x8(%ebp),%esi
801049ec:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801049ef:	31 db                	xor    %ebx,%ebx
  pushcli();
801049f1:	e8 3a ff ff ff       	call   80104930 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801049f6:	8b 06                	mov    (%esi),%eax
801049f8:	85 c0                	test   %eax,%eax
801049fa:	75 14                	jne    80104a10 <holding+0x30>
  popcli();
801049fc:	e8 7f ff ff ff       	call   80104980 <popcli>
}
80104a01:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104a04:	89 d8                	mov    %ebx,%eax
80104a06:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104a09:	89 ec                	mov    %ebp,%esp
80104a0b:	5d                   	pop    %ebp
80104a0c:	c3                   	ret
80104a0d:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104a10:	8b 5e 08             	mov    0x8(%esi),%ebx
80104a13:	e8 28 f1 ff ff       	call   80103b40 <mycpu>
80104a18:	39 c3                	cmp    %eax,%ebx
80104a1a:	0f 94 c3             	sete   %bl
80104a1d:	0f b6 db             	movzbl %bl,%ebx
80104a20:	eb da                	jmp    801049fc <holding+0x1c>
80104a22:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a29:	00 
80104a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a30 <release>:
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	83 ec 18             	sub    $0x18,%esp
80104a36:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104a39:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a3c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  pushcli();
80104a3f:	e8 ec fe ff ff       	call   80104930 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104a44:	8b 03                	mov    (%ebx),%eax
80104a46:	85 c0                	test   %eax,%eax
80104a48:	75 16                	jne    80104a60 <release+0x30>
  popcli();
80104a4a:	e8 31 ff ff ff       	call   80104980 <popcli>
    panic("release");
80104a4f:	c7 04 24 1d 7e 10 80 	movl   $0x80107e1d,(%esp)
80104a56:	e8 f5 b8 ff ff       	call   80100350 <panic>
80104a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104a60:	8b 73 08             	mov    0x8(%ebx),%esi
80104a63:	e8 d8 f0 ff ff       	call   80103b40 <mycpu>
80104a68:	39 c6                	cmp    %eax,%esi
80104a6a:	75 de                	jne    80104a4a <release+0x1a>
  popcli();
80104a6c:	e8 0f ff ff ff       	call   80104980 <popcli>
  lk->pcs[0] = 0;
80104a71:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104a78:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104a7f:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104a84:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104a8a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104a8d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104a90:	89 ec                	mov    %ebp,%esp
80104a92:	5d                   	pop    %ebp
  popcli();
80104a93:	e9 e8 fe ff ff       	jmp    80104980 <popcli>
80104a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a9f:	00 

80104aa0 <acquire>:
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	83 ec 18             	sub    $0x18,%esp
80104aa6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  pushcli(); // disable interrupts to avoid deadlock.
80104aa9:	e8 82 fe ff ff       	call   80104930 <pushcli>
  if(holding(lk))
80104aae:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104ab1:	e8 7a fe ff ff       	call   80104930 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104ab6:	8b 03                	mov    (%ebx),%eax
80104ab8:	85 c0                	test   %eax,%eax
80104aba:	0f 85 b0 00 00 00    	jne    80104b70 <acquire+0xd0>
  popcli();
80104ac0:	e8 bb fe ff ff       	call   80104980 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104ac5:	b9 01 00 00 00       	mov    $0x1,%ecx
80104aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(xchg(&lk->locked, 1) != 0)
80104ad0:	8b 55 08             	mov    0x8(%ebp),%edx
80104ad3:	89 c8                	mov    %ecx,%eax
80104ad5:	f0 87 02             	lock xchg %eax,(%edx)
80104ad8:	85 c0                	test   %eax,%eax
80104ada:	75 f4                	jne    80104ad0 <acquire+0x30>
  __sync_synchronize();
80104adc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104ae1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ae4:	e8 57 f0 ff ff       	call   80103b40 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104ae9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80104aec:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104aee:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104af1:	31 c0                	xor    %eax,%eax
80104af3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104afa:	00 
80104afb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b00:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104b06:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b0c:	77 1a                	ja     80104b28 <acquire+0x88>
    pcs[i] = ebp[1];     // saved %eip
80104b0e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104b11:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104b15:	40                   	inc    %eax
80104b16:	83 f8 0a             	cmp    $0xa,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104b19:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104b1b:	75 e3                	jne    80104b00 <acquire+0x60>
}
80104b1d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b20:	89 ec                	mov    %ebp,%esp
80104b22:	5d                   	pop    %ebp
80104b23:	c3                   	ret
80104b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104b28:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80104b2c:	83 c1 34             	add    $0x34,%ecx
80104b2f:	89 ca                	mov    %ecx,%edx
80104b31:	29 c2                	sub    %eax,%edx
80104b33:	f6 c2 04             	test   $0x4,%dl
80104b36:	74 18                	je     80104b50 <acquire+0xb0>
    pcs[i] = 0;
80104b38:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104b3e:	83 c0 04             	add    $0x4,%eax
80104b41:	39 c8                	cmp    %ecx,%eax
80104b43:	74 d8                	je     80104b1d <acquire+0x7d>
80104b45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b4c:	00 
80104b4d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104b50:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104b56:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104b59:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104b60:	39 c8                	cmp    %ecx,%eax
80104b62:	75 ec                	jne    80104b50 <acquire+0xb0>
80104b64:	eb b7                	jmp    80104b1d <acquire+0x7d>
80104b66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b6d:	00 
80104b6e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80104b70:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104b73:	e8 c8 ef ff ff       	call   80103b40 <mycpu>
80104b78:	39 c3                	cmp    %eax,%ebx
80104b7a:	0f 85 40 ff ff ff    	jne    80104ac0 <acquire+0x20>
  popcli();
80104b80:	e8 fb fd ff ff       	call   80104980 <popcli>
    panic("acquire");
80104b85:	c7 04 24 25 7e 10 80 	movl   $0x80107e25,(%esp)
80104b8c:	e8 bf b7 ff ff       	call   80100350 <panic>
80104b91:	66 90                	xchg   %ax,%ax
80104b93:	66 90                	xchg   %ax,%ax
80104b95:	66 90                	xchg   %ax,%ax
80104b97:	66 90                	xchg   %ax,%ax
80104b99:	66 90                	xchg   %ax,%ax
80104b9b:	66 90                	xchg   %ax,%ax
80104b9d:	66 90                	xchg   %ax,%ax
80104b9f:	90                   	nop

80104ba0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	57                   	push   %edi
80104ba4:	8b 55 08             	mov    0x8(%ebp),%edx
80104ba7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104baa:	89 d0                	mov    %edx,%eax
80104bac:	09 c8                	or     %ecx,%eax
80104bae:	a8 03                	test   $0x3,%al
80104bb0:	75 1e                	jne    80104bd0 <memset+0x30>
    c &= 0xFF;
80104bb2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104bb6:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104bb9:	89 d7                	mov    %edx,%edi
80104bbb:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104bc1:	fc                   	cld
80104bc2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104bc4:	5f                   	pop    %edi
80104bc5:	89 d0                	mov    %edx,%eax
80104bc7:	5d                   	pop    %ebp
80104bc8:	c3                   	ret
80104bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104bd0:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bd3:	89 d7                	mov    %edx,%edi
80104bd5:	fc                   	cld
80104bd6:	f3 aa                	rep stos %al,%es:(%edi)
80104bd8:	5f                   	pop    %edi
80104bd9:	89 d0                	mov    %edx,%eax
80104bdb:	5d                   	pop    %ebp
80104bdc:	c3                   	ret
80104bdd:	8d 76 00             	lea    0x0(%esi),%esi

80104be0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	56                   	push   %esi
80104be4:	8b 75 10             	mov    0x10(%ebp),%esi
80104be7:	53                   	push   %ebx
80104be8:	8b 45 08             	mov    0x8(%ebp),%eax
80104beb:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104bee:	85 f6                	test   %esi,%esi
80104bf0:	74 2e                	je     80104c20 <memcmp+0x40>
80104bf2:	01 c6                	add    %eax,%esi
80104bf4:	eb 10                	jmp    80104c06 <memcmp+0x26>
80104bf6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bfd:	00 
80104bfe:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104c00:	40                   	inc    %eax
80104c01:	42                   	inc    %edx
  while(n-- > 0){
80104c02:	39 f0                	cmp    %esi,%eax
80104c04:	74 1a                	je     80104c20 <memcmp+0x40>
    if(*s1 != *s2)
80104c06:	0f b6 08             	movzbl (%eax),%ecx
80104c09:	0f b6 1a             	movzbl (%edx),%ebx
80104c0c:	38 d9                	cmp    %bl,%cl
80104c0e:	74 f0                	je     80104c00 <memcmp+0x20>
      return *s1 - *s2;
80104c10:	0f b6 c1             	movzbl %cl,%eax
80104c13:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104c15:	5b                   	pop    %ebx
80104c16:	5e                   	pop    %esi
80104c17:	5d                   	pop    %ebp
80104c18:	c3                   	ret
80104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c20:	5b                   	pop    %ebx
  return 0;
80104c21:	31 c0                	xor    %eax,%eax
}
80104c23:	5e                   	pop    %esi
80104c24:	5d                   	pop    %ebp
80104c25:	c3                   	ret
80104c26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c2d:	00 
80104c2e:	66 90                	xchg   %ax,%ax

80104c30 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	57                   	push   %edi
80104c34:	8b 55 08             	mov    0x8(%ebp),%edx
80104c37:	56                   	push   %esi
80104c38:	8b 75 0c             	mov    0xc(%ebp),%esi
80104c3b:	8b 45 10             	mov    0x10(%ebp),%eax
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104c3e:	39 d6                	cmp    %edx,%esi
80104c40:	73 26                	jae    80104c68 <memmove+0x38>
80104c42:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104c45:	39 ca                	cmp    %ecx,%edx
80104c47:	73 1f                	jae    80104c68 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104c49:	85 c0                	test   %eax,%eax
80104c4b:	74 0f                	je     80104c5c <memmove+0x2c>
80104c4d:	48                   	dec    %eax
80104c4e:	66 90                	xchg   %ax,%ax
      *--d = *--s;
80104c50:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104c54:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104c57:	83 e8 01             	sub    $0x1,%eax
80104c5a:	73 f4                	jae    80104c50 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104c5c:	5e                   	pop    %esi
80104c5d:	89 d0                	mov    %edx,%eax
80104c5f:	5f                   	pop    %edi
80104c60:	5d                   	pop    %ebp
80104c61:	c3                   	ret
80104c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104c68:	85 c0                	test   %eax,%eax
80104c6a:	89 d7                	mov    %edx,%edi
80104c6c:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104c6f:	74 eb                	je     80104c5c <memmove+0x2c>
80104c71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c78:	00 
80104c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104c80:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104c81:	39 f1                	cmp    %esi,%ecx
80104c83:	75 fb                	jne    80104c80 <memmove+0x50>
}
80104c85:	5e                   	pop    %esi
80104c86:	89 d0                	mov    %edx,%eax
80104c88:	5f                   	pop    %edi
80104c89:	5d                   	pop    %ebp
80104c8a:	c3                   	ret
80104c8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104c90 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104c90:	eb 9e                	jmp    80104c30 <memmove>
80104c92:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c99:	00 
80104c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ca0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	8b 55 10             	mov    0x10(%ebp),%edx
80104ca6:	53                   	push   %ebx
80104ca7:	8b 45 08             	mov    0x8(%ebp),%eax
80104caa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104cad:	85 d2                	test   %edx,%edx
80104caf:	75 11                	jne    80104cc2 <strncmp+0x22>
80104cb1:	eb 25                	jmp    80104cd8 <strncmp+0x38>
80104cb3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cb8:	3a 19                	cmp    (%ecx),%bl
80104cba:	75 0d                	jne    80104cc9 <strncmp+0x29>
    n--, p++, q++;
80104cbc:	40                   	inc    %eax
80104cbd:	41                   	inc    %ecx
  while(n > 0 && *p && *p == *q)
80104cbe:	4a                   	dec    %edx
80104cbf:	90                   	nop
80104cc0:	74 16                	je     80104cd8 <strncmp+0x38>
80104cc2:	0f b6 18             	movzbl (%eax),%ebx
80104cc5:	84 db                	test   %bl,%bl
80104cc7:	75 ef                	jne    80104cb8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104cc9:	0f b6 00             	movzbl (%eax),%eax
80104ccc:	0f b6 11             	movzbl (%ecx),%edx
}
80104ccf:	5b                   	pop    %ebx
80104cd0:	5d                   	pop    %ebp
  return (uchar)*p - (uchar)*q;
80104cd1:	29 d0                	sub    %edx,%eax
}
80104cd3:	c3                   	ret
80104cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cd8:	5b                   	pop    %ebx
    return 0;
80104cd9:	31 c0                	xor    %eax,%eax
}
80104cdb:	5d                   	pop    %ebp
80104cdc:	c3                   	ret
80104cdd:	8d 76 00             	lea    0x0(%esi),%esi

80104ce0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	57                   	push   %edi
80104ce4:	8b 55 10             	mov    0x10(%ebp),%edx
80104ce7:	56                   	push   %esi
80104ce8:	8b 75 08             	mov    0x8(%ebp),%esi
80104ceb:	53                   	push   %ebx
80104cec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104cef:	89 f0                	mov    %esi,%eax
80104cf1:	eb 11                	jmp    80104d04 <strncpy+0x24>
80104cf3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cf8:	0f b6 0f             	movzbl (%edi),%ecx
80104cfb:	47                   	inc    %edi
80104cfc:	40                   	inc    %eax
80104cfd:	88 48 ff             	mov    %cl,-0x1(%eax)
80104d00:	84 c9                	test   %cl,%cl
80104d02:	74 14                	je     80104d18 <strncpy+0x38>
80104d04:	89 d3                	mov    %edx,%ebx
80104d06:	4a                   	dec    %edx
80104d07:	85 db                	test   %ebx,%ebx
80104d09:	7f ed                	jg     80104cf8 <strncpy+0x18>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104d0b:	5b                   	pop    %ebx
80104d0c:	89 f0                	mov    %esi,%eax
80104d0e:	5e                   	pop    %esi
80104d0f:	5f                   	pop    %edi
80104d10:	5d                   	pop    %ebp
80104d11:	c3                   	ret
80104d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(n-- > 0)
80104d18:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104d1b:	49                   	dec    %ecx
80104d1c:	85 d2                	test   %edx,%edx
80104d1e:	74 eb                	je     80104d0b <strncpy+0x2b>
    *s++ = 0;
80104d20:	c6 00 00             	movb   $0x0,(%eax)
80104d23:	40                   	inc    %eax
  while(n-- > 0)
80104d24:	89 ca                	mov    %ecx,%edx
80104d26:	29 c2                	sub    %eax,%edx
80104d28:	85 d2                	test   %edx,%edx
80104d2a:	7f f4                	jg     80104d20 <strncpy+0x40>
}
80104d2c:	5b                   	pop    %ebx
80104d2d:	89 f0                	mov    %esi,%eax
80104d2f:	5e                   	pop    %esi
80104d30:	5f                   	pop    %edi
80104d31:	5d                   	pop    %ebp
80104d32:	c3                   	ret
80104d33:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d3a:	00 
80104d3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104d40 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	56                   	push   %esi
80104d44:	8b 55 10             	mov    0x10(%ebp),%edx
80104d47:	53                   	push   %ebx
80104d48:	8b 75 08             	mov    0x8(%ebp),%esi
80104d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104d4e:	85 d2                	test   %edx,%edx
80104d50:	7e 21                	jle    80104d73 <safestrcpy+0x33>
80104d52:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104d56:	89 f2                	mov    %esi,%edx
80104d58:	eb 12                	jmp    80104d6c <safestrcpy+0x2c>
80104d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104d60:	0f b6 08             	movzbl (%eax),%ecx
80104d63:	40                   	inc    %eax
80104d64:	42                   	inc    %edx
80104d65:	88 4a ff             	mov    %cl,-0x1(%edx)
80104d68:	84 c9                	test   %cl,%cl
80104d6a:	74 04                	je     80104d70 <safestrcpy+0x30>
80104d6c:	39 d8                	cmp    %ebx,%eax
80104d6e:	75 f0                	jne    80104d60 <safestrcpy+0x20>
    ;
  *s = 0;
80104d70:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104d73:	5b                   	pop    %ebx
80104d74:	89 f0                	mov    %esi,%eax
80104d76:	5e                   	pop    %esi
80104d77:	5d                   	pop    %ebp
80104d78:	c3                   	ret
80104d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104d80 <strlen>:

int
strlen(const char *s)
{
80104d80:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104d81:	31 c0                	xor    %eax,%eax
{
80104d83:	89 e5                	mov    %esp,%ebp
80104d85:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104d88:	80 3a 00             	cmpb   $0x0,(%edx)
80104d8b:	74 0a                	je     80104d97 <strlen+0x17>
80104d8d:	8d 76 00             	lea    0x0(%esi),%esi
80104d90:	40                   	inc    %eax
80104d91:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104d95:	75 f9                	jne    80104d90 <strlen+0x10>
    ;
  return n;
}
80104d97:	5d                   	pop    %ebp
80104d98:	c3                   	ret

80104d99 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104d99:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104d9d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104da1:	55                   	push   %ebp
  pushl %ebx
80104da2:	53                   	push   %ebx
  pushl %esi
80104da3:	56                   	push   %esi
  pushl %edi
80104da4:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104da5:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104da7:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104da9:	5f                   	pop    %edi
  popl %esi
80104daa:	5e                   	pop    %esi
  popl %ebx
80104dab:	5b                   	pop    %ebx
  popl %ebp
80104dac:	5d                   	pop    %ebp
  ret
80104dad:	c3                   	ret
80104dae:	66 90                	xchg   %ax,%ax

80104db0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	83 ec 08             	sub    $0x8,%esp
80104db6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80104db9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104dbc:	e8 bf ee ff ff       	call   80103c80 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104dc1:	8b 00                	mov    (%eax),%eax
80104dc3:	39 c3                	cmp    %eax,%ebx
80104dc5:	73 19                	jae    80104de0 <fetchint+0x30>
80104dc7:	8d 53 04             	lea    0x4(%ebx),%edx
80104dca:	39 d0                	cmp    %edx,%eax
80104dcc:	72 12                	jb     80104de0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104dce:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dd1:	8b 13                	mov    (%ebx),%edx
80104dd3:	89 10                	mov    %edx,(%eax)
  return 0;
80104dd5:	31 c0                	xor    %eax,%eax
}
80104dd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104dda:	89 ec                	mov    %ebp,%esp
80104ddc:	5d                   	pop    %ebp
80104ddd:	c3                   	ret
80104dde:	66 90                	xchg   %ax,%ax
    return -1;
80104de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104de5:	eb f0                	jmp    80104dd7 <fetchint+0x27>
80104de7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104dee:	00 
80104def:	90                   	nop

80104df0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	83 ec 08             	sub    $0x8,%esp
80104df6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
80104df9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104dfc:	e8 7f ee ff ff       	call   80103c80 <myproc>

  if(addr >= curproc->sz)
80104e01:	3b 18                	cmp    (%eax),%ebx
80104e03:	73 2b                	jae    80104e30 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104e05:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e08:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104e0a:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104e0c:	39 d3                	cmp    %edx,%ebx
80104e0e:	73 20                	jae    80104e30 <fetchstr+0x40>
80104e10:	89 d8                	mov    %ebx,%eax
80104e12:	eb 09                	jmp    80104e1d <fetchstr+0x2d>
80104e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e18:	40                   	inc    %eax
80104e19:	39 d0                	cmp    %edx,%eax
80104e1b:	73 13                	jae    80104e30 <fetchstr+0x40>
    if(*s == 0)
80104e1d:	80 38 00             	cmpb   $0x0,(%eax)
80104e20:	75 f6                	jne    80104e18 <fetchstr+0x28>
      return s - *pp;
80104e22:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104e24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e27:	89 ec                	mov    %ebp,%esp
80104e29:	5d                   	pop    %ebp
80104e2a:	c3                   	ret
80104e2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e33:	89 ec                	mov    %ebp,%esp
    return -1;
80104e35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e3a:	5d                   	pop    %ebp
80104e3b:	c3                   	ret
80104e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e40 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	56                   	push   %esi
80104e44:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104e45:	e8 36 ee ff ff       	call   80103c80 <myproc>
80104e4a:	8b 55 08             	mov    0x8(%ebp),%edx
80104e4d:	8b 40 18             	mov    0x18(%eax),%eax
80104e50:	8b 40 44             	mov    0x44(%eax),%eax
80104e53:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104e56:	e8 25 ee ff ff       	call   80103c80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104e5b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104e5e:	8b 00                	mov    (%eax),%eax
80104e60:	39 c6                	cmp    %eax,%esi
80104e62:	73 1c                	jae    80104e80 <argint+0x40>
80104e64:	8d 53 08             	lea    0x8(%ebx),%edx
80104e67:	39 d0                	cmp    %edx,%eax
80104e69:	72 15                	jb     80104e80 <argint+0x40>
  *ip = *(int*)(addr);
80104e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e6e:	8b 53 04             	mov    0x4(%ebx),%edx
80104e71:	89 10                	mov    %edx,(%eax)
  return 0;
80104e73:	31 c0                	xor    %eax,%eax
}
80104e75:	5b                   	pop    %ebx
80104e76:	5e                   	pop    %esi
80104e77:	5d                   	pop    %ebp
80104e78:	c3                   	ret
80104e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104e80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104e85:	eb ee                	jmp    80104e75 <argint+0x35>
80104e87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e8e:	00 
80104e8f:	90                   	nop

80104e90 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	83 ec 18             	sub    $0x18,%esp
80104e96:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104e99:	89 75 f8             	mov    %esi,-0x8(%ebp)
80104e9c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  int i;
  struct proc *curproc = myproc();
80104e9f:	e8 dc ed ff ff       	call   80103c80 <myproc>
80104ea4:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ea6:	e8 d5 ed ff ff       	call   80103c80 <myproc>
80104eab:	8b 55 08             	mov    0x8(%ebp),%edx
80104eae:	8b 40 18             	mov    0x18(%eax),%eax
80104eb1:	8b 40 44             	mov    0x44(%eax),%eax
80104eb4:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104eb7:	e8 c4 ed ff ff       	call   80103c80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ebc:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ebf:	8b 00                	mov    (%eax),%eax
80104ec1:	39 c7                	cmp    %eax,%edi
80104ec3:	73 3b                	jae    80104f00 <argptr+0x70>
80104ec5:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104ec8:	39 c8                	cmp    %ecx,%eax
80104eca:	72 34                	jb     80104f00 <argptr+0x70>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104ecc:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104ecf:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104ed2:	85 d2                	test   %edx,%edx
80104ed4:	78 2a                	js     80104f00 <argptr+0x70>
80104ed6:	8b 16                	mov    (%esi),%edx
80104ed8:	39 d0                	cmp    %edx,%eax
80104eda:	73 24                	jae    80104f00 <argptr+0x70>
80104edc:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104edf:	01 c3                	add    %eax,%ebx
80104ee1:	39 da                	cmp    %ebx,%edx
80104ee3:	72 1b                	jb     80104f00 <argptr+0x70>
    return -1;
  *pp = (char*)i;
80104ee5:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ee8:	89 02                	mov    %eax,(%edx)
  return 0;
80104eea:	31 c0                	xor    %eax,%eax
}
80104eec:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104eef:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104ef2:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104ef5:	89 ec                	mov    %ebp,%esp
80104ef7:	5d                   	pop    %ebp
80104ef8:	c3                   	ret
80104ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f05:	eb e5                	jmp    80104eec <argptr+0x5c>
80104f07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f0e:	00 
80104f0f:	90                   	nop

80104f10 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	56                   	push   %esi
80104f14:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f15:	e8 66 ed ff ff       	call   80103c80 <myproc>
80104f1a:	8b 55 08             	mov    0x8(%ebp),%edx
80104f1d:	8b 40 18             	mov    0x18(%eax),%eax
80104f20:	8b 40 44             	mov    0x44(%eax),%eax
80104f23:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104f26:	e8 55 ed ff ff       	call   80103c80 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f2b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f2e:	8b 00                	mov    (%eax),%eax
80104f30:	39 c6                	cmp    %eax,%esi
80104f32:	73 3c                	jae    80104f70 <argstr+0x60>
80104f34:	8d 53 08             	lea    0x8(%ebx),%edx
80104f37:	39 d0                	cmp    %edx,%eax
80104f39:	72 35                	jb     80104f70 <argstr+0x60>
  *ip = *(int*)(addr);
80104f3b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104f3e:	e8 3d ed ff ff       	call   80103c80 <myproc>
  if(addr >= curproc->sz)
80104f43:	3b 18                	cmp    (%eax),%ebx
80104f45:	73 29                	jae    80104f70 <argstr+0x60>
  *pp = (char*)addr;
80104f47:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f4a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104f4c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104f4e:	39 d3                	cmp    %edx,%ebx
80104f50:	73 1e                	jae    80104f70 <argstr+0x60>
80104f52:	89 d8                	mov    %ebx,%eax
80104f54:	eb 0f                	jmp    80104f65 <argstr+0x55>
80104f56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f5d:	00 
80104f5e:	66 90                	xchg   %ax,%ax
80104f60:	40                   	inc    %eax
80104f61:	39 d0                	cmp    %edx,%eax
80104f63:	73 0b                	jae    80104f70 <argstr+0x60>
    if(*s == 0)
80104f65:	80 38 00             	cmpb   $0x0,(%eax)
80104f68:	75 f6                	jne    80104f60 <argstr+0x50>
      return s - *pp;
80104f6a:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104f6c:	5b                   	pop    %ebx
80104f6d:	5e                   	pop    %esi
80104f6e:	5d                   	pop    %ebp
80104f6f:	c3                   	ret
80104f70:	5b                   	pop    %ebx
    return -1;
80104f71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f76:	5e                   	pop    %esi
80104f77:	5d                   	pop    %ebp
80104f78:	c3                   	ret
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f80 <syscall>:
[SYS_getpasize] sys_getpasize,
};

void
syscall(void)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	83 ec 18             	sub    $0x18,%esp
80104f86:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  int num;
  struct proc *curproc = myproc();
80104f89:	e8 f2 ec ff ff       	call   80103c80 <myproc>
80104f8e:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104f90:	8b 40 18             	mov    0x18(%eax),%eax
80104f93:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104f96:	8d 50 ff             	lea    -0x1(%eax),%edx
80104f99:	83 fa 1f             	cmp    $0x1f,%edx
80104f9c:	77 22                	ja     80104fc0 <syscall+0x40>
80104f9e:	8b 14 85 00 84 10 80 	mov    -0x7fef7c00(,%eax,4),%edx
80104fa5:	85 d2                	test   %edx,%edx
80104fa7:	74 17                	je     80104fc0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104fa9:	ff d2                	call   *%edx
80104fab:	89 c2                	mov    %eax,%edx
80104fad:	8b 43 18             	mov    0x18(%ebx),%eax
80104fb0:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104fb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fb6:	89 ec                	mov    %ebp,%esp
80104fb8:	5d                   	pop    %ebp
80104fb9:	c3                   	ret
80104fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104fc0:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80104fc4:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104fc7:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80104fcb:	8b 43 10             	mov    0x10(%ebx),%eax
80104fce:	c7 04 24 2d 7e 10 80 	movl   $0x80107e2d,(%esp)
80104fd5:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fd9:	e8 a2 b6 ff ff       	call   80100680 <cprintf>
    curproc->tf->eax = -1;
80104fde:	8b 43 18             	mov    0x18(%ebx),%eax
80104fe1:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104fe8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104feb:	89 ec                	mov    %ebp,%esp
80104fed:	5d                   	pop    %ebp
80104fee:	c3                   	ret
80104fef:	90                   	nop

80104ff0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ff0:	55                   	push   %ebp
80104ff1:	0f bf d2             	movswl %dx,%edx
80104ff4:	89 e5                	mov    %esp,%ebp
80104ff6:	83 ec 48             	sub    $0x48,%esp
80104ff9:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104ffc:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80105000:	0f bf c9             	movswl %cx,%ecx
80105003:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105006:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105009:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010500c:	89 7d cc             	mov    %edi,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010500f:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105012:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105015:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105019:	89 04 24             	mov    %eax,(%esp)
8010501c:	e8 9f d1 ff ff       	call   801021c0 <nameiparent>
80105021:	85 c0                	test   %eax,%eax
80105023:	74 5b                	je     80105080 <create+0x90>
    return 0;
  ilock(dp);
80105025:	89 04 24             	mov    %eax,(%esp)
80105028:	89 c3                	mov    %eax,%ebx
8010502a:	e8 11 c8 ff ff       	call   80101840 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
8010502f:	31 c9                	xor    %ecx,%ecx
80105031:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80105035:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105039:	89 1c 24             	mov    %ebx,(%esp)
8010503c:	e8 af cd ff ff       	call   80101df0 <dirlookup>
80105041:	85 c0                	test   %eax,%eax
80105043:	89 c6                	mov    %eax,%esi
80105045:	74 51                	je     80105098 <create+0xa8>
    iunlockput(dp);
80105047:	89 1c 24             	mov    %ebx,(%esp)
8010504a:	e8 71 ca ff ff       	call   80101ac0 <iunlockput>
    ilock(ip);
8010504f:	89 34 24             	mov    %esi,(%esp)
80105052:	e8 e9 c7 ff ff       	call   80101840 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105057:	83 7d d4 02          	cmpl   $0x2,-0x2c(%ebp)
8010505b:	75 1b                	jne    80105078 <create+0x88>
8010505d:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105062:	75 14                	jne    80105078 <create+0x88>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105064:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105067:	89 f0                	mov    %esi,%eax
80105069:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010506c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010506f:	89 ec                	mov    %ebp,%esp
80105071:	5d                   	pop    %ebp
80105072:	c3                   	ret
80105073:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105078:	89 34 24             	mov    %esi,(%esp)
8010507b:	e8 40 ca ff ff       	call   80101ac0 <iunlockput>
    return 0;
80105080:	31 f6                	xor    %esi,%esi
}
80105082:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105085:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105088:	89 f0                	mov    %esi,%eax
8010508a:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010508d:	89 ec                	mov    %ebp,%esp
8010508f:	5d                   	pop    %ebp
80105090:	c3                   	ret
80105091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80105098:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010509b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010509f:	8b 03                	mov    (%ebx),%eax
801050a1:	89 04 24             	mov    %eax,(%esp)
801050a4:	e8 17 c6 ff ff       	call   801016c0 <ialloc>
801050a9:	85 c0                	test   %eax,%eax
801050ab:	89 c6                	mov    %eax,%esi
801050ad:	0f 84 ad 00 00 00    	je     80105160 <create+0x170>
  ilock(ip);
801050b3:	89 04 24             	mov    %eax,(%esp)
801050b6:	e8 85 c7 ff ff       	call   80101840 <ilock>
  ip->major = major;
801050bb:	8b 45 d0             	mov    -0x30(%ebp),%eax
  ip->nlink = 1;
801050be:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
801050c4:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801050c8:	8b 45 cc             	mov    -0x34(%ebp),%eax
801050cb:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
801050cf:	89 34 24             	mov    %esi,(%esp)
801050d2:	e8 a9 c6 ff ff       	call   80101780 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801050d7:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
801050db:	74 33                	je     80105110 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801050dd:	8b 46 04             	mov    0x4(%esi),%eax
801050e0:	89 7c 24 04          	mov    %edi,0x4(%esp)
801050e4:	89 1c 24             	mov    %ebx,(%esp)
801050e7:	89 44 24 08          	mov    %eax,0x8(%esp)
801050eb:	e8 d0 cf ff ff       	call   801020c0 <dirlink>
801050f0:	85 c0                	test   %eax,%eax
801050f2:	78 78                	js     8010516c <create+0x17c>
  iunlockput(dp);
801050f4:	89 1c 24             	mov    %ebx,(%esp)
801050f7:	e8 c4 c9 ff ff       	call   80101ac0 <iunlockput>
}
801050fc:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801050ff:	89 f0                	mov    %esi,%eax
80105101:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105104:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105107:	89 ec                	mov    %ebp,%esp
80105109:	5d                   	pop    %ebp
8010510a:	c3                   	ret
8010510b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105110:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80105114:	89 1c 24             	mov    %ebx,(%esp)
80105117:	e8 64 c6 ff ff       	call   80101780 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010511c:	8b 46 04             	mov    0x4(%esi),%eax
8010511f:	ba 65 7e 10 80       	mov    $0x80107e65,%edx
80105124:	89 54 24 04          	mov    %edx,0x4(%esp)
80105128:	89 34 24             	mov    %esi,(%esp)
8010512b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010512f:	e8 8c cf ff ff       	call   801020c0 <dirlink>
80105134:	85 c0                	test   %eax,%eax
80105136:	78 1c                	js     80105154 <create+0x164>
80105138:	8b 43 04             	mov    0x4(%ebx),%eax
8010513b:	89 34 24             	mov    %esi,(%esp)
8010513e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105142:	b8 64 7e 10 80       	mov    $0x80107e64,%eax
80105147:	89 44 24 04          	mov    %eax,0x4(%esp)
8010514b:	e8 70 cf ff ff       	call   801020c0 <dirlink>
80105150:	85 c0                	test   %eax,%eax
80105152:	79 89                	jns    801050dd <create+0xed>
      panic("create dots");
80105154:	c7 04 24 58 7e 10 80 	movl   $0x80107e58,(%esp)
8010515b:	e8 f0 b1 ff ff       	call   80100350 <panic>
    panic("create: ialloc");
80105160:	c7 04 24 49 7e 10 80 	movl   $0x80107e49,(%esp)
80105167:	e8 e4 b1 ff ff       	call   80100350 <panic>
    panic("create: dirlink");
8010516c:	c7 04 24 67 7e 10 80 	movl   $0x80107e67,(%esp)
80105173:	e8 d8 b1 ff ff       	call   80100350 <panic>
80105178:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010517f:	00 

80105180 <sys_worldpeace>:
sys_worldpeace(void) {
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	83 ec 18             	sub    $0x18,%esp
  cprintf("Systems are vital to world peace\n");
80105186:	c7 04 24 80 80 10 80 	movl   $0x80108080,(%esp)
8010518d:	e8 ee b4 ff ff       	call   80100680 <cprintf>
}
80105192:	89 ec                	mov    %ebp,%esp
80105194:	31 c0                	xor    %eax,%eax
80105196:	5d                   	pop    %ebp
80105197:	c3                   	ret
80105198:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010519f:	00 

801051a0 <sys_dup>:
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	56                   	push   %esi
801051a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801051a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801051a8:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801051ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801051af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051b6:	e8 85 fc ff ff       	call   80104e40 <argint>
801051bb:	85 c0                	test   %eax,%eax
801051bd:	78 2f                	js     801051ee <sys_dup+0x4e>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051bf:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051c3:	77 29                	ja     801051ee <sys_dup+0x4e>
801051c5:	e8 b6 ea ff ff       	call   80103c80 <myproc>
801051ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051cd:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801051d1:	85 f6                	test   %esi,%esi
801051d3:	74 19                	je     801051ee <sys_dup+0x4e>
  struct proc *curproc = myproc();
801051d5:	e8 a6 ea ff ff       	call   80103c80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801051da:	31 db                	xor    %ebx,%ebx
801051dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801051e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801051e4:	85 d2                	test   %edx,%edx
801051e6:	74 10                	je     801051f8 <sys_dup+0x58>
  for(fd = 0; fd < NOFILE; fd++){
801051e8:	43                   	inc    %ebx
801051e9:	83 fb 10             	cmp    $0x10,%ebx
801051ec:	75 f2                	jne    801051e0 <sys_dup+0x40>
    return -1;
801051ee:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801051f3:	eb 0f                	jmp    80105204 <sys_dup+0x64>
801051f5:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
801051f8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801051fc:	89 34 24             	mov    %esi,(%esp)
801051ff:	e8 dc bc ff ff       	call   80100ee0 <filedup>
}
80105204:	83 c4 20             	add    $0x20,%esp
80105207:	89 d8                	mov    %ebx,%eax
80105209:	5b                   	pop    %ebx
8010520a:	5e                   	pop    %esi
8010520b:	5d                   	pop    %ebp
8010520c:	c3                   	ret
8010520d:	8d 76 00             	lea    0x0(%esi),%esi

80105210 <sys_read>:
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	56                   	push   %esi
80105214:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105215:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105218:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010521b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010521f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105226:	e8 15 fc ff ff       	call   80104e40 <argint>
8010522b:	85 c0                	test   %eax,%eax
8010522d:	78 69                	js     80105298 <sys_read+0x88>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010522f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105233:	77 63                	ja     80105298 <sys_read+0x88>
80105235:	e8 46 ea ff ff       	call   80103c80 <myproc>
8010523a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010523d:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105241:	85 f6                	test   %esi,%esi
80105243:	74 53                	je     80105298 <sys_read+0x88>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105245:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010524c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010524f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105253:	e8 e8 fb ff ff       	call   80104e40 <argint>
80105258:	85 c0                	test   %eax,%eax
8010525a:	78 3c                	js     80105298 <sys_read+0x88>
8010525c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105260:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105263:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010526a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010526e:	e8 1d fc ff ff       	call   80104e90 <argptr>
80105273:	85 c0                	test   %eax,%eax
80105275:	78 21                	js     80105298 <sys_read+0x88>
  return fileread(f, p, n);
80105277:	89 34 24             	mov    %esi,(%esp)
8010527a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010527d:	89 44 24 08          	mov    %eax,0x8(%esp)
80105281:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105284:	89 44 24 04          	mov    %eax,0x4(%esp)
80105288:	e8 f3 bd ff ff       	call   80101080 <fileread>
}
8010528d:	83 c4 20             	add    $0x20,%esp
80105290:	5b                   	pop    %ebx
80105291:	5e                   	pop    %esi
80105292:	5d                   	pop    %ebp
80105293:	c3                   	ret
80105294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010529d:	eb ee                	jmp    8010528d <sys_read+0x7d>
8010529f:	90                   	nop

801052a0 <sys_write>:
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	56                   	push   %esi
801052a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801052a5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801052a8:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801052ab:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801052af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801052b6:	e8 85 fb ff ff       	call   80104e40 <argint>
801052bb:	85 c0                	test   %eax,%eax
801052bd:	78 69                	js     80105328 <sys_write+0x88>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801052bf:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801052c3:	77 63                	ja     80105328 <sys_write+0x88>
801052c5:	e8 b6 e9 ff ff       	call   80103c80 <myproc>
801052ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
801052cd:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801052d1:	85 f6                	test   %esi,%esi
801052d3:	74 53                	je     80105328 <sys_write+0x88>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801052d5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801052dc:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052df:	89 44 24 04          	mov    %eax,0x4(%esp)
801052e3:	e8 58 fb ff ff       	call   80104e40 <argint>
801052e8:	85 c0                	test   %eax,%eax
801052ea:	78 3c                	js     80105328 <sys_write+0x88>
801052ec:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801052f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801052fa:	89 44 24 08          	mov    %eax,0x8(%esp)
801052fe:	e8 8d fb ff ff       	call   80104e90 <argptr>
80105303:	85 c0                	test   %eax,%eax
80105305:	78 21                	js     80105328 <sys_write+0x88>
  return filewrite(f, p, n);
80105307:	89 34 24             	mov    %esi,(%esp)
8010530a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010530d:	89 44 24 08          	mov    %eax,0x8(%esp)
80105311:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105314:	89 44 24 04          	mov    %eax,0x4(%esp)
80105318:	e8 13 be ff ff       	call   80101130 <filewrite>
}
8010531d:	83 c4 20             	add    $0x20,%esp
80105320:	5b                   	pop    %ebx
80105321:	5e                   	pop    %esi
80105322:	5d                   	pop    %ebp
80105323:	c3                   	ret
80105324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105328:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010532d:	eb ee                	jmp    8010531d <sys_write+0x7d>
8010532f:	90                   	nop

80105330 <sys_close>:
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	56                   	push   %esi
80105334:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105335:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105338:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010533b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010533f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105346:	e8 f5 fa ff ff       	call   80104e40 <argint>
8010534b:	85 c0                	test   %eax,%eax
8010534d:	78 39                	js     80105388 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010534f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105353:	77 33                	ja     80105388 <sys_close+0x58>
80105355:	e8 26 e9 ff ff       	call   80103c80 <myproc>
8010535a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010535d:	8d 5a 08             	lea    0x8(%edx),%ebx
80105360:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105364:	85 f6                	test   %esi,%esi
80105366:	74 20                	je     80105388 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105368:	e8 13 e9 ff ff       	call   80103c80 <myproc>
8010536d:	31 d2                	xor    %edx,%edx
8010536f:	89 54 98 08          	mov    %edx,0x8(%eax,%ebx,4)
  fileclose(f);
80105373:	89 34 24             	mov    %esi,(%esp)
80105376:	e8 b5 bb ff ff       	call   80100f30 <fileclose>
  return 0;
8010537b:	31 c0                	xor    %eax,%eax
}
8010537d:	83 c4 20             	add    $0x20,%esp
80105380:	5b                   	pop    %ebx
80105381:	5e                   	pop    %esi
80105382:	5d                   	pop    %ebp
80105383:	c3                   	ret
80105384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105388:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010538d:	eb ee                	jmp    8010537d <sys_close+0x4d>
8010538f:	90                   	nop

80105390 <sys_fstat>:
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	56                   	push   %esi
80105394:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105395:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105398:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010539b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010539f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053a6:	e8 95 fa ff ff       	call   80104e40 <argint>
801053ab:	85 c0                	test   %eax,%eax
801053ad:	78 51                	js     80105400 <sys_fstat+0x70>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801053af:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801053b3:	77 4b                	ja     80105400 <sys_fstat+0x70>
801053b5:	e8 c6 e8 ff ff       	call   80103c80 <myproc>
801053ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053bd:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801053c1:	85 f6                	test   %esi,%esi
801053c3:	74 3b                	je     80105400 <sys_fstat+0x70>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801053c5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801053c9:	b8 14 00 00 00       	mov    $0x14,%eax
801053ce:	89 44 24 08          	mov    %eax,0x8(%esp)
801053d2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801053d9:	e8 b2 fa ff ff       	call   80104e90 <argptr>
801053de:	85 c0                	test   %eax,%eax
801053e0:	78 1e                	js     80105400 <sys_fstat+0x70>
  return filestat(f, st);
801053e2:	89 34 24             	mov    %esi,(%esp)
801053e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053e8:	89 44 24 04          	mov    %eax,0x4(%esp)
801053ec:	e8 2f bc ff ff       	call   80101020 <filestat>
}
801053f1:	83 c4 20             	add    $0x20,%esp
801053f4:	5b                   	pop    %ebx
801053f5:	5e                   	pop    %esi
801053f6:	5d                   	pop    %ebp
801053f7:	c3                   	ret
801053f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053ff:	00 
    return -1;
80105400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105405:	eb ea                	jmp    801053f1 <sys_fstat+0x61>
80105407:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010540e:	00 
8010540f:	90                   	nop

80105410 <sys_link>:
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	57                   	push   %edi
80105414:	56                   	push   %esi
80105415:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105416:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105419:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010541c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105420:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105427:	e8 e4 fa ff ff       	call   80104f10 <argstr>
8010542c:	85 c0                	test   %eax,%eax
8010542e:	0f 88 e5 00 00 00    	js     80105519 <sys_link+0x109>
80105434:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010543b:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010543e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105442:	e8 c9 fa ff ff       	call   80104f10 <argstr>
80105447:	85 c0                	test   %eax,%eax
80105449:	0f 88 ca 00 00 00    	js     80105519 <sys_link+0x109>
  begin_op();
8010544f:	e8 fc d9 ff ff       	call   80102e50 <begin_op>
  if((ip = namei(old)) == 0){
80105454:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80105457:	89 04 24             	mov    %eax,(%esp)
8010545a:	e8 41 cd ff ff       	call   801021a0 <namei>
8010545f:	85 c0                	test   %eax,%eax
80105461:	89 c3                	mov    %eax,%ebx
80105463:	0f 84 b7 00 00 00    	je     80105520 <sys_link+0x110>
  ilock(ip);
80105469:	89 04 24             	mov    %eax,(%esp)
8010546c:	e8 cf c3 ff ff       	call   80101840 <ilock>
  if(ip->type == T_DIR){
80105471:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105476:	0f 84 90 00 00 00    	je     8010550c <sys_link+0xfc>
  ip->nlink++;
8010547c:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105480:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105483:	89 1c 24             	mov    %ebx,(%esp)
80105486:	e8 f5 c2 ff ff       	call   80101780 <iupdate>
  iunlock(ip);
8010548b:	89 1c 24             	mov    %ebx,(%esp)
8010548e:	e8 8d c4 ff ff       	call   80101920 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105493:	8b 45 d0             	mov    -0x30(%ebp),%eax
80105496:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010549a:	89 04 24             	mov    %eax,(%esp)
8010549d:	e8 1e cd ff ff       	call   801021c0 <nameiparent>
801054a2:	85 c0                	test   %eax,%eax
801054a4:	89 c6                	mov    %eax,%esi
801054a6:	74 50                	je     801054f8 <sys_link+0xe8>
  ilock(dp);
801054a8:	89 04 24             	mov    %eax,(%esp)
801054ab:	e8 90 c3 ff ff       	call   80101840 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801054b0:	8b 03                	mov    (%ebx),%eax
801054b2:	39 06                	cmp    %eax,(%esi)
801054b4:	75 3a                	jne    801054f0 <sys_link+0xe0>
801054b6:	8b 43 04             	mov    0x4(%ebx),%eax
801054b9:	89 7c 24 04          	mov    %edi,0x4(%esp)
801054bd:	89 34 24             	mov    %esi,(%esp)
801054c0:	89 44 24 08          	mov    %eax,0x8(%esp)
801054c4:	e8 f7 cb ff ff       	call   801020c0 <dirlink>
801054c9:	85 c0                	test   %eax,%eax
801054cb:	78 23                	js     801054f0 <sys_link+0xe0>
  iunlockput(dp);
801054cd:	89 34 24             	mov    %esi,(%esp)
801054d0:	e8 eb c5 ff ff       	call   80101ac0 <iunlockput>
  iput(ip);
801054d5:	89 1c 24             	mov    %ebx,(%esp)
801054d8:	e8 93 c4 ff ff       	call   80101970 <iput>
  end_op();
801054dd:	e8 de d9 ff ff       	call   80102ec0 <end_op>
  return 0;
801054e2:	31 c0                	xor    %eax,%eax
}
801054e4:	83 c4 3c             	add    $0x3c,%esp
801054e7:	5b                   	pop    %ebx
801054e8:	5e                   	pop    %esi
801054e9:	5f                   	pop    %edi
801054ea:	5d                   	pop    %ebp
801054eb:	c3                   	ret
801054ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
801054f0:	89 34 24             	mov    %esi,(%esp)
801054f3:	e8 c8 c5 ff ff       	call   80101ac0 <iunlockput>
  ilock(ip);
801054f8:	89 1c 24             	mov    %ebx,(%esp)
801054fb:	e8 40 c3 ff ff       	call   80101840 <ilock>
  ip->nlink--;
80105500:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80105504:	89 1c 24             	mov    %ebx,(%esp)
80105507:	e8 74 c2 ff ff       	call   80101780 <iupdate>
  iunlockput(ip);
8010550c:	89 1c 24             	mov    %ebx,(%esp)
8010550f:	e8 ac c5 ff ff       	call   80101ac0 <iunlockput>
  end_op();
80105514:	e8 a7 d9 ff ff       	call   80102ec0 <end_op>
    return -1;
80105519:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010551e:	eb c4                	jmp    801054e4 <sys_link+0xd4>
    end_op();
80105520:	e8 9b d9 ff ff       	call   80102ec0 <end_op>
    return -1;
80105525:	eb f2                	jmp    80105519 <sys_link+0x109>
80105527:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010552e:	00 
8010552f:	90                   	nop

80105530 <sys_unlink>:
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	57                   	push   %edi
80105534:	56                   	push   %esi
80105535:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105536:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105539:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
8010553c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105540:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105547:	e8 c4 f9 ff ff       	call   80104f10 <argstr>
8010554c:	85 c0                	test   %eax,%eax
8010554e:	0f 88 7c 01 00 00    	js     801056d0 <sys_unlink+0x1a0>
  begin_op();
80105554:	e8 f7 d8 ff ff       	call   80102e50 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105559:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010555c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010555f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105563:	89 04 24             	mov    %eax,(%esp)
80105566:	e8 55 cc ff ff       	call   801021c0 <nameiparent>
8010556b:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010556e:	85 c0                	test   %eax,%eax
80105570:	0f 84 7e 01 00 00    	je     801056f4 <sys_unlink+0x1c4>
  ilock(dp);
80105576:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105579:	89 3c 24             	mov    %edi,(%esp)
8010557c:	e8 bf c2 ff ff       	call   80101840 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105581:	b8 65 7e 10 80       	mov    $0x80107e65,%eax
80105586:	89 44 24 04          	mov    %eax,0x4(%esp)
8010558a:	89 1c 24             	mov    %ebx,(%esp)
8010558d:	e8 2e c8 ff ff       	call   80101dc0 <namecmp>
80105592:	85 c0                	test   %eax,%eax
80105594:	0f 84 26 01 00 00    	je     801056c0 <sys_unlink+0x190>
8010559a:	89 1c 24             	mov    %ebx,(%esp)
8010559d:	b8 64 7e 10 80       	mov    $0x80107e64,%eax
801055a2:	89 44 24 04          	mov    %eax,0x4(%esp)
801055a6:	e8 15 c8 ff ff       	call   80101dc0 <namecmp>
801055ab:	85 c0                	test   %eax,%eax
801055ad:	0f 84 0d 01 00 00    	je     801056c0 <sys_unlink+0x190>
  if((ip = dirlookup(dp, name, &off)) == 0)
801055b3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801055b7:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801055ba:	89 44 24 08          	mov    %eax,0x8(%esp)
801055be:	89 3c 24             	mov    %edi,(%esp)
801055c1:	e8 2a c8 ff ff       	call   80101df0 <dirlookup>
801055c6:	85 c0                	test   %eax,%eax
801055c8:	89 c3                	mov    %eax,%ebx
801055ca:	0f 84 f0 00 00 00    	je     801056c0 <sys_unlink+0x190>
  ilock(ip);
801055d0:	89 04 24             	mov    %eax,(%esp)
801055d3:	e8 68 c2 ff ff       	call   80101840 <ilock>
  if(ip->nlink < 1)
801055d8:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801055dd:	0f 8e 2b 01 00 00    	jle    8010570e <sys_unlink+0x1de>
  if(ip->type == T_DIR && !isdirempty(ip)){
801055e3:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055e8:	8d 7d d8             	lea    -0x28(%ebp),%edi
801055eb:	74 7b                	je     80105668 <sys_unlink+0x138>
  memset(&de, 0, sizeof(de));
801055ed:	89 3c 24             	mov    %edi,(%esp)
801055f0:	31 d2                	xor    %edx,%edx
801055f2:	b8 10 00 00 00       	mov    $0x10,%eax
801055f7:	89 54 24 04          	mov    %edx,0x4(%esp)
801055fb:	89 44 24 08          	mov    %eax,0x8(%esp)
801055ff:	e8 9c f5 ff ff       	call   80104ba0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105604:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105607:	b9 10 00 00 00       	mov    $0x10,%ecx
8010560c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80105610:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105614:	89 44 24 08          	mov    %eax,0x8(%esp)
80105618:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010561b:	89 04 24             	mov    %eax,(%esp)
8010561e:	e8 4d c6 ff ff       	call   80101c70 <writei>
80105623:	83 f8 10             	cmp    $0x10,%eax
80105626:	0f 85 ee 00 00 00    	jne    8010571a <sys_unlink+0x1ea>
  if(ip->type == T_DIR){
8010562c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105631:	0f 84 a9 00 00 00    	je     801056e0 <sys_unlink+0x1b0>
  iunlockput(dp);
80105637:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010563a:	89 04 24             	mov    %eax,(%esp)
8010563d:	e8 7e c4 ff ff       	call   80101ac0 <iunlockput>
  ip->nlink--;
80105642:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80105646:	89 1c 24             	mov    %ebx,(%esp)
80105649:	e8 32 c1 ff ff       	call   80101780 <iupdate>
  iunlockput(ip);
8010564e:	89 1c 24             	mov    %ebx,(%esp)
80105651:	e8 6a c4 ff ff       	call   80101ac0 <iunlockput>
  end_op();
80105656:	e8 65 d8 ff ff       	call   80102ec0 <end_op>
  return 0;
8010565b:	31 c0                	xor    %eax,%eax
}
8010565d:	83 c4 5c             	add    $0x5c,%esp
80105660:	5b                   	pop    %ebx
80105661:	5e                   	pop    %esi
80105662:	5f                   	pop    %edi
80105663:	5d                   	pop    %ebp
80105664:	c3                   	ret
80105665:	8d 76 00             	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105668:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
8010566c:	0f 86 7b ff ff ff    	jbe    801055ed <sys_unlink+0xbd>
80105672:	be 20 00 00 00       	mov    $0x20,%esi
80105677:	eb 13                	jmp    8010568c <sys_unlink+0x15c>
80105679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105680:	83 c6 10             	add    $0x10,%esi
80105683:	3b 73 58             	cmp    0x58(%ebx),%esi
80105686:	0f 83 61 ff ff ff    	jae    801055ed <sys_unlink+0xbd>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010568c:	89 74 24 08          	mov    %esi,0x8(%esp)
80105690:	b8 10 00 00 00       	mov    $0x10,%eax
80105695:	89 44 24 0c          	mov    %eax,0xc(%esp)
80105699:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010569d:	89 1c 24             	mov    %ebx,(%esp)
801056a0:	e8 9b c4 ff ff       	call   80101b40 <readi>
801056a5:	83 f8 10             	cmp    $0x10,%eax
801056a8:	75 58                	jne    80105702 <sys_unlink+0x1d2>
    if(de.inum != 0)
801056aa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801056af:	74 cf                	je     80105680 <sys_unlink+0x150>
    iunlockput(ip);
801056b1:	89 1c 24             	mov    %ebx,(%esp)
801056b4:	e8 07 c4 ff ff       	call   80101ac0 <iunlockput>
    goto bad;
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
801056c0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801056c3:	89 04 24             	mov    %eax,(%esp)
801056c6:	e8 f5 c3 ff ff       	call   80101ac0 <iunlockput>
  end_op();
801056cb:	e8 f0 d7 ff ff       	call   80102ec0 <end_op>
    return -1;
801056d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d5:	eb 86                	jmp    8010565d <sys_unlink+0x12d>
801056d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801056de:	00 
801056df:	90                   	nop
    dp->nlink--;
801056e0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801056e3:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
801056e7:	89 04 24             	mov    %eax,(%esp)
801056ea:	e8 91 c0 ff ff       	call   80101780 <iupdate>
801056ef:	e9 43 ff ff ff       	jmp    80105637 <sys_unlink+0x107>
    end_op();
801056f4:	e8 c7 d7 ff ff       	call   80102ec0 <end_op>
    return -1;
801056f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105700:	eb ce                	jmp    801056d0 <sys_unlink+0x1a0>
      panic("isdirempty: readi");
80105702:	c7 04 24 89 7e 10 80 	movl   $0x80107e89,(%esp)
80105709:	e8 42 ac ff ff       	call   80100350 <panic>
    panic("unlink: nlink < 1");
8010570e:	c7 04 24 77 7e 10 80 	movl   $0x80107e77,(%esp)
80105715:	e8 36 ac ff ff       	call   80100350 <panic>
    panic("unlink: writei");
8010571a:	c7 04 24 9b 7e 10 80 	movl   $0x80107e9b,(%esp)
80105721:	e8 2a ac ff ff       	call   80100350 <panic>
80105726:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010572d:	00 
8010572e:	66 90                	xchg   %ax,%ax

80105730 <sys_open>:

int
sys_open(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	57                   	push   %edi
80105734:	56                   	push   %esi
80105735:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105736:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105739:	83 ec 2c             	sub    $0x2c,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010573c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105740:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105747:	e8 c4 f7 ff ff       	call   80104f10 <argstr>
8010574c:	85 c0                	test   %eax,%eax
8010574e:	0f 88 7f 00 00 00    	js     801057d3 <sys_open+0xa3>
80105754:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010575b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010575e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105762:	e8 d9 f6 ff ff       	call   80104e40 <argint>
80105767:	85 c0                	test   %eax,%eax
80105769:	78 68                	js     801057d3 <sys_open+0xa3>
    return -1;

  begin_op();
8010576b:	e8 e0 d6 ff ff       	call   80102e50 <begin_op>

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105770:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(omode & O_CREATE){
80105773:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105777:	75 6f                	jne    801057e8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105779:	89 04 24             	mov    %eax,(%esp)
8010577c:	e8 1f ca ff ff       	call   801021a0 <namei>
80105781:	85 c0                	test   %eax,%eax
80105783:	89 c6                	mov    %eax,%esi
80105785:	74 7a                	je     80105801 <sys_open+0xd1>
      end_op();
      return -1;
    }
    ilock(ip);
80105787:	89 04 24             	mov    %eax,(%esp)
8010578a:	e8 b1 c0 ff ff       	call   80101840 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010578f:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105794:	0f 84 b6 00 00 00    	je     80105850 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010579a:	e8 d1 b6 ff ff       	call   80100e70 <filealloc>
8010579f:	85 c0                	test   %eax,%eax
801057a1:	89 c7                	mov    %eax,%edi
801057a3:	74 21                	je     801057c6 <sys_open+0x96>
  struct proc *curproc = myproc();
801057a5:	e8 d6 e4 ff ff       	call   80103c80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801057aa:	31 db                	xor    %ebx,%ebx
801057ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801057b0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801057b4:	85 d2                	test   %edx,%edx
801057b6:	74 58                	je     80105810 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
801057b8:	43                   	inc    %ebx
801057b9:	83 fb 10             	cmp    $0x10,%ebx
801057bc:	75 f2                	jne    801057b0 <sys_open+0x80>
    if(f)
      fileclose(f);
801057be:	89 3c 24             	mov    %edi,(%esp)
801057c1:	e8 6a b7 ff ff       	call   80100f30 <fileclose>
    iunlockput(ip);
801057c6:	89 34 24             	mov    %esi,(%esp)
801057c9:	e8 f2 c2 ff ff       	call   80101ac0 <iunlockput>
    end_op();
801057ce:	e8 ed d6 ff ff       	call   80102ec0 <end_op>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801057d3:	83 c4 2c             	add    $0x2c,%esp
    return -1;
801057d6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801057db:	89 d8                	mov    %ebx,%eax
801057dd:	5b                   	pop    %ebx
801057de:	5e                   	pop    %esi
801057df:	5f                   	pop    %edi
801057e0:	5d                   	pop    %ebp
801057e1:	c3                   	ret
801057e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ip = create(path, T_FILE, 0, 0);
801057e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801057ef:	31 c9                	xor    %ecx,%ecx
801057f1:	ba 02 00 00 00       	mov    $0x2,%edx
801057f6:	e8 f5 f7 ff ff       	call   80104ff0 <create>
    if(ip == 0){
801057fb:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801057fd:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801057ff:	75 99                	jne    8010579a <sys_open+0x6a>
      end_op();
80105801:	e8 ba d6 ff ff       	call   80102ec0 <end_op>
      return -1;
80105806:	eb cb                	jmp    801057d3 <sys_open+0xa3>
80105808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010580f:	00 
      curproc->ofile[fd] = f;
80105810:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105814:	89 34 24             	mov    %esi,(%esp)
80105817:	e8 04 c1 ff ff       	call   80101920 <iunlock>
  end_op();
8010581c:	e8 9f d6 ff ff       	call   80102ec0 <end_op>
  f->type = FD_INODE;
80105821:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
80105827:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
8010582a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->off = 0;
8010582d:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105834:	89 d0                	mov    %edx,%eax
80105836:	f7 d0                	not    %eax
80105838:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010583b:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
8010583e:	88 47 08             	mov    %al,0x8(%edi)
}
80105841:	89 d8                	mov    %ebx,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105843:	0f 95 47 09          	setne  0x9(%edi)
}
80105847:	83 c4 2c             	add    $0x2c,%esp
8010584a:	5b                   	pop    %ebx
8010584b:	5e                   	pop    %esi
8010584c:	5f                   	pop    %edi
8010584d:	5d                   	pop    %ebp
8010584e:	c3                   	ret
8010584f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105850:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105853:	85 c9                	test   %ecx,%ecx
80105855:	0f 84 3f ff ff ff    	je     8010579a <sys_open+0x6a>
8010585b:	e9 66 ff ff ff       	jmp    801057c6 <sys_open+0x96>

80105860 <sys_mkdir>:

int
sys_mkdir(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105866:	e8 e5 d5 ff ff       	call   80102e50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010586b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010586e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105872:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105879:	e8 92 f6 ff ff       	call   80104f10 <argstr>
8010587e:	85 c0                	test   %eax,%eax
80105880:	78 2e                	js     801058b0 <sys_mkdir+0x50>
80105882:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105889:	31 c9                	xor    %ecx,%ecx
8010588b:	ba 01 00 00 00       	mov    $0x1,%edx
80105890:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105893:	e8 58 f7 ff ff       	call   80104ff0 <create>
80105898:	85 c0                	test   %eax,%eax
8010589a:	74 14                	je     801058b0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010589c:	89 04 24             	mov    %eax,(%esp)
8010589f:	e8 1c c2 ff ff       	call   80101ac0 <iunlockput>
  end_op();
801058a4:	e8 17 d6 ff ff       	call   80102ec0 <end_op>
  return 0;
801058a9:	31 c0                	xor    %eax,%eax
}
801058ab:	89 ec                	mov    %ebp,%esp
801058ad:	5d                   	pop    %ebp
801058ae:	c3                   	ret
801058af:	90                   	nop
    end_op();
801058b0:	e8 0b d6 ff ff       	call   80102ec0 <end_op>
    return -1;
801058b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ba:	eb ef                	jmp    801058ab <sys_mkdir+0x4b>
801058bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058c0 <sys_mknod>:

int
sys_mknod(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801058c6:	e8 85 d5 ff ff       	call   80102e50 <begin_op>
  if((argstr(0, &path)) < 0 ||
801058cb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801058ce:	89 44 24 04          	mov    %eax,0x4(%esp)
801058d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058d9:	e8 32 f6 ff ff       	call   80104f10 <argstr>
801058de:	85 c0                	test   %eax,%eax
801058e0:	78 5e                	js     80105940 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801058e2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801058e9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058ec:	89 44 24 04          	mov    %eax,0x4(%esp)
801058f0:	e8 4b f5 ff ff       	call   80104e40 <argint>
  if((argstr(0, &path)) < 0 ||
801058f5:	85 c0                	test   %eax,%eax
801058f7:	78 47                	js     80105940 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801058f9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105900:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105903:	89 44 24 04          	mov    %eax,0x4(%esp)
80105907:	e8 34 f5 ff ff       	call   80104e40 <argint>
     argint(1, &major) < 0 ||
8010590c:	85 c0                	test   %eax,%eax
8010590e:	78 30                	js     80105940 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105910:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105914:	ba 03 00 00 00       	mov    $0x3,%edx
80105919:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010591d:	89 04 24             	mov    %eax,(%esp)
80105920:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105923:	e8 c8 f6 ff ff       	call   80104ff0 <create>
     argint(2, &minor) < 0 ||
80105928:	85 c0                	test   %eax,%eax
8010592a:	74 14                	je     80105940 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010592c:	89 04 24             	mov    %eax,(%esp)
8010592f:	e8 8c c1 ff ff       	call   80101ac0 <iunlockput>
  end_op();
80105934:	e8 87 d5 ff ff       	call   80102ec0 <end_op>
  return 0;
80105939:	31 c0                	xor    %eax,%eax
}
8010593b:	89 ec                	mov    %ebp,%esp
8010593d:	5d                   	pop    %ebp
8010593e:	c3                   	ret
8010593f:	90                   	nop
    end_op();
80105940:	e8 7b d5 ff ff       	call   80102ec0 <end_op>
    return -1;
80105945:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594a:	eb ef                	jmp    8010593b <sys_mknod+0x7b>
8010594c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105950 <sys_chdir>:

int
sys_chdir(void)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	56                   	push   %esi
80105954:	53                   	push   %ebx
80105955:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105958:	e8 23 e3 ff ff       	call   80103c80 <myproc>
8010595d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010595f:	e8 ec d4 ff ff       	call   80102e50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105964:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105967:	89 44 24 04          	mov    %eax,0x4(%esp)
8010596b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105972:	e8 99 f5 ff ff       	call   80104f10 <argstr>
80105977:	85 c0                	test   %eax,%eax
80105979:	78 4a                	js     801059c5 <sys_chdir+0x75>
8010597b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010597e:	89 04 24             	mov    %eax,(%esp)
80105981:	e8 1a c8 ff ff       	call   801021a0 <namei>
80105986:	85 c0                	test   %eax,%eax
80105988:	89 c3                	mov    %eax,%ebx
8010598a:	74 39                	je     801059c5 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010598c:	89 04 24             	mov    %eax,(%esp)
8010598f:	e8 ac be ff ff       	call   80101840 <ilock>
  if(ip->type != T_DIR){
80105994:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80105999:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
8010599c:	75 22                	jne    801059c0 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010599e:	e8 7d bf ff ff       	call   80101920 <iunlock>
  iput(curproc->cwd);
801059a3:	8b 46 68             	mov    0x68(%esi),%eax
801059a6:	89 04 24             	mov    %eax,(%esp)
801059a9:	e8 c2 bf ff ff       	call   80101970 <iput>
  end_op();
801059ae:	e8 0d d5 ff ff       	call   80102ec0 <end_op>
  curproc->cwd = ip;
  return 0;
801059b3:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
801059b5:	89 5e 68             	mov    %ebx,0x68(%esi)
}
801059b8:	83 c4 20             	add    $0x20,%esp
801059bb:	5b                   	pop    %ebx
801059bc:	5e                   	pop    %esi
801059bd:	5d                   	pop    %ebp
801059be:	c3                   	ret
801059bf:	90                   	nop
    iunlockput(ip);
801059c0:	e8 fb c0 ff ff       	call   80101ac0 <iunlockput>
    end_op();
801059c5:	e8 f6 d4 ff ff       	call   80102ec0 <end_op>
    return -1;
801059ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059cf:	eb e7                	jmp    801059b8 <sys_chdir+0x68>
801059d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059d8:	00 
801059d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801059e0 <sys_exec>:

int
sys_exec(void)
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
801059e3:	57                   	push   %edi
801059e4:	56                   	push   %esi
801059e5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801059e6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801059ec:	81 ec ac 00 00 00    	sub    $0xac,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801059f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801059f6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801059fd:	e8 0e f5 ff ff       	call   80104f10 <argstr>
80105a02:	85 c0                	test   %eax,%eax
80105a04:	0f 88 8e 00 00 00    	js     80105a98 <sys_exec+0xb8>
80105a0a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105a11:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105a17:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a1b:	e8 20 f4 ff ff       	call   80104e40 <argint>
80105a20:	85 c0                	test   %eax,%eax
80105a22:	78 74                	js     80105a98 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105a24:	ba 80 00 00 00       	mov    $0x80,%edx
80105a29:	31 c9                	xor    %ecx,%ecx
80105a2b:	89 54 24 08          	mov    %edx,0x8(%esp)
80105a2f:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105a35:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105a37:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80105a3b:	89 34 24             	mov    %esi,(%esp)
80105a3e:	e8 5d f1 ff ff       	call   80104ba0 <memset>
    if(i >= NELEM(argv))
80105a43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a4a:	00 
80105a4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105a50:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105a56:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a5a:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105a60:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105a67:	01 f8                	add    %edi,%eax
80105a69:	89 04 24             	mov    %eax,(%esp)
80105a6c:	e8 3f f3 ff ff       	call   80104db0 <fetchint>
80105a71:	85 c0                	test   %eax,%eax
80105a73:	78 23                	js     80105a98 <sys_exec+0xb8>
      return -1;
    if(uarg == 0){
80105a75:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105a7b:	85 c0                	test   %eax,%eax
80105a7d:	74 31                	je     80105ab0 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105a7f:	89 04 24             	mov    %eax,(%esp)
80105a82:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105a85:	89 54 24 04          	mov    %edx,0x4(%esp)
80105a89:	e8 62 f3 ff ff       	call   80104df0 <fetchstr>
80105a8e:	85 c0                	test   %eax,%eax
80105a90:	78 06                	js     80105a98 <sys_exec+0xb8>
  for(i=0;; i++){
80105a92:	43                   	inc    %ebx
    if(i >= NELEM(argv))
80105a93:	83 fb 20             	cmp    $0x20,%ebx
80105a96:	75 b8                	jne    80105a50 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
80105a98:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
80105a9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105aa3:	5b                   	pop    %ebx
80105aa4:	5e                   	pop    %esi
80105aa5:	5f                   	pop    %edi
80105aa6:	5d                   	pop    %ebp
80105aa7:	c3                   	ret
80105aa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105aaf:	00 
      argv[i] = 0;
80105ab0:	31 c0                	xor    %eax,%eax
80105ab2:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
80105ab9:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80105abf:	89 74 24 04          	mov    %esi,0x4(%esp)
80105ac3:	89 04 24             	mov    %eax,(%esp)
80105ac6:	e8 e5 af ff ff       	call   80100ab0 <exec>
}
80105acb:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105ad1:	5b                   	pop    %ebx
80105ad2:	5e                   	pop    %esi
80105ad3:	5f                   	pop    %edi
80105ad4:	5d                   	pop    %ebp
80105ad5:	c3                   	ret
80105ad6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105add:	00 
80105ade:	66 90                	xchg   %ax,%ax

80105ae0 <sys_pipe>:

int
sys_pipe(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105ae4:	bf 08 00 00 00       	mov    $0x8,%edi
{
80105ae9:	56                   	push   %esi
80105aea:	53                   	push   %ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105aeb:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105aee:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105af1:	89 7c 24 08          	mov    %edi,0x8(%esp)
80105af5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105af9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105b00:	e8 8b f3 ff ff       	call   80104e90 <argptr>
80105b05:	85 c0                	test   %eax,%eax
80105b07:	0f 88 82 00 00 00    	js     80105b8f <sys_pipe+0xaf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105b0d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b10:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b14:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105b17:	89 04 24             	mov    %eax,(%esp)
80105b1a:	e8 b1 d9 ff ff       	call   801034d0 <pipealloc>
80105b1f:	85 c0                	test   %eax,%eax
80105b21:	78 6c                	js     80105b8f <sys_pipe+0xaf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105b23:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105b26:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105b28:	e8 53 e1 ff ff       	call   80103c80 <myproc>
    if(curproc->ofile[fd] == 0){
80105b2d:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105b31:	85 f6                	test   %esi,%esi
80105b33:	74 19                	je     80105b4e <sys_pipe+0x6e>
80105b35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b3c:	00 
80105b3d:	8d 76 00             	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105b40:	43                   	inc    %ebx
80105b41:	83 fb 10             	cmp    $0x10,%ebx
80105b44:	74 33                	je     80105b79 <sys_pipe+0x99>
    if(curproc->ofile[fd] == 0){
80105b46:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105b4a:	85 f6                	test   %esi,%esi
80105b4c:	75 f2                	jne    80105b40 <sys_pipe+0x60>
      curproc->ofile[fd] = f;
80105b4e:	8d 73 08             	lea    0x8(%ebx),%esi
80105b51:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105b55:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105b58:	e8 23 e1 ff ff       	call   80103c80 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105b5d:	31 d2                	xor    %edx,%edx
80105b5f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105b60:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105b64:	85 c9                	test   %ecx,%ecx
80105b66:	74 38                	je     80105ba0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80105b68:	42                   	inc    %edx
80105b69:	83 fa 10             	cmp    $0x10,%edx
80105b6c:	75 f2                	jne    80105b60 <sys_pipe+0x80>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105b6e:	e8 0d e1 ff ff       	call   80103c80 <myproc>
80105b73:	31 d2                	xor    %edx,%edx
80105b75:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
    fileclose(rf);
80105b79:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105b7c:	89 04 24             	mov    %eax,(%esp)
80105b7f:	e8 ac b3 ff ff       	call   80100f30 <fileclose>
    fileclose(wf);
80105b84:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105b87:	89 04 24             	mov    %eax,(%esp)
80105b8a:	e8 a1 b3 ff ff       	call   80100f30 <fileclose>
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105b8f:	83 c4 2c             	add    $0x2c,%esp
    return -1;
80105b92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b97:	5b                   	pop    %ebx
80105b98:	5e                   	pop    %esi
80105b99:	5f                   	pop    %edi
80105b9a:	5d                   	pop    %ebp
80105b9b:	c3                   	ret
80105b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105ba0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  fd[0] = fd0;
80105ba4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105ba7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105ba9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105bac:	89 50 04             	mov    %edx,0x4(%eax)
}
80105baf:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80105bb2:	31 c0                	xor    %eax,%eax
}
80105bb4:	5b                   	pop    %ebx
80105bb5:	5e                   	pop    %esi
80105bb6:	5f                   	pop    %edi
80105bb7:	5d                   	pop    %ebp
80105bb8:	c3                   	ret
80105bb9:	66 90                	xchg   %ax,%ax
80105bbb:	66 90                	xchg   %ax,%ax
80105bbd:	66 90                	xchg   %ax,%ax
80105bbf:	90                   	nop

80105bc0 <sys_getpasize>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_getpasize(void) {
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	83 ec 28             	sub    $0x28,%esp
  int pid;
  if (argint(0, &pid) < 0)
80105bc6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105bcd:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105bd0:	89 44 24 04          	mov    %eax,0x4(%esp)
80105bd4:	e8 67 f2 ff ff       	call   80104e40 <argint>
80105bd9:	85 c0                	test   %eax,%eax
80105bdb:	78 13                	js     80105bf0 <sys_getpasize+0x30>
    return -1;

  return getpasize(pid);
80105bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105be0:	89 04 24             	mov    %eax,(%esp)
80105be3:	e8 88 dd ff ff       	call   80103970 <getpasize>
}
80105be8:	89 ec                	mov    %ebp,%esp
80105bea:	5d                   	pop    %ebp
80105beb:	c3                   	ret
80105bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105bf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bf5:	eb f1                	jmp    80105be8 <sys_getpasize+0x28>
80105bf7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bfe:	00 
80105bff:	90                   	nop

80105c00 <sys_get_kernel_pgtb_size>:

int
sys_get_kernel_pgtb_size(void) {
  return get_kernel_pgtb_size();
80105c00:	e9 9b 1d 00 00       	jmp    801079a0 <get_kernel_pgtb_size>
80105c05:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c0c:	00 
80105c0d:	8d 76 00             	lea    0x0(%esi),%esi

80105c10 <sys_get_usr_pgtb_size>:
}

int
sys_get_usr_pgtb_size(void) {
  return get_usr_pgtb_size();
80105c10:	e9 4b 1d 00 00       	jmp    80107960 <get_usr_pgtb_size>
80105c15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c1c:	00 
80105c1d:	8d 76 00             	lea    0x0(%esi),%esi

80105c20 <sys_get_pgtb_size>:
}

int
sys_get_pgtb_size(void) {
  return get_pgtb_size();
80105c20:	e9 fb 1c 00 00       	jmp    80107920 <get_pgtb_size>
80105c25:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c2c:	00 
80105c2d:	8d 76 00             	lea    0x0(%esi),%esi

80105c30 <sys_va2pa>:
}

int
sys_va2pa(void) {
80105c30:	55                   	push   %ebp
80105c31:	89 e5                	mov    %esp,%ebp
80105c33:	83 ec 28             	sub    $0x28,%esp
  uint va;
  if (argint(0, (int*)&va) < 0)
80105c36:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105c3d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c40:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c44:	e8 f7 f1 ff ff       	call   80104e40 <argint>
80105c49:	85 c0                	test   %eax,%eax
80105c4b:	78 13                	js     80105c60 <sys_va2pa+0x30>
    return -1;

  return va2pa(va);
80105c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c50:	89 04 24             	mov    %eax,(%esp)
80105c53:	e8 78 1c 00 00       	call   801078d0 <va2pa>
}
80105c58:	89 ec                	mov    %ebp,%esp
80105c5a:	5d                   	pop    %ebp
80105c5b:	c3                   	ret
80105c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c65:	eb f1                	jmp    80105c58 <sys_va2pa+0x28>
80105c67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c6e:	00 
80105c6f:	90                   	nop

80105c70 <sys_getvasize>:

int
sys_getvasize(void) {
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	83 ec 28             	sub    $0x28,%esp
  int pid;
  if (argint(0, &pid) < 0)
80105c76:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105c7d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c80:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c84:	e8 b7 f1 ff ff       	call   80104e40 <argint>
80105c89:	85 c0                	test   %eax,%eax
80105c8b:	78 13                	js     80105ca0 <sys_getvasize+0x30>
    return -1;

  return getvasize(pid);
80105c8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c90:	89 04 24             	mov    %eax,(%esp)
80105c93:	e8 48 dd ff ff       	call   801039e0 <getvasize>
}
80105c98:	89 ec                	mov    %ebp,%esp
80105c9a:	5d                   	pop    %ebp
80105c9b:	c3                   	ret
80105c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ca0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ca5:	eb f1                	jmp    80105c98 <sys_getvasize+0x28>
80105ca7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cae:	00 
80105caf:	90                   	nop

80105cb0 <sys_spawn>:

int
sys_spawn(void) {
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	83 ec 28             	sub    $0x28,%esp
  int n;
  int* pids;

  if (argint(0, &n) < 0 || argptr(1, (void*)&pids, n*sizeof(pids[0])) < 0)
80105cb6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105cbd:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105cc0:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cc4:	e8 77 f1 ff ff       	call   80104e40 <argint>
80105cc9:	85 c0                	test   %eax,%eax
80105ccb:	78 3b                	js     80105d08 <sys_spawn+0x58>
80105ccd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cd0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105cd7:	c1 e0 02             	shl    $0x2,%eax
80105cda:	89 44 24 08          	mov    %eax,0x8(%esp)
80105cde:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ce1:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ce5:	e8 a6 f1 ff ff       	call   80104e90 <argptr>
80105cea:	85 c0                	test   %eax,%eax
80105cec:	78 1a                	js     80105d08 <sys_spawn+0x58>
    return -1;

  return spawn(n, pids);
80105cee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cf1:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cf8:	89 04 24             	mov    %eax,(%esp)
80105cfb:	e8 b0 e8 ff ff       	call   801045b0 <spawn>
}
80105d00:	89 ec                	mov    %ebp,%esp
80105d02:	5d                   	pop    %ebp
80105d03:	c3                   	ret
80105d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d0d:	eb f1                	jmp    80105d00 <sys_spawn+0x50>
80105d0f:	90                   	nop

80105d10 <sys_get_sibling>:

int
sys_get_sibling(void) {
  return get_sibling();
80105d10:	e9 bb de ff ff       	jmp    80103bd0 <get_sibling>
80105d15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d1c:	00 
80105d1d:	8d 76 00             	lea    0x0(%esi),%esi

80105d20 <sys_whatsthestatus>:
}

int
sys_whatsthestatus(void) {
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105d26:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105d2d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d30:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d34:	e8 07 f1 ff ff       	call   80104e40 <argint>
80105d39:	85 c0                	test   %eax,%eax
80105d3b:	78 13                	js     80105d50 <sys_whatsthestatus+0x30>
    return -1;
  return whatsthestatus(pid);
80105d3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d40:	89 04 24             	mov    %eax,(%esp)
80105d43:	e8 f8 dc ff ff       	call   80103a40 <whatsthestatus>
}
80105d48:	89 ec                	mov    %ebp,%esp
80105d4a:	5d                   	pop    %ebp
80105d4b:	c3                   	ret
80105d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d55:	eb f1                	jmp    80105d48 <sys_whatsthestatus+0x28>
80105d57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d5e:	00 
80105d5f:	90                   	nop

80105d60 <sys_numberofprocesses>:

int
sys_numberofprocesses(void) {
  return numberofprocesses();
80105d60:	e9 8b dd ff ff       	jmp    80103af0 <numberofprocesses>
80105d65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d6c:	00 
80105d6d:	8d 76 00             	lea    0x0(%esi),%esi

80105d70 <sys_fork>:
}

int
sys_fork(void)
{
  return fork();
80105d70:	e9 cb e0 ff ff       	jmp    80103e40 <fork>
80105d75:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d7c:	00 
80105d7d:	8d 76 00             	lea    0x0(%esi),%esi

80105d80 <sys_exit>:
}

int
sys_exit(void)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	83 ec 08             	sub    $0x8,%esp
  exit();
80105d86:	e8 05 e3 ff ff       	call   80104090 <exit>
  return 0;  // not reached
}
80105d8b:	89 ec                	mov    %ebp,%esp
80105d8d:	31 c0                	xor    %eax,%eax
80105d8f:	5d                   	pop    %ebp
80105d90:	c3                   	ret
80105d91:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d98:	00 
80105d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105da0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105da0:	e9 1b e4 ff ff       	jmp    801041c0 <wait>
80105da5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105dac:	00 
80105dad:	8d 76 00             	lea    0x0(%esi),%esi

80105db0 <sys_kill>:
}

int
sys_kill(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105db6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105dbd:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105dc0:	89 44 24 04          	mov    %eax,0x4(%esp)
80105dc4:	e8 77 f0 ff ff       	call   80104e40 <argint>
80105dc9:	85 c0                	test   %eax,%eax
80105dcb:	78 13                	js     80105de0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105dcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dd0:	89 04 24             	mov    %eax,(%esp)
80105dd3:	e8 98 e6 ff ff       	call   80104470 <kill>
}
80105dd8:	89 ec                	mov    %ebp,%esp
80105dda:	5d                   	pop    %ebp
80105ddb:	c3                   	ret
80105ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105de5:	eb f1                	jmp    80105dd8 <sys_kill+0x28>
80105de7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105dee:	00 
80105def:	90                   	nop

80105df0 <sys_getpid>:

int
sys_getpid(void)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105df6:	e8 85 de ff ff       	call   80103c80 <myproc>
80105dfb:	8b 40 10             	mov    0x10(%eax),%eax
}
80105dfe:	89 ec                	mov    %ebp,%esp
80105e00:	5d                   	pop    %ebp
80105e01:	c3                   	ret
80105e02:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e09:	00 
80105e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105e10 <sys_sbrk>:

int
sys_sbrk(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	83 ec 28             	sub    $0x28,%esp
80105e16:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105e19:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e20:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105e27:	e8 14 f0 ff ff       	call   80104e40 <argint>
80105e2c:	85 c0                	test   %eax,%eax
80105e2e:	78 20                	js     80105e50 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105e30:	e8 4b de ff ff       	call   80103c80 <myproc>
80105e35:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105e37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e3a:	89 04 24             	mov    %eax,(%esp)
80105e3d:	e8 7e df ff ff       	call   80103dc0 <growproc>
80105e42:	85 c0                	test   %eax,%eax
80105e44:	78 0a                	js     80105e50 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105e46:	89 d8                	mov    %ebx,%eax
80105e48:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e4b:	89 ec                	mov    %ebp,%esp
80105e4d:	5d                   	pop    %ebp
80105e4e:	c3                   	ret
80105e4f:	90                   	nop
    return -1;
80105e50:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e55:	eb ef                	jmp    80105e46 <sys_sbrk+0x36>
80105e57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e5e:	00 
80105e5f:	90                   	nop

80105e60 <sys_sleep>:

int
sys_sleep(void)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	83 ec 28             	sub    $0x28,%esp
80105e66:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105e69:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105e77:	e8 c4 ef ff ff       	call   80104e40 <argint>
80105e7c:	85 c0                	test   %eax,%eax
80105e7e:	78 59                	js     80105ed9 <sys_sleep+0x79>
    return -1;
  acquire(&tickslock);
80105e80:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105e87:	e8 14 ec ff ff       	call   80104aa0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105e8c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80105e8f:	8b 1d 60 4c 11 80    	mov    0x80114c60,%ebx
  while(ticks - ticks0 < n){
80105e95:	85 c9                	test   %ecx,%ecx
80105e97:	75 28                	jne    80105ec1 <sys_sleep+0x61>
80105e99:	eb 45                	jmp    80105ee0 <sys_sleep+0x80>
80105e9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105ea0:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105ea7:	b8 80 4c 11 80       	mov    $0x80114c80,%eax
80105eac:	89 44 24 04          	mov    %eax,0x4(%esp)
80105eb0:	e8 8b e4 ff ff       	call   80104340 <sleep>
  while(ticks - ticks0 < n){
80105eb5:	a1 60 4c 11 80       	mov    0x80114c60,%eax
80105eba:	29 d8                	sub    %ebx,%eax
80105ebc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105ebf:	73 1f                	jae    80105ee0 <sys_sleep+0x80>
    if(myproc()->killed){
80105ec1:	e8 ba dd ff ff       	call   80103c80 <myproc>
80105ec6:	8b 50 24             	mov    0x24(%eax),%edx
80105ec9:	85 d2                	test   %edx,%edx
80105ecb:	74 d3                	je     80105ea0 <sys_sleep+0x40>
      release(&tickslock);
80105ecd:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105ed4:	e8 57 eb ff ff       	call   80104a30 <release>
    return -1;
80105ed9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ede:	eb 0e                	jmp    80105eee <sys_sleep+0x8e>
  }
  release(&tickslock);
80105ee0:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105ee7:	e8 44 eb ff ff       	call   80104a30 <release>
  return 0;
80105eec:	31 c0                	xor    %eax,%eax
}
80105eee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ef1:	89 ec                	mov    %ebp,%esp
80105ef3:	5d                   	pop    %ebp
80105ef4:	c3                   	ret
80105ef5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105efc:	00 
80105efd:	8d 76 00             	lea    0x0(%esi),%esi

80105f00 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	83 ec 18             	sub    $0x18,%esp
80105f06:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  uint xticks;

  acquire(&tickslock);
80105f09:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105f10:	e8 8b eb ff ff       	call   80104aa0 <acquire>
  xticks = ticks;
80105f15:	8b 1d 60 4c 11 80    	mov    0x80114c60,%ebx
  release(&tickslock);
80105f1b:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105f22:	e8 09 eb ff ff       	call   80104a30 <release>
  return xticks;
}
80105f27:	89 d8                	mov    %ebx,%eax
80105f29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f2c:	89 ec                	mov    %ebp,%esp
80105f2e:	5d                   	pop    %ebp
80105f2f:	c3                   	ret

80105f30 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105f30:	1e                   	push   %ds
  pushl %es
80105f31:	06                   	push   %es
  pushl %fs
80105f32:	0f a0                	push   %fs
  pushl %gs
80105f34:	0f a8                	push   %gs
  pushal
80105f36:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105f37:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105f3b:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105f3d:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105f3f:	54                   	push   %esp
  call trap
80105f40:	e8 cb 00 00 00       	call   80106010 <trap>
  addl $4, %esp
80105f45:	83 c4 04             	add    $0x4,%esp

80105f48 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105f48:	61                   	popa
  popl %gs
80105f49:	0f a9                	pop    %gs
  popl %fs
80105f4b:	0f a1                	pop    %fs
  popl %es
80105f4d:	07                   	pop    %es
  popl %ds
80105f4e:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105f4f:	83 c4 08             	add    $0x8,%esp
  iret
80105f52:	cf                   	iret
80105f53:	66 90                	xchg   %ax,%ax
80105f55:	66 90                	xchg   %ax,%ax
80105f57:	66 90                	xchg   %ax,%ax
80105f59:	66 90                	xchg   %ax,%ax
80105f5b:	66 90                	xchg   %ax,%ax
80105f5d:	66 90                	xchg   %ax,%ax
80105f5f:	90                   	nop

80105f60 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105f60:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105f61:	31 c0                	xor    %eax,%eax
{
80105f63:	89 e5                	mov    %esp,%ebp
80105f65:	83 ec 18             	sub    $0x18,%esp
80105f68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f6f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105f70:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105f77:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
80105f7c:	89 0c c5 c2 4c 11 80 	mov    %ecx,-0x7feeb33e(,%eax,8)
80105f83:	66 89 14 c5 c0 4c 11 	mov    %dx,-0x7feeb340(,%eax,8)
80105f8a:	80 
80105f8b:	c1 ea 10             	shr    $0x10,%edx
80105f8e:	66 89 14 c5 c6 4c 11 	mov    %dx,-0x7feeb33a(,%eax,8)
80105f95:	80 
  for(i = 0; i < 256; i++)
80105f96:	40                   	inc    %eax
80105f97:	3d 00 01 00 00       	cmp    $0x100,%eax
80105f9c:	75 d2                	jne    80105f70 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105f9e:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105fa3:	ba 08 00 00 ef       	mov    $0xef000008,%edx

  initlock(&tickslock, "time");
80105fa8:	b9 aa 7e 10 80       	mov    $0x80107eaa,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105fad:	89 15 c2 4e 11 80    	mov    %edx,0x80114ec2
80105fb3:	66 a3 c0 4e 11 80    	mov    %ax,0x80114ec0
80105fb9:	c1 e8 10             	shr    $0x10,%eax
80105fbc:	66 a3 c6 4e 11 80    	mov    %ax,0x80114ec6
  initlock(&tickslock, "time");
80105fc2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80105fc6:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105fcd:	e8 ce e8 ff ff       	call   801048a0 <initlock>
}
80105fd2:	89 ec                	mov    %ebp,%esp
80105fd4:	5d                   	pop    %ebp
80105fd5:	c3                   	ret
80105fd6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fdd:	00 
80105fde:	66 90                	xchg   %ax,%ax

80105fe0 <idtinit>:

void
idtinit(void)
{
80105fe0:	55                   	push   %ebp
  pd[1] = (uint)p;
80105fe1:	b8 c0 4c 11 80       	mov    $0x80114cc0,%eax
80105fe6:	89 e5                	mov    %esp,%ebp
80105fe8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80105feb:	c1 e8 10             	shr    $0x10,%eax
80105fee:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80105ff1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80105ff7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105ffb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105fff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106002:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106005:	89 ec                	mov    %ebp,%esp
80106007:	5d                   	pop    %ebp
80106008:	c3                   	ret
80106009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106010 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	83 ec 48             	sub    $0x48,%esp
80106016:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106019:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010601c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010601f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80106022:	8b 43 30             	mov    0x30(%ebx),%eax
80106025:	83 f8 40             	cmp    $0x40,%eax
80106028:	0f 84 62 01 00 00    	je     80106190 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010602e:	83 e8 0e             	sub    $0xe,%eax
80106031:	83 f8 31             	cmp    $0x31,%eax
80106034:	0f 87 96 00 00 00    	ja     801060d0 <trap+0xc0>
8010603a:	ff 24 85 84 84 10 80 	jmp    *-0x7fef7b7c(,%eax,4)
80106041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  case T_PGFLT:
    cprintf("[PAGE FAULT] [PID %d] on [ADDR %x]\n", myproc()->pid, rcr2());
    myproc()->killed = 1;
    break;
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106048:	e8 63 db ff ff       	call   80103bb0 <cpuid>
8010604d:	85 c0                	test   %eax,%eax
8010604f:	90                   	nop
80106050:	0f 84 6a 02 00 00    	je     801062c0 <trap+0x2b0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80106056:	e8 95 c9 ff ff       	call   801029f0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010605b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106060:	e8 1b dc ff ff       	call   80103c80 <myproc>
80106065:	85 c0                	test   %eax,%eax
80106067:	74 19                	je     80106082 <trap+0x72>
80106069:	e8 12 dc ff ff       	call   80103c80 <myproc>
8010606e:	8b 50 24             	mov    0x24(%eax),%edx
80106071:	85 d2                	test   %edx,%edx
80106073:	74 0d                	je     80106082 <trap+0x72>
80106075:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106078:	f7 d0                	not    %eax
8010607a:	a8 03                	test   $0x3,%al
8010607c:	0f 84 1e 02 00 00    	je     801062a0 <trap+0x290>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106082:	e8 f9 db ff ff       	call   80103c80 <myproc>
80106087:	85 c0                	test   %eax,%eax
80106089:	74 14                	je     8010609f <trap+0x8f>
8010608b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106090:	e8 eb db ff ff       	call   80103c80 <myproc>
80106095:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106099:	0f 84 d1 00 00 00    	je     80106170 <trap+0x160>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010609f:	e8 dc db ff ff       	call   80103c80 <myproc>
801060a4:	85 c0                	test   %eax,%eax
801060a6:	74 19                	je     801060c1 <trap+0xb1>
801060a8:	e8 d3 db ff ff       	call   80103c80 <myproc>
801060ad:	8b 40 24             	mov    0x24(%eax),%eax
801060b0:	85 c0                	test   %eax,%eax
801060b2:	74 0d                	je     801060c1 <trap+0xb1>
801060b4:	8b 43 3c             	mov    0x3c(%ebx),%eax
801060b7:	f7 d0                	not    %eax
801060b9:	a8 03                	test   $0x3,%al
801060bb:	0f 84 fc 00 00 00    	je     801061bd <trap+0x1ad>
    exit();
}
801060c1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801060c4:	8b 75 f8             	mov    -0x8(%ebp),%esi
801060c7:	8b 7d fc             	mov    -0x4(%ebp),%edi
801060ca:	89 ec                	mov    %ebp,%esp
801060cc:	5d                   	pop    %ebp
801060cd:	c3                   	ret
801060ce:	66 90                	xchg   %ax,%ax
    if(myproc() == 0 || (tf->cs&3) == 0){
801060d0:	e8 ab db ff ff       	call   80103c80 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060d5:	8b 7b 38             	mov    0x38(%ebx),%edi
    if(myproc() == 0 || (tf->cs&3) == 0){
801060d8:	85 c0                	test   %eax,%eax
801060da:	0f 84 0f 02 00 00    	je     801062ef <trap+0x2df>
801060e0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801060e4:	0f 84 05 02 00 00    	je     801062ef <trap+0x2df>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801060ea:	0f 20 d1             	mov    %cr2,%ecx
801060ed:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060f0:	e8 bb da ff ff       	call   80103bb0 <cpuid>
801060f5:	8b 73 30             	mov    0x30(%ebx),%esi
801060f8:	89 45 dc             	mov    %eax,-0x24(%ebp)
801060fb:	8b 43 34             	mov    0x34(%ebx),%eax
801060fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106101:	e8 7a db ff ff       	call   80103c80 <myproc>
80106106:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106109:	e8 72 db ff ff       	call   80103c80 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010610e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106111:	89 7c 24 18          	mov    %edi,0x18(%esp)
80106115:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
80106119:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010611c:	89 54 24 14          	mov    %edx,0x14(%esp)
80106120:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106123:	89 74 24 0c          	mov    %esi,0xc(%esp)
80106127:	89 54 24 10          	mov    %edx,0x10(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
8010612b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010612e:	83 c6 6c             	add    $0x6c,%esi
80106131:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106135:	8b 40 10             	mov    0x10(%eax),%eax
80106138:	c7 04 24 20 81 10 80 	movl   $0x80108120,(%esp)
8010613f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106143:	e8 38 a5 ff ff       	call   80100680 <cprintf>
    myproc()->killed = 1;
80106148:	e8 33 db ff ff       	call   80103c80 <myproc>
8010614d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106154:	e8 27 db ff ff       	call   80103c80 <myproc>
80106159:	85 c0                	test   %eax,%eax
8010615b:	0f 85 08 ff ff ff    	jne    80106069 <trap+0x59>
80106161:	e9 1c ff ff ff       	jmp    80106082 <trap+0x72>
80106166:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010616d:	00 
8010616e:	66 90                	xchg   %ax,%ax
  if(myproc() && myproc()->state == RUNNING &&
80106170:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106174:	0f 85 25 ff ff ff    	jne    8010609f <trap+0x8f>
    yield();
8010617a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106180:	e8 6b e1 ff ff       	call   801042f0 <yield>
80106185:	e9 15 ff ff ff       	jmp    8010609f <trap+0x8f>
8010618a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80106190:	e8 eb da ff ff       	call   80103c80 <myproc>
80106195:	8b 70 24             	mov    0x24(%eax),%esi
80106198:	85 f6                	test   %esi,%esi
8010619a:	0f 85 10 01 00 00    	jne    801062b0 <trap+0x2a0>
    myproc()->tf = tf;
801061a0:	e8 db da ff ff       	call   80103c80 <myproc>
801061a5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801061a8:	e8 d3 ed ff ff       	call   80104f80 <syscall>
    if(myproc()->killed)
801061ad:	e8 ce da ff ff       	call   80103c80 <myproc>
801061b2:	8b 48 24             	mov    0x24(%eax),%ecx
801061b5:	85 c9                	test   %ecx,%ecx
801061b7:	0f 84 04 ff ff ff    	je     801060c1 <trap+0xb1>
}
801061bd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801061c0:	8b 75 f8             	mov    -0x8(%ebp),%esi
801061c3:	8b 7d fc             	mov    -0x4(%ebp),%edi
801061c6:	89 ec                	mov    %ebp,%esp
801061c8:	5d                   	pop    %ebp
      exit();
801061c9:	e9 c2 de ff ff       	jmp    80104090 <exit>
801061ce:	66 90                	xchg   %ax,%ax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801061d0:	8b 7b 38             	mov    0x38(%ebx),%edi
801061d3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801061d7:	e8 d4 d9 ff ff       	call   80103bb0 <cpuid>
801061dc:	c7 04 24 c8 80 10 80 	movl   $0x801080c8,(%esp)
801061e3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801061e7:	89 74 24 08          	mov    %esi,0x8(%esp)
801061eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801061ef:	e8 8c a4 ff ff       	call   80100680 <cprintf>
    lapiceoi();
801061f4:	e8 f7 c7 ff ff       	call   801029f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061f9:	e8 82 da ff ff       	call   80103c80 <myproc>
801061fe:	85 c0                	test   %eax,%eax
80106200:	0f 85 63 fe ff ff    	jne    80106069 <trap+0x59>
80106206:	e9 77 fe ff ff       	jmp    80106082 <trap+0x72>
8010620b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    kbdintr();
80106210:	e8 9b c6 ff ff       	call   801028b0 <kbdintr>
    lapiceoi();
80106215:	e8 d6 c7 ff ff       	call   801029f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010621a:	e8 61 da ff ff       	call   80103c80 <myproc>
8010621f:	85 c0                	test   %eax,%eax
80106221:	0f 85 42 fe ff ff    	jne    80106069 <trap+0x59>
80106227:	e9 56 fe ff ff       	jmp    80106082 <trap+0x72>
8010622c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106230:	e8 6b 02 00 00       	call   801064a0 <uartintr>
    lapiceoi();
80106235:	e8 b6 c7 ff ff       	call   801029f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010623a:	e8 41 da ff ff       	call   80103c80 <myproc>
8010623f:	85 c0                	test   %eax,%eax
80106241:	0f 85 22 fe ff ff    	jne    80106069 <trap+0x59>
80106247:	e9 36 fe ff ff       	jmp    80106082 <trap+0x72>
8010624c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106250:	e8 db c0 ff ff       	call   80102330 <ideintr>
80106255:	e9 fc fd ff ff       	jmp    80106056 <trap+0x46>
8010625a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106260:	0f 20 d6             	mov    %cr2,%esi
    cprintf("[PAGE FAULT] [PID %d] on [ADDR %x]\n", myproc()->pid, rcr2());
80106263:	e8 18 da ff ff       	call   80103c80 <myproc>
80106268:	89 74 24 08          	mov    %esi,0x8(%esp)
8010626c:	8b 40 10             	mov    0x10(%eax),%eax
8010626f:	c7 04 24 a4 80 10 80 	movl   $0x801080a4,(%esp)
80106276:	89 44 24 04          	mov    %eax,0x4(%esp)
8010627a:	e8 01 a4 ff ff       	call   80100680 <cprintf>
    myproc()->killed = 1;
8010627f:	e8 fc d9 ff ff       	call   80103c80 <myproc>
80106284:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010628b:	e8 f0 d9 ff ff       	call   80103c80 <myproc>
80106290:	85 c0                	test   %eax,%eax
80106292:	0f 85 d1 fd ff ff    	jne    80106069 <trap+0x59>
80106298:	e9 e5 fd ff ff       	jmp    80106082 <trap+0x72>
8010629d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
801062a0:	e8 eb dd ff ff       	call   80104090 <exit>
801062a5:	e9 d8 fd ff ff       	jmp    80106082 <trap+0x72>
801062aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801062b0:	e8 db dd ff ff       	call   80104090 <exit>
801062b5:	e9 e6 fe ff ff       	jmp    801061a0 <trap+0x190>
801062ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801062c0:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
801062c7:	e8 d4 e7 ff ff       	call   80104aa0 <acquire>
      ticks++;
801062cc:	ff 05 60 4c 11 80    	incl   0x80114c60
      wakeup(&ticks);
801062d2:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801062d9:	e8 32 e1 ff ff       	call   80104410 <wakeup>
      release(&tickslock);
801062de:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
801062e5:	e8 46 e7 ff ff       	call   80104a30 <release>
    lapiceoi();
801062ea:	e9 67 fd ff ff       	jmp    80106056 <trap+0x46>
801062ef:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801062f2:	e8 b9 d8 ff ff       	call   80103bb0 <cpuid>
801062f7:	89 74 24 10          	mov    %esi,0x10(%esp)
801062fb:	89 7c 24 0c          	mov    %edi,0xc(%esp)
801062ff:	89 44 24 08          	mov    %eax,0x8(%esp)
80106303:	8b 43 30             	mov    0x30(%ebx),%eax
80106306:	c7 04 24 ec 80 10 80 	movl   $0x801080ec,(%esp)
8010630d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106311:	e8 6a a3 ff ff       	call   80100680 <cprintf>
      panic("trap");
80106316:	c7 04 24 af 7e 10 80 	movl   $0x80107eaf,(%esp)
8010631d:	e8 2e a0 ff ff       	call   80100350 <panic>
80106322:	66 90                	xchg   %ax,%ax
80106324:	66 90                	xchg   %ax,%ax
80106326:	66 90                	xchg   %ax,%ax
80106328:	66 90                	xchg   %ax,%ax
8010632a:	66 90                	xchg   %ax,%ax
8010632c:	66 90                	xchg   %ax,%ax
8010632e:	66 90                	xchg   %ax,%ax

80106330 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106330:	a1 c0 54 11 80       	mov    0x801154c0,%eax
80106335:	85 c0                	test   %eax,%eax
80106337:	74 17                	je     80106350 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106339:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010633e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010633f:	24 01                	and    $0x1,%al
80106341:	74 0d                	je     80106350 <uartgetc+0x20>
80106343:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106348:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106349:	0f b6 c0             	movzbl %al,%eax
8010634c:	c3                   	ret
8010634d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106355:	c3                   	ret
80106356:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010635d:	00 
8010635e:	66 90                	xchg   %ax,%ax

80106360 <uartinit>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106360:	31 c9                	xor    %ecx,%ecx
80106362:	ba fa 03 00 00       	mov    $0x3fa,%edx
80106367:	88 c8                	mov    %cl,%al
80106369:	ee                   	out    %al,(%dx)
8010636a:	b0 80                	mov    $0x80,%al
8010636c:	ba fb 03 00 00       	mov    $0x3fb,%edx
80106371:	ee                   	out    %al,(%dx)
80106372:	b0 0c                	mov    $0xc,%al
80106374:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106379:	ee                   	out    %al,(%dx)
8010637a:	ba f9 03 00 00       	mov    $0x3f9,%edx
8010637f:	88 c8                	mov    %cl,%al
80106381:	ee                   	out    %al,(%dx)
80106382:	b0 03                	mov    $0x3,%al
80106384:	ba fb 03 00 00       	mov    $0x3fb,%edx
80106389:	ee                   	out    %al,(%dx)
8010638a:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010638f:	88 c8                	mov    %cl,%al
80106391:	ee                   	out    %al,(%dx)
80106392:	b0 01                	mov    $0x1,%al
80106394:	ba f9 03 00 00       	mov    $0x3f9,%edx
80106399:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010639a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010639f:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801063a0:	fe c0                	inc    %al
801063a2:	0f 84 8c 00 00 00    	je     80106434 <uartinit+0xd4>
{
801063a8:	55                   	push   %ebp
  uart = 1;
801063a9:	ba 01 00 00 00       	mov    $0x1,%edx
{
801063ae:	89 e5                	mov    %esp,%ebp
801063b0:	57                   	push   %edi
801063b1:	56                   	push   %esi
801063b2:	53                   	push   %ebx
801063b3:	83 ec 2c             	sub    $0x2c,%esp
  uart = 1;
801063b6:	89 15 c0 54 11 80    	mov    %edx,0x801154c0
801063bc:	ba fa 03 00 00       	mov    $0x3fa,%edx
801063c1:	ec                   	in     (%dx),%al
801063c2:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063c7:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801063c8:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801063cf:	31 c9                	xor    %ecx,%ecx
  for(p="xv6...\n"; *p; p++)
801063d1:	bf b4 7e 10 80       	mov    $0x80107eb4,%edi
  ioapicenable(IRQ_COM1, 0);
801063d6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801063da:	be fd 03 00 00       	mov    $0x3fd,%esi
801063df:	e8 8c c1 ff ff       	call   80102570 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801063e4:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
801063e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063ef:	00 
  if(!uart)
801063f0:	a1 c0 54 11 80       	mov    0x801154c0,%eax
801063f5:	85 c0                	test   %eax,%eax
801063f7:	74 27                	je     80106420 <uartinit+0xc0>
801063f9:	bb 80 00 00 00       	mov    $0x80,%ebx
801063fe:	eb 0f                	jmp    8010640f <uartinit+0xaf>
    microdelay(10);
80106400:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106407:	e8 04 c6 ff ff       	call   80102a10 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010640c:	4b                   	dec    %ebx
8010640d:	74 07                	je     80106416 <uartinit+0xb6>
8010640f:	89 f2                	mov    %esi,%edx
80106411:	ec                   	in     (%dx),%al
80106412:	24 20                	and    $0x20,%al
80106414:	74 ea                	je     80106400 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106416:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010641a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010641f:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106420:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106424:	47                   	inc    %edi
80106425:	88 45 e7             	mov    %al,-0x19(%ebp)
80106428:	84 c0                	test   %al,%al
8010642a:	75 c4                	jne    801063f0 <uartinit+0x90>
}
8010642c:	83 c4 2c             	add    $0x2c,%esp
8010642f:	5b                   	pop    %ebx
80106430:	5e                   	pop    %esi
80106431:	5f                   	pop    %edi
80106432:	5d                   	pop    %ebp
80106433:	c3                   	ret
80106434:	c3                   	ret
80106435:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010643c:	00 
8010643d:	8d 76 00             	lea    0x0(%esi),%esi

80106440 <uartputc>:
  if(!uart)
80106440:	a1 c0 54 11 80       	mov    0x801154c0,%eax
80106445:	85 c0                	test   %eax,%eax
80106447:	74 47                	je     80106490 <uartputc+0x50>
{
80106449:	55                   	push   %ebp
8010644a:	89 e5                	mov    %esp,%ebp
8010644c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010644d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106452:	53                   	push   %ebx
80106453:	bb 80 00 00 00       	mov    $0x80,%ebx
80106458:	83 ec 10             	sub    $0x10,%esp
8010645b:	eb 12                	jmp    8010646f <uartputc+0x2f>
8010645d:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80106460:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106467:	e8 a4 c5 ff ff       	call   80102a10 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010646c:	4b                   	dec    %ebx
8010646d:	74 07                	je     80106476 <uartputc+0x36>
8010646f:	89 f2                	mov    %esi,%edx
80106471:	ec                   	in     (%dx),%al
80106472:	24 20                	and    $0x20,%al
80106474:	74 ea                	je     80106460 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106476:	8b 45 08             	mov    0x8(%ebp),%eax
80106479:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010647e:	ee                   	out    %al,(%dx)
}
8010647f:	83 c4 10             	add    $0x10,%esp
80106482:	5b                   	pop    %ebx
80106483:	5e                   	pop    %esi
80106484:	5d                   	pop    %ebp
80106485:	c3                   	ret
80106486:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010648d:	00 
8010648e:	66 90                	xchg   %ax,%ax
80106490:	c3                   	ret
80106491:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106498:	00 
80106499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801064a0 <uartintr>:

void
uartintr(void)
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
801064a6:	c7 04 24 30 63 10 80 	movl   $0x80106330,(%esp)
801064ad:	e8 be a3 ff ff       	call   80100870 <consoleintr>
}
801064b2:	89 ec                	mov    %ebp,%esp
801064b4:	5d                   	pop    %ebp
801064b5:	c3                   	ret

801064b6 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801064b6:	6a 00                	push   $0x0
  pushl $0
801064b8:	6a 00                	push   $0x0
  jmp alltraps
801064ba:	e9 71 fa ff ff       	jmp    80105f30 <alltraps>

801064bf <vector1>:
.globl vector1
vector1:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $1
801064c1:	6a 01                	push   $0x1
  jmp alltraps
801064c3:	e9 68 fa ff ff       	jmp    80105f30 <alltraps>

801064c8 <vector2>:
.globl vector2
vector2:
  pushl $0
801064c8:	6a 00                	push   $0x0
  pushl $2
801064ca:	6a 02                	push   $0x2
  jmp alltraps
801064cc:	e9 5f fa ff ff       	jmp    80105f30 <alltraps>

801064d1 <vector3>:
.globl vector3
vector3:
  pushl $0
801064d1:	6a 00                	push   $0x0
  pushl $3
801064d3:	6a 03                	push   $0x3
  jmp alltraps
801064d5:	e9 56 fa ff ff       	jmp    80105f30 <alltraps>

801064da <vector4>:
.globl vector4
vector4:
  pushl $0
801064da:	6a 00                	push   $0x0
  pushl $4
801064dc:	6a 04                	push   $0x4
  jmp alltraps
801064de:	e9 4d fa ff ff       	jmp    80105f30 <alltraps>

801064e3 <vector5>:
.globl vector5
vector5:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $5
801064e5:	6a 05                	push   $0x5
  jmp alltraps
801064e7:	e9 44 fa ff ff       	jmp    80105f30 <alltraps>

801064ec <vector6>:
.globl vector6
vector6:
  pushl $0
801064ec:	6a 00                	push   $0x0
  pushl $6
801064ee:	6a 06                	push   $0x6
  jmp alltraps
801064f0:	e9 3b fa ff ff       	jmp    80105f30 <alltraps>

801064f5 <vector7>:
.globl vector7
vector7:
  pushl $0
801064f5:	6a 00                	push   $0x0
  pushl $7
801064f7:	6a 07                	push   $0x7
  jmp alltraps
801064f9:	e9 32 fa ff ff       	jmp    80105f30 <alltraps>

801064fe <vector8>:
.globl vector8
vector8:
  pushl $8
801064fe:	6a 08                	push   $0x8
  jmp alltraps
80106500:	e9 2b fa ff ff       	jmp    80105f30 <alltraps>

80106505 <vector9>:
.globl vector9
vector9:
  pushl $0
80106505:	6a 00                	push   $0x0
  pushl $9
80106507:	6a 09                	push   $0x9
  jmp alltraps
80106509:	e9 22 fa ff ff       	jmp    80105f30 <alltraps>

8010650e <vector10>:
.globl vector10
vector10:
  pushl $10
8010650e:	6a 0a                	push   $0xa
  jmp alltraps
80106510:	e9 1b fa ff ff       	jmp    80105f30 <alltraps>

80106515 <vector11>:
.globl vector11
vector11:
  pushl $11
80106515:	6a 0b                	push   $0xb
  jmp alltraps
80106517:	e9 14 fa ff ff       	jmp    80105f30 <alltraps>

8010651c <vector12>:
.globl vector12
vector12:
  pushl $12
8010651c:	6a 0c                	push   $0xc
  jmp alltraps
8010651e:	e9 0d fa ff ff       	jmp    80105f30 <alltraps>

80106523 <vector13>:
.globl vector13
vector13:
  pushl $13
80106523:	6a 0d                	push   $0xd
  jmp alltraps
80106525:	e9 06 fa ff ff       	jmp    80105f30 <alltraps>

8010652a <vector14>:
.globl vector14
vector14:
  pushl $14
8010652a:	6a 0e                	push   $0xe
  jmp alltraps
8010652c:	e9 ff f9 ff ff       	jmp    80105f30 <alltraps>

80106531 <vector15>:
.globl vector15
vector15:
  pushl $0
80106531:	6a 00                	push   $0x0
  pushl $15
80106533:	6a 0f                	push   $0xf
  jmp alltraps
80106535:	e9 f6 f9 ff ff       	jmp    80105f30 <alltraps>

8010653a <vector16>:
.globl vector16
vector16:
  pushl $0
8010653a:	6a 00                	push   $0x0
  pushl $16
8010653c:	6a 10                	push   $0x10
  jmp alltraps
8010653e:	e9 ed f9 ff ff       	jmp    80105f30 <alltraps>

80106543 <vector17>:
.globl vector17
vector17:
  pushl $17
80106543:	6a 11                	push   $0x11
  jmp alltraps
80106545:	e9 e6 f9 ff ff       	jmp    80105f30 <alltraps>

8010654a <vector18>:
.globl vector18
vector18:
  pushl $0
8010654a:	6a 00                	push   $0x0
  pushl $18
8010654c:	6a 12                	push   $0x12
  jmp alltraps
8010654e:	e9 dd f9 ff ff       	jmp    80105f30 <alltraps>

80106553 <vector19>:
.globl vector19
vector19:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $19
80106555:	6a 13                	push   $0x13
  jmp alltraps
80106557:	e9 d4 f9 ff ff       	jmp    80105f30 <alltraps>

8010655c <vector20>:
.globl vector20
vector20:
  pushl $0
8010655c:	6a 00                	push   $0x0
  pushl $20
8010655e:	6a 14                	push   $0x14
  jmp alltraps
80106560:	e9 cb f9 ff ff       	jmp    80105f30 <alltraps>

80106565 <vector21>:
.globl vector21
vector21:
  pushl $0
80106565:	6a 00                	push   $0x0
  pushl $21
80106567:	6a 15                	push   $0x15
  jmp alltraps
80106569:	e9 c2 f9 ff ff       	jmp    80105f30 <alltraps>

8010656e <vector22>:
.globl vector22
vector22:
  pushl $0
8010656e:	6a 00                	push   $0x0
  pushl $22
80106570:	6a 16                	push   $0x16
  jmp alltraps
80106572:	e9 b9 f9 ff ff       	jmp    80105f30 <alltraps>

80106577 <vector23>:
.globl vector23
vector23:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $23
80106579:	6a 17                	push   $0x17
  jmp alltraps
8010657b:	e9 b0 f9 ff ff       	jmp    80105f30 <alltraps>

80106580 <vector24>:
.globl vector24
vector24:
  pushl $0
80106580:	6a 00                	push   $0x0
  pushl $24
80106582:	6a 18                	push   $0x18
  jmp alltraps
80106584:	e9 a7 f9 ff ff       	jmp    80105f30 <alltraps>

80106589 <vector25>:
.globl vector25
vector25:
  pushl $0
80106589:	6a 00                	push   $0x0
  pushl $25
8010658b:	6a 19                	push   $0x19
  jmp alltraps
8010658d:	e9 9e f9 ff ff       	jmp    80105f30 <alltraps>

80106592 <vector26>:
.globl vector26
vector26:
  pushl $0
80106592:	6a 00                	push   $0x0
  pushl $26
80106594:	6a 1a                	push   $0x1a
  jmp alltraps
80106596:	e9 95 f9 ff ff       	jmp    80105f30 <alltraps>

8010659b <vector27>:
.globl vector27
vector27:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $27
8010659d:	6a 1b                	push   $0x1b
  jmp alltraps
8010659f:	e9 8c f9 ff ff       	jmp    80105f30 <alltraps>

801065a4 <vector28>:
.globl vector28
vector28:
  pushl $0
801065a4:	6a 00                	push   $0x0
  pushl $28
801065a6:	6a 1c                	push   $0x1c
  jmp alltraps
801065a8:	e9 83 f9 ff ff       	jmp    80105f30 <alltraps>

801065ad <vector29>:
.globl vector29
vector29:
  pushl $0
801065ad:	6a 00                	push   $0x0
  pushl $29
801065af:	6a 1d                	push   $0x1d
  jmp alltraps
801065b1:	e9 7a f9 ff ff       	jmp    80105f30 <alltraps>

801065b6 <vector30>:
.globl vector30
vector30:
  pushl $0
801065b6:	6a 00                	push   $0x0
  pushl $30
801065b8:	6a 1e                	push   $0x1e
  jmp alltraps
801065ba:	e9 71 f9 ff ff       	jmp    80105f30 <alltraps>

801065bf <vector31>:
.globl vector31
vector31:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $31
801065c1:	6a 1f                	push   $0x1f
  jmp alltraps
801065c3:	e9 68 f9 ff ff       	jmp    80105f30 <alltraps>

801065c8 <vector32>:
.globl vector32
vector32:
  pushl $0
801065c8:	6a 00                	push   $0x0
  pushl $32
801065ca:	6a 20                	push   $0x20
  jmp alltraps
801065cc:	e9 5f f9 ff ff       	jmp    80105f30 <alltraps>

801065d1 <vector33>:
.globl vector33
vector33:
  pushl $0
801065d1:	6a 00                	push   $0x0
  pushl $33
801065d3:	6a 21                	push   $0x21
  jmp alltraps
801065d5:	e9 56 f9 ff ff       	jmp    80105f30 <alltraps>

801065da <vector34>:
.globl vector34
vector34:
  pushl $0
801065da:	6a 00                	push   $0x0
  pushl $34
801065dc:	6a 22                	push   $0x22
  jmp alltraps
801065de:	e9 4d f9 ff ff       	jmp    80105f30 <alltraps>

801065e3 <vector35>:
.globl vector35
vector35:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $35
801065e5:	6a 23                	push   $0x23
  jmp alltraps
801065e7:	e9 44 f9 ff ff       	jmp    80105f30 <alltraps>

801065ec <vector36>:
.globl vector36
vector36:
  pushl $0
801065ec:	6a 00                	push   $0x0
  pushl $36
801065ee:	6a 24                	push   $0x24
  jmp alltraps
801065f0:	e9 3b f9 ff ff       	jmp    80105f30 <alltraps>

801065f5 <vector37>:
.globl vector37
vector37:
  pushl $0
801065f5:	6a 00                	push   $0x0
  pushl $37
801065f7:	6a 25                	push   $0x25
  jmp alltraps
801065f9:	e9 32 f9 ff ff       	jmp    80105f30 <alltraps>

801065fe <vector38>:
.globl vector38
vector38:
  pushl $0
801065fe:	6a 00                	push   $0x0
  pushl $38
80106600:	6a 26                	push   $0x26
  jmp alltraps
80106602:	e9 29 f9 ff ff       	jmp    80105f30 <alltraps>

80106607 <vector39>:
.globl vector39
vector39:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $39
80106609:	6a 27                	push   $0x27
  jmp alltraps
8010660b:	e9 20 f9 ff ff       	jmp    80105f30 <alltraps>

80106610 <vector40>:
.globl vector40
vector40:
  pushl $0
80106610:	6a 00                	push   $0x0
  pushl $40
80106612:	6a 28                	push   $0x28
  jmp alltraps
80106614:	e9 17 f9 ff ff       	jmp    80105f30 <alltraps>

80106619 <vector41>:
.globl vector41
vector41:
  pushl $0
80106619:	6a 00                	push   $0x0
  pushl $41
8010661b:	6a 29                	push   $0x29
  jmp alltraps
8010661d:	e9 0e f9 ff ff       	jmp    80105f30 <alltraps>

80106622 <vector42>:
.globl vector42
vector42:
  pushl $0
80106622:	6a 00                	push   $0x0
  pushl $42
80106624:	6a 2a                	push   $0x2a
  jmp alltraps
80106626:	e9 05 f9 ff ff       	jmp    80105f30 <alltraps>

8010662b <vector43>:
.globl vector43
vector43:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $43
8010662d:	6a 2b                	push   $0x2b
  jmp alltraps
8010662f:	e9 fc f8 ff ff       	jmp    80105f30 <alltraps>

80106634 <vector44>:
.globl vector44
vector44:
  pushl $0
80106634:	6a 00                	push   $0x0
  pushl $44
80106636:	6a 2c                	push   $0x2c
  jmp alltraps
80106638:	e9 f3 f8 ff ff       	jmp    80105f30 <alltraps>

8010663d <vector45>:
.globl vector45
vector45:
  pushl $0
8010663d:	6a 00                	push   $0x0
  pushl $45
8010663f:	6a 2d                	push   $0x2d
  jmp alltraps
80106641:	e9 ea f8 ff ff       	jmp    80105f30 <alltraps>

80106646 <vector46>:
.globl vector46
vector46:
  pushl $0
80106646:	6a 00                	push   $0x0
  pushl $46
80106648:	6a 2e                	push   $0x2e
  jmp alltraps
8010664a:	e9 e1 f8 ff ff       	jmp    80105f30 <alltraps>

8010664f <vector47>:
.globl vector47
vector47:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $47
80106651:	6a 2f                	push   $0x2f
  jmp alltraps
80106653:	e9 d8 f8 ff ff       	jmp    80105f30 <alltraps>

80106658 <vector48>:
.globl vector48
vector48:
  pushl $0
80106658:	6a 00                	push   $0x0
  pushl $48
8010665a:	6a 30                	push   $0x30
  jmp alltraps
8010665c:	e9 cf f8 ff ff       	jmp    80105f30 <alltraps>

80106661 <vector49>:
.globl vector49
vector49:
  pushl $0
80106661:	6a 00                	push   $0x0
  pushl $49
80106663:	6a 31                	push   $0x31
  jmp alltraps
80106665:	e9 c6 f8 ff ff       	jmp    80105f30 <alltraps>

8010666a <vector50>:
.globl vector50
vector50:
  pushl $0
8010666a:	6a 00                	push   $0x0
  pushl $50
8010666c:	6a 32                	push   $0x32
  jmp alltraps
8010666e:	e9 bd f8 ff ff       	jmp    80105f30 <alltraps>

80106673 <vector51>:
.globl vector51
vector51:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $51
80106675:	6a 33                	push   $0x33
  jmp alltraps
80106677:	e9 b4 f8 ff ff       	jmp    80105f30 <alltraps>

8010667c <vector52>:
.globl vector52
vector52:
  pushl $0
8010667c:	6a 00                	push   $0x0
  pushl $52
8010667e:	6a 34                	push   $0x34
  jmp alltraps
80106680:	e9 ab f8 ff ff       	jmp    80105f30 <alltraps>

80106685 <vector53>:
.globl vector53
vector53:
  pushl $0
80106685:	6a 00                	push   $0x0
  pushl $53
80106687:	6a 35                	push   $0x35
  jmp alltraps
80106689:	e9 a2 f8 ff ff       	jmp    80105f30 <alltraps>

8010668e <vector54>:
.globl vector54
vector54:
  pushl $0
8010668e:	6a 00                	push   $0x0
  pushl $54
80106690:	6a 36                	push   $0x36
  jmp alltraps
80106692:	e9 99 f8 ff ff       	jmp    80105f30 <alltraps>

80106697 <vector55>:
.globl vector55
vector55:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $55
80106699:	6a 37                	push   $0x37
  jmp alltraps
8010669b:	e9 90 f8 ff ff       	jmp    80105f30 <alltraps>

801066a0 <vector56>:
.globl vector56
vector56:
  pushl $0
801066a0:	6a 00                	push   $0x0
  pushl $56
801066a2:	6a 38                	push   $0x38
  jmp alltraps
801066a4:	e9 87 f8 ff ff       	jmp    80105f30 <alltraps>

801066a9 <vector57>:
.globl vector57
vector57:
  pushl $0
801066a9:	6a 00                	push   $0x0
  pushl $57
801066ab:	6a 39                	push   $0x39
  jmp alltraps
801066ad:	e9 7e f8 ff ff       	jmp    80105f30 <alltraps>

801066b2 <vector58>:
.globl vector58
vector58:
  pushl $0
801066b2:	6a 00                	push   $0x0
  pushl $58
801066b4:	6a 3a                	push   $0x3a
  jmp alltraps
801066b6:	e9 75 f8 ff ff       	jmp    80105f30 <alltraps>

801066bb <vector59>:
.globl vector59
vector59:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $59
801066bd:	6a 3b                	push   $0x3b
  jmp alltraps
801066bf:	e9 6c f8 ff ff       	jmp    80105f30 <alltraps>

801066c4 <vector60>:
.globl vector60
vector60:
  pushl $0
801066c4:	6a 00                	push   $0x0
  pushl $60
801066c6:	6a 3c                	push   $0x3c
  jmp alltraps
801066c8:	e9 63 f8 ff ff       	jmp    80105f30 <alltraps>

801066cd <vector61>:
.globl vector61
vector61:
  pushl $0
801066cd:	6a 00                	push   $0x0
  pushl $61
801066cf:	6a 3d                	push   $0x3d
  jmp alltraps
801066d1:	e9 5a f8 ff ff       	jmp    80105f30 <alltraps>

801066d6 <vector62>:
.globl vector62
vector62:
  pushl $0
801066d6:	6a 00                	push   $0x0
  pushl $62
801066d8:	6a 3e                	push   $0x3e
  jmp alltraps
801066da:	e9 51 f8 ff ff       	jmp    80105f30 <alltraps>

801066df <vector63>:
.globl vector63
vector63:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $63
801066e1:	6a 3f                	push   $0x3f
  jmp alltraps
801066e3:	e9 48 f8 ff ff       	jmp    80105f30 <alltraps>

801066e8 <vector64>:
.globl vector64
vector64:
  pushl $0
801066e8:	6a 00                	push   $0x0
  pushl $64
801066ea:	6a 40                	push   $0x40
  jmp alltraps
801066ec:	e9 3f f8 ff ff       	jmp    80105f30 <alltraps>

801066f1 <vector65>:
.globl vector65
vector65:
  pushl $0
801066f1:	6a 00                	push   $0x0
  pushl $65
801066f3:	6a 41                	push   $0x41
  jmp alltraps
801066f5:	e9 36 f8 ff ff       	jmp    80105f30 <alltraps>

801066fa <vector66>:
.globl vector66
vector66:
  pushl $0
801066fa:	6a 00                	push   $0x0
  pushl $66
801066fc:	6a 42                	push   $0x42
  jmp alltraps
801066fe:	e9 2d f8 ff ff       	jmp    80105f30 <alltraps>

80106703 <vector67>:
.globl vector67
vector67:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $67
80106705:	6a 43                	push   $0x43
  jmp alltraps
80106707:	e9 24 f8 ff ff       	jmp    80105f30 <alltraps>

8010670c <vector68>:
.globl vector68
vector68:
  pushl $0
8010670c:	6a 00                	push   $0x0
  pushl $68
8010670e:	6a 44                	push   $0x44
  jmp alltraps
80106710:	e9 1b f8 ff ff       	jmp    80105f30 <alltraps>

80106715 <vector69>:
.globl vector69
vector69:
  pushl $0
80106715:	6a 00                	push   $0x0
  pushl $69
80106717:	6a 45                	push   $0x45
  jmp alltraps
80106719:	e9 12 f8 ff ff       	jmp    80105f30 <alltraps>

8010671e <vector70>:
.globl vector70
vector70:
  pushl $0
8010671e:	6a 00                	push   $0x0
  pushl $70
80106720:	6a 46                	push   $0x46
  jmp alltraps
80106722:	e9 09 f8 ff ff       	jmp    80105f30 <alltraps>

80106727 <vector71>:
.globl vector71
vector71:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $71
80106729:	6a 47                	push   $0x47
  jmp alltraps
8010672b:	e9 00 f8 ff ff       	jmp    80105f30 <alltraps>

80106730 <vector72>:
.globl vector72
vector72:
  pushl $0
80106730:	6a 00                	push   $0x0
  pushl $72
80106732:	6a 48                	push   $0x48
  jmp alltraps
80106734:	e9 f7 f7 ff ff       	jmp    80105f30 <alltraps>

80106739 <vector73>:
.globl vector73
vector73:
  pushl $0
80106739:	6a 00                	push   $0x0
  pushl $73
8010673b:	6a 49                	push   $0x49
  jmp alltraps
8010673d:	e9 ee f7 ff ff       	jmp    80105f30 <alltraps>

80106742 <vector74>:
.globl vector74
vector74:
  pushl $0
80106742:	6a 00                	push   $0x0
  pushl $74
80106744:	6a 4a                	push   $0x4a
  jmp alltraps
80106746:	e9 e5 f7 ff ff       	jmp    80105f30 <alltraps>

8010674b <vector75>:
.globl vector75
vector75:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $75
8010674d:	6a 4b                	push   $0x4b
  jmp alltraps
8010674f:	e9 dc f7 ff ff       	jmp    80105f30 <alltraps>

80106754 <vector76>:
.globl vector76
vector76:
  pushl $0
80106754:	6a 00                	push   $0x0
  pushl $76
80106756:	6a 4c                	push   $0x4c
  jmp alltraps
80106758:	e9 d3 f7 ff ff       	jmp    80105f30 <alltraps>

8010675d <vector77>:
.globl vector77
vector77:
  pushl $0
8010675d:	6a 00                	push   $0x0
  pushl $77
8010675f:	6a 4d                	push   $0x4d
  jmp alltraps
80106761:	e9 ca f7 ff ff       	jmp    80105f30 <alltraps>

80106766 <vector78>:
.globl vector78
vector78:
  pushl $0
80106766:	6a 00                	push   $0x0
  pushl $78
80106768:	6a 4e                	push   $0x4e
  jmp alltraps
8010676a:	e9 c1 f7 ff ff       	jmp    80105f30 <alltraps>

8010676f <vector79>:
.globl vector79
vector79:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $79
80106771:	6a 4f                	push   $0x4f
  jmp alltraps
80106773:	e9 b8 f7 ff ff       	jmp    80105f30 <alltraps>

80106778 <vector80>:
.globl vector80
vector80:
  pushl $0
80106778:	6a 00                	push   $0x0
  pushl $80
8010677a:	6a 50                	push   $0x50
  jmp alltraps
8010677c:	e9 af f7 ff ff       	jmp    80105f30 <alltraps>

80106781 <vector81>:
.globl vector81
vector81:
  pushl $0
80106781:	6a 00                	push   $0x0
  pushl $81
80106783:	6a 51                	push   $0x51
  jmp alltraps
80106785:	e9 a6 f7 ff ff       	jmp    80105f30 <alltraps>

8010678a <vector82>:
.globl vector82
vector82:
  pushl $0
8010678a:	6a 00                	push   $0x0
  pushl $82
8010678c:	6a 52                	push   $0x52
  jmp alltraps
8010678e:	e9 9d f7 ff ff       	jmp    80105f30 <alltraps>

80106793 <vector83>:
.globl vector83
vector83:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $83
80106795:	6a 53                	push   $0x53
  jmp alltraps
80106797:	e9 94 f7 ff ff       	jmp    80105f30 <alltraps>

8010679c <vector84>:
.globl vector84
vector84:
  pushl $0
8010679c:	6a 00                	push   $0x0
  pushl $84
8010679e:	6a 54                	push   $0x54
  jmp alltraps
801067a0:	e9 8b f7 ff ff       	jmp    80105f30 <alltraps>

801067a5 <vector85>:
.globl vector85
vector85:
  pushl $0
801067a5:	6a 00                	push   $0x0
  pushl $85
801067a7:	6a 55                	push   $0x55
  jmp alltraps
801067a9:	e9 82 f7 ff ff       	jmp    80105f30 <alltraps>

801067ae <vector86>:
.globl vector86
vector86:
  pushl $0
801067ae:	6a 00                	push   $0x0
  pushl $86
801067b0:	6a 56                	push   $0x56
  jmp alltraps
801067b2:	e9 79 f7 ff ff       	jmp    80105f30 <alltraps>

801067b7 <vector87>:
.globl vector87
vector87:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $87
801067b9:	6a 57                	push   $0x57
  jmp alltraps
801067bb:	e9 70 f7 ff ff       	jmp    80105f30 <alltraps>

801067c0 <vector88>:
.globl vector88
vector88:
  pushl $0
801067c0:	6a 00                	push   $0x0
  pushl $88
801067c2:	6a 58                	push   $0x58
  jmp alltraps
801067c4:	e9 67 f7 ff ff       	jmp    80105f30 <alltraps>

801067c9 <vector89>:
.globl vector89
vector89:
  pushl $0
801067c9:	6a 00                	push   $0x0
  pushl $89
801067cb:	6a 59                	push   $0x59
  jmp alltraps
801067cd:	e9 5e f7 ff ff       	jmp    80105f30 <alltraps>

801067d2 <vector90>:
.globl vector90
vector90:
  pushl $0
801067d2:	6a 00                	push   $0x0
  pushl $90
801067d4:	6a 5a                	push   $0x5a
  jmp alltraps
801067d6:	e9 55 f7 ff ff       	jmp    80105f30 <alltraps>

801067db <vector91>:
.globl vector91
vector91:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $91
801067dd:	6a 5b                	push   $0x5b
  jmp alltraps
801067df:	e9 4c f7 ff ff       	jmp    80105f30 <alltraps>

801067e4 <vector92>:
.globl vector92
vector92:
  pushl $0
801067e4:	6a 00                	push   $0x0
  pushl $92
801067e6:	6a 5c                	push   $0x5c
  jmp alltraps
801067e8:	e9 43 f7 ff ff       	jmp    80105f30 <alltraps>

801067ed <vector93>:
.globl vector93
vector93:
  pushl $0
801067ed:	6a 00                	push   $0x0
  pushl $93
801067ef:	6a 5d                	push   $0x5d
  jmp alltraps
801067f1:	e9 3a f7 ff ff       	jmp    80105f30 <alltraps>

801067f6 <vector94>:
.globl vector94
vector94:
  pushl $0
801067f6:	6a 00                	push   $0x0
  pushl $94
801067f8:	6a 5e                	push   $0x5e
  jmp alltraps
801067fa:	e9 31 f7 ff ff       	jmp    80105f30 <alltraps>

801067ff <vector95>:
.globl vector95
vector95:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $95
80106801:	6a 5f                	push   $0x5f
  jmp alltraps
80106803:	e9 28 f7 ff ff       	jmp    80105f30 <alltraps>

80106808 <vector96>:
.globl vector96
vector96:
  pushl $0
80106808:	6a 00                	push   $0x0
  pushl $96
8010680a:	6a 60                	push   $0x60
  jmp alltraps
8010680c:	e9 1f f7 ff ff       	jmp    80105f30 <alltraps>

80106811 <vector97>:
.globl vector97
vector97:
  pushl $0
80106811:	6a 00                	push   $0x0
  pushl $97
80106813:	6a 61                	push   $0x61
  jmp alltraps
80106815:	e9 16 f7 ff ff       	jmp    80105f30 <alltraps>

8010681a <vector98>:
.globl vector98
vector98:
  pushl $0
8010681a:	6a 00                	push   $0x0
  pushl $98
8010681c:	6a 62                	push   $0x62
  jmp alltraps
8010681e:	e9 0d f7 ff ff       	jmp    80105f30 <alltraps>

80106823 <vector99>:
.globl vector99
vector99:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $99
80106825:	6a 63                	push   $0x63
  jmp alltraps
80106827:	e9 04 f7 ff ff       	jmp    80105f30 <alltraps>

8010682c <vector100>:
.globl vector100
vector100:
  pushl $0
8010682c:	6a 00                	push   $0x0
  pushl $100
8010682e:	6a 64                	push   $0x64
  jmp alltraps
80106830:	e9 fb f6 ff ff       	jmp    80105f30 <alltraps>

80106835 <vector101>:
.globl vector101
vector101:
  pushl $0
80106835:	6a 00                	push   $0x0
  pushl $101
80106837:	6a 65                	push   $0x65
  jmp alltraps
80106839:	e9 f2 f6 ff ff       	jmp    80105f30 <alltraps>

8010683e <vector102>:
.globl vector102
vector102:
  pushl $0
8010683e:	6a 00                	push   $0x0
  pushl $102
80106840:	6a 66                	push   $0x66
  jmp alltraps
80106842:	e9 e9 f6 ff ff       	jmp    80105f30 <alltraps>

80106847 <vector103>:
.globl vector103
vector103:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $103
80106849:	6a 67                	push   $0x67
  jmp alltraps
8010684b:	e9 e0 f6 ff ff       	jmp    80105f30 <alltraps>

80106850 <vector104>:
.globl vector104
vector104:
  pushl $0
80106850:	6a 00                	push   $0x0
  pushl $104
80106852:	6a 68                	push   $0x68
  jmp alltraps
80106854:	e9 d7 f6 ff ff       	jmp    80105f30 <alltraps>

80106859 <vector105>:
.globl vector105
vector105:
  pushl $0
80106859:	6a 00                	push   $0x0
  pushl $105
8010685b:	6a 69                	push   $0x69
  jmp alltraps
8010685d:	e9 ce f6 ff ff       	jmp    80105f30 <alltraps>

80106862 <vector106>:
.globl vector106
vector106:
  pushl $0
80106862:	6a 00                	push   $0x0
  pushl $106
80106864:	6a 6a                	push   $0x6a
  jmp alltraps
80106866:	e9 c5 f6 ff ff       	jmp    80105f30 <alltraps>

8010686b <vector107>:
.globl vector107
vector107:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $107
8010686d:	6a 6b                	push   $0x6b
  jmp alltraps
8010686f:	e9 bc f6 ff ff       	jmp    80105f30 <alltraps>

80106874 <vector108>:
.globl vector108
vector108:
  pushl $0
80106874:	6a 00                	push   $0x0
  pushl $108
80106876:	6a 6c                	push   $0x6c
  jmp alltraps
80106878:	e9 b3 f6 ff ff       	jmp    80105f30 <alltraps>

8010687d <vector109>:
.globl vector109
vector109:
  pushl $0
8010687d:	6a 00                	push   $0x0
  pushl $109
8010687f:	6a 6d                	push   $0x6d
  jmp alltraps
80106881:	e9 aa f6 ff ff       	jmp    80105f30 <alltraps>

80106886 <vector110>:
.globl vector110
vector110:
  pushl $0
80106886:	6a 00                	push   $0x0
  pushl $110
80106888:	6a 6e                	push   $0x6e
  jmp alltraps
8010688a:	e9 a1 f6 ff ff       	jmp    80105f30 <alltraps>

8010688f <vector111>:
.globl vector111
vector111:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $111
80106891:	6a 6f                	push   $0x6f
  jmp alltraps
80106893:	e9 98 f6 ff ff       	jmp    80105f30 <alltraps>

80106898 <vector112>:
.globl vector112
vector112:
  pushl $0
80106898:	6a 00                	push   $0x0
  pushl $112
8010689a:	6a 70                	push   $0x70
  jmp alltraps
8010689c:	e9 8f f6 ff ff       	jmp    80105f30 <alltraps>

801068a1 <vector113>:
.globl vector113
vector113:
  pushl $0
801068a1:	6a 00                	push   $0x0
  pushl $113
801068a3:	6a 71                	push   $0x71
  jmp alltraps
801068a5:	e9 86 f6 ff ff       	jmp    80105f30 <alltraps>

801068aa <vector114>:
.globl vector114
vector114:
  pushl $0
801068aa:	6a 00                	push   $0x0
  pushl $114
801068ac:	6a 72                	push   $0x72
  jmp alltraps
801068ae:	e9 7d f6 ff ff       	jmp    80105f30 <alltraps>

801068b3 <vector115>:
.globl vector115
vector115:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $115
801068b5:	6a 73                	push   $0x73
  jmp alltraps
801068b7:	e9 74 f6 ff ff       	jmp    80105f30 <alltraps>

801068bc <vector116>:
.globl vector116
vector116:
  pushl $0
801068bc:	6a 00                	push   $0x0
  pushl $116
801068be:	6a 74                	push   $0x74
  jmp alltraps
801068c0:	e9 6b f6 ff ff       	jmp    80105f30 <alltraps>

801068c5 <vector117>:
.globl vector117
vector117:
  pushl $0
801068c5:	6a 00                	push   $0x0
  pushl $117
801068c7:	6a 75                	push   $0x75
  jmp alltraps
801068c9:	e9 62 f6 ff ff       	jmp    80105f30 <alltraps>

801068ce <vector118>:
.globl vector118
vector118:
  pushl $0
801068ce:	6a 00                	push   $0x0
  pushl $118
801068d0:	6a 76                	push   $0x76
  jmp alltraps
801068d2:	e9 59 f6 ff ff       	jmp    80105f30 <alltraps>

801068d7 <vector119>:
.globl vector119
vector119:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $119
801068d9:	6a 77                	push   $0x77
  jmp alltraps
801068db:	e9 50 f6 ff ff       	jmp    80105f30 <alltraps>

801068e0 <vector120>:
.globl vector120
vector120:
  pushl $0
801068e0:	6a 00                	push   $0x0
  pushl $120
801068e2:	6a 78                	push   $0x78
  jmp alltraps
801068e4:	e9 47 f6 ff ff       	jmp    80105f30 <alltraps>

801068e9 <vector121>:
.globl vector121
vector121:
  pushl $0
801068e9:	6a 00                	push   $0x0
  pushl $121
801068eb:	6a 79                	push   $0x79
  jmp alltraps
801068ed:	e9 3e f6 ff ff       	jmp    80105f30 <alltraps>

801068f2 <vector122>:
.globl vector122
vector122:
  pushl $0
801068f2:	6a 00                	push   $0x0
  pushl $122
801068f4:	6a 7a                	push   $0x7a
  jmp alltraps
801068f6:	e9 35 f6 ff ff       	jmp    80105f30 <alltraps>

801068fb <vector123>:
.globl vector123
vector123:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $123
801068fd:	6a 7b                	push   $0x7b
  jmp alltraps
801068ff:	e9 2c f6 ff ff       	jmp    80105f30 <alltraps>

80106904 <vector124>:
.globl vector124
vector124:
  pushl $0
80106904:	6a 00                	push   $0x0
  pushl $124
80106906:	6a 7c                	push   $0x7c
  jmp alltraps
80106908:	e9 23 f6 ff ff       	jmp    80105f30 <alltraps>

8010690d <vector125>:
.globl vector125
vector125:
  pushl $0
8010690d:	6a 00                	push   $0x0
  pushl $125
8010690f:	6a 7d                	push   $0x7d
  jmp alltraps
80106911:	e9 1a f6 ff ff       	jmp    80105f30 <alltraps>

80106916 <vector126>:
.globl vector126
vector126:
  pushl $0
80106916:	6a 00                	push   $0x0
  pushl $126
80106918:	6a 7e                	push   $0x7e
  jmp alltraps
8010691a:	e9 11 f6 ff ff       	jmp    80105f30 <alltraps>

8010691f <vector127>:
.globl vector127
vector127:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $127
80106921:	6a 7f                	push   $0x7f
  jmp alltraps
80106923:	e9 08 f6 ff ff       	jmp    80105f30 <alltraps>

80106928 <vector128>:
.globl vector128
vector128:
  pushl $0
80106928:	6a 00                	push   $0x0
  pushl $128
8010692a:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010692f:	e9 fc f5 ff ff       	jmp    80105f30 <alltraps>

80106934 <vector129>:
.globl vector129
vector129:
  pushl $0
80106934:	6a 00                	push   $0x0
  pushl $129
80106936:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010693b:	e9 f0 f5 ff ff       	jmp    80105f30 <alltraps>

80106940 <vector130>:
.globl vector130
vector130:
  pushl $0
80106940:	6a 00                	push   $0x0
  pushl $130
80106942:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106947:	e9 e4 f5 ff ff       	jmp    80105f30 <alltraps>

8010694c <vector131>:
.globl vector131
vector131:
  pushl $0
8010694c:	6a 00                	push   $0x0
  pushl $131
8010694e:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106953:	e9 d8 f5 ff ff       	jmp    80105f30 <alltraps>

80106958 <vector132>:
.globl vector132
vector132:
  pushl $0
80106958:	6a 00                	push   $0x0
  pushl $132
8010695a:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010695f:	e9 cc f5 ff ff       	jmp    80105f30 <alltraps>

80106964 <vector133>:
.globl vector133
vector133:
  pushl $0
80106964:	6a 00                	push   $0x0
  pushl $133
80106966:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010696b:	e9 c0 f5 ff ff       	jmp    80105f30 <alltraps>

80106970 <vector134>:
.globl vector134
vector134:
  pushl $0
80106970:	6a 00                	push   $0x0
  pushl $134
80106972:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106977:	e9 b4 f5 ff ff       	jmp    80105f30 <alltraps>

8010697c <vector135>:
.globl vector135
vector135:
  pushl $0
8010697c:	6a 00                	push   $0x0
  pushl $135
8010697e:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106983:	e9 a8 f5 ff ff       	jmp    80105f30 <alltraps>

80106988 <vector136>:
.globl vector136
vector136:
  pushl $0
80106988:	6a 00                	push   $0x0
  pushl $136
8010698a:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010698f:	e9 9c f5 ff ff       	jmp    80105f30 <alltraps>

80106994 <vector137>:
.globl vector137
vector137:
  pushl $0
80106994:	6a 00                	push   $0x0
  pushl $137
80106996:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010699b:	e9 90 f5 ff ff       	jmp    80105f30 <alltraps>

801069a0 <vector138>:
.globl vector138
vector138:
  pushl $0
801069a0:	6a 00                	push   $0x0
  pushl $138
801069a2:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801069a7:	e9 84 f5 ff ff       	jmp    80105f30 <alltraps>

801069ac <vector139>:
.globl vector139
vector139:
  pushl $0
801069ac:	6a 00                	push   $0x0
  pushl $139
801069ae:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801069b3:	e9 78 f5 ff ff       	jmp    80105f30 <alltraps>

801069b8 <vector140>:
.globl vector140
vector140:
  pushl $0
801069b8:	6a 00                	push   $0x0
  pushl $140
801069ba:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801069bf:	e9 6c f5 ff ff       	jmp    80105f30 <alltraps>

801069c4 <vector141>:
.globl vector141
vector141:
  pushl $0
801069c4:	6a 00                	push   $0x0
  pushl $141
801069c6:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801069cb:	e9 60 f5 ff ff       	jmp    80105f30 <alltraps>

801069d0 <vector142>:
.globl vector142
vector142:
  pushl $0
801069d0:	6a 00                	push   $0x0
  pushl $142
801069d2:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801069d7:	e9 54 f5 ff ff       	jmp    80105f30 <alltraps>

801069dc <vector143>:
.globl vector143
vector143:
  pushl $0
801069dc:	6a 00                	push   $0x0
  pushl $143
801069de:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801069e3:	e9 48 f5 ff ff       	jmp    80105f30 <alltraps>

801069e8 <vector144>:
.globl vector144
vector144:
  pushl $0
801069e8:	6a 00                	push   $0x0
  pushl $144
801069ea:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801069ef:	e9 3c f5 ff ff       	jmp    80105f30 <alltraps>

801069f4 <vector145>:
.globl vector145
vector145:
  pushl $0
801069f4:	6a 00                	push   $0x0
  pushl $145
801069f6:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801069fb:	e9 30 f5 ff ff       	jmp    80105f30 <alltraps>

80106a00 <vector146>:
.globl vector146
vector146:
  pushl $0
80106a00:	6a 00                	push   $0x0
  pushl $146
80106a02:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106a07:	e9 24 f5 ff ff       	jmp    80105f30 <alltraps>

80106a0c <vector147>:
.globl vector147
vector147:
  pushl $0
80106a0c:	6a 00                	push   $0x0
  pushl $147
80106a0e:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106a13:	e9 18 f5 ff ff       	jmp    80105f30 <alltraps>

80106a18 <vector148>:
.globl vector148
vector148:
  pushl $0
80106a18:	6a 00                	push   $0x0
  pushl $148
80106a1a:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106a1f:	e9 0c f5 ff ff       	jmp    80105f30 <alltraps>

80106a24 <vector149>:
.globl vector149
vector149:
  pushl $0
80106a24:	6a 00                	push   $0x0
  pushl $149
80106a26:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106a2b:	e9 00 f5 ff ff       	jmp    80105f30 <alltraps>

80106a30 <vector150>:
.globl vector150
vector150:
  pushl $0
80106a30:	6a 00                	push   $0x0
  pushl $150
80106a32:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106a37:	e9 f4 f4 ff ff       	jmp    80105f30 <alltraps>

80106a3c <vector151>:
.globl vector151
vector151:
  pushl $0
80106a3c:	6a 00                	push   $0x0
  pushl $151
80106a3e:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106a43:	e9 e8 f4 ff ff       	jmp    80105f30 <alltraps>

80106a48 <vector152>:
.globl vector152
vector152:
  pushl $0
80106a48:	6a 00                	push   $0x0
  pushl $152
80106a4a:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106a4f:	e9 dc f4 ff ff       	jmp    80105f30 <alltraps>

80106a54 <vector153>:
.globl vector153
vector153:
  pushl $0
80106a54:	6a 00                	push   $0x0
  pushl $153
80106a56:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106a5b:	e9 d0 f4 ff ff       	jmp    80105f30 <alltraps>

80106a60 <vector154>:
.globl vector154
vector154:
  pushl $0
80106a60:	6a 00                	push   $0x0
  pushl $154
80106a62:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106a67:	e9 c4 f4 ff ff       	jmp    80105f30 <alltraps>

80106a6c <vector155>:
.globl vector155
vector155:
  pushl $0
80106a6c:	6a 00                	push   $0x0
  pushl $155
80106a6e:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106a73:	e9 b8 f4 ff ff       	jmp    80105f30 <alltraps>

80106a78 <vector156>:
.globl vector156
vector156:
  pushl $0
80106a78:	6a 00                	push   $0x0
  pushl $156
80106a7a:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106a7f:	e9 ac f4 ff ff       	jmp    80105f30 <alltraps>

80106a84 <vector157>:
.globl vector157
vector157:
  pushl $0
80106a84:	6a 00                	push   $0x0
  pushl $157
80106a86:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106a8b:	e9 a0 f4 ff ff       	jmp    80105f30 <alltraps>

80106a90 <vector158>:
.globl vector158
vector158:
  pushl $0
80106a90:	6a 00                	push   $0x0
  pushl $158
80106a92:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106a97:	e9 94 f4 ff ff       	jmp    80105f30 <alltraps>

80106a9c <vector159>:
.globl vector159
vector159:
  pushl $0
80106a9c:	6a 00                	push   $0x0
  pushl $159
80106a9e:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106aa3:	e9 88 f4 ff ff       	jmp    80105f30 <alltraps>

80106aa8 <vector160>:
.globl vector160
vector160:
  pushl $0
80106aa8:	6a 00                	push   $0x0
  pushl $160
80106aaa:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106aaf:	e9 7c f4 ff ff       	jmp    80105f30 <alltraps>

80106ab4 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ab4:	6a 00                	push   $0x0
  pushl $161
80106ab6:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106abb:	e9 70 f4 ff ff       	jmp    80105f30 <alltraps>

80106ac0 <vector162>:
.globl vector162
vector162:
  pushl $0
80106ac0:	6a 00                	push   $0x0
  pushl $162
80106ac2:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106ac7:	e9 64 f4 ff ff       	jmp    80105f30 <alltraps>

80106acc <vector163>:
.globl vector163
vector163:
  pushl $0
80106acc:	6a 00                	push   $0x0
  pushl $163
80106ace:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106ad3:	e9 58 f4 ff ff       	jmp    80105f30 <alltraps>

80106ad8 <vector164>:
.globl vector164
vector164:
  pushl $0
80106ad8:	6a 00                	push   $0x0
  pushl $164
80106ada:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106adf:	e9 4c f4 ff ff       	jmp    80105f30 <alltraps>

80106ae4 <vector165>:
.globl vector165
vector165:
  pushl $0
80106ae4:	6a 00                	push   $0x0
  pushl $165
80106ae6:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106aeb:	e9 40 f4 ff ff       	jmp    80105f30 <alltraps>

80106af0 <vector166>:
.globl vector166
vector166:
  pushl $0
80106af0:	6a 00                	push   $0x0
  pushl $166
80106af2:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106af7:	e9 34 f4 ff ff       	jmp    80105f30 <alltraps>

80106afc <vector167>:
.globl vector167
vector167:
  pushl $0
80106afc:	6a 00                	push   $0x0
  pushl $167
80106afe:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106b03:	e9 28 f4 ff ff       	jmp    80105f30 <alltraps>

80106b08 <vector168>:
.globl vector168
vector168:
  pushl $0
80106b08:	6a 00                	push   $0x0
  pushl $168
80106b0a:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106b0f:	e9 1c f4 ff ff       	jmp    80105f30 <alltraps>

80106b14 <vector169>:
.globl vector169
vector169:
  pushl $0
80106b14:	6a 00                	push   $0x0
  pushl $169
80106b16:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106b1b:	e9 10 f4 ff ff       	jmp    80105f30 <alltraps>

80106b20 <vector170>:
.globl vector170
vector170:
  pushl $0
80106b20:	6a 00                	push   $0x0
  pushl $170
80106b22:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106b27:	e9 04 f4 ff ff       	jmp    80105f30 <alltraps>

80106b2c <vector171>:
.globl vector171
vector171:
  pushl $0
80106b2c:	6a 00                	push   $0x0
  pushl $171
80106b2e:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106b33:	e9 f8 f3 ff ff       	jmp    80105f30 <alltraps>

80106b38 <vector172>:
.globl vector172
vector172:
  pushl $0
80106b38:	6a 00                	push   $0x0
  pushl $172
80106b3a:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106b3f:	e9 ec f3 ff ff       	jmp    80105f30 <alltraps>

80106b44 <vector173>:
.globl vector173
vector173:
  pushl $0
80106b44:	6a 00                	push   $0x0
  pushl $173
80106b46:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106b4b:	e9 e0 f3 ff ff       	jmp    80105f30 <alltraps>

80106b50 <vector174>:
.globl vector174
vector174:
  pushl $0
80106b50:	6a 00                	push   $0x0
  pushl $174
80106b52:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106b57:	e9 d4 f3 ff ff       	jmp    80105f30 <alltraps>

80106b5c <vector175>:
.globl vector175
vector175:
  pushl $0
80106b5c:	6a 00                	push   $0x0
  pushl $175
80106b5e:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106b63:	e9 c8 f3 ff ff       	jmp    80105f30 <alltraps>

80106b68 <vector176>:
.globl vector176
vector176:
  pushl $0
80106b68:	6a 00                	push   $0x0
  pushl $176
80106b6a:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106b6f:	e9 bc f3 ff ff       	jmp    80105f30 <alltraps>

80106b74 <vector177>:
.globl vector177
vector177:
  pushl $0
80106b74:	6a 00                	push   $0x0
  pushl $177
80106b76:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106b7b:	e9 b0 f3 ff ff       	jmp    80105f30 <alltraps>

80106b80 <vector178>:
.globl vector178
vector178:
  pushl $0
80106b80:	6a 00                	push   $0x0
  pushl $178
80106b82:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106b87:	e9 a4 f3 ff ff       	jmp    80105f30 <alltraps>

80106b8c <vector179>:
.globl vector179
vector179:
  pushl $0
80106b8c:	6a 00                	push   $0x0
  pushl $179
80106b8e:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106b93:	e9 98 f3 ff ff       	jmp    80105f30 <alltraps>

80106b98 <vector180>:
.globl vector180
vector180:
  pushl $0
80106b98:	6a 00                	push   $0x0
  pushl $180
80106b9a:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106b9f:	e9 8c f3 ff ff       	jmp    80105f30 <alltraps>

80106ba4 <vector181>:
.globl vector181
vector181:
  pushl $0
80106ba4:	6a 00                	push   $0x0
  pushl $181
80106ba6:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106bab:	e9 80 f3 ff ff       	jmp    80105f30 <alltraps>

80106bb0 <vector182>:
.globl vector182
vector182:
  pushl $0
80106bb0:	6a 00                	push   $0x0
  pushl $182
80106bb2:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106bb7:	e9 74 f3 ff ff       	jmp    80105f30 <alltraps>

80106bbc <vector183>:
.globl vector183
vector183:
  pushl $0
80106bbc:	6a 00                	push   $0x0
  pushl $183
80106bbe:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106bc3:	e9 68 f3 ff ff       	jmp    80105f30 <alltraps>

80106bc8 <vector184>:
.globl vector184
vector184:
  pushl $0
80106bc8:	6a 00                	push   $0x0
  pushl $184
80106bca:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106bcf:	e9 5c f3 ff ff       	jmp    80105f30 <alltraps>

80106bd4 <vector185>:
.globl vector185
vector185:
  pushl $0
80106bd4:	6a 00                	push   $0x0
  pushl $185
80106bd6:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106bdb:	e9 50 f3 ff ff       	jmp    80105f30 <alltraps>

80106be0 <vector186>:
.globl vector186
vector186:
  pushl $0
80106be0:	6a 00                	push   $0x0
  pushl $186
80106be2:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106be7:	e9 44 f3 ff ff       	jmp    80105f30 <alltraps>

80106bec <vector187>:
.globl vector187
vector187:
  pushl $0
80106bec:	6a 00                	push   $0x0
  pushl $187
80106bee:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106bf3:	e9 38 f3 ff ff       	jmp    80105f30 <alltraps>

80106bf8 <vector188>:
.globl vector188
vector188:
  pushl $0
80106bf8:	6a 00                	push   $0x0
  pushl $188
80106bfa:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106bff:	e9 2c f3 ff ff       	jmp    80105f30 <alltraps>

80106c04 <vector189>:
.globl vector189
vector189:
  pushl $0
80106c04:	6a 00                	push   $0x0
  pushl $189
80106c06:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106c0b:	e9 20 f3 ff ff       	jmp    80105f30 <alltraps>

80106c10 <vector190>:
.globl vector190
vector190:
  pushl $0
80106c10:	6a 00                	push   $0x0
  pushl $190
80106c12:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106c17:	e9 14 f3 ff ff       	jmp    80105f30 <alltraps>

80106c1c <vector191>:
.globl vector191
vector191:
  pushl $0
80106c1c:	6a 00                	push   $0x0
  pushl $191
80106c1e:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106c23:	e9 08 f3 ff ff       	jmp    80105f30 <alltraps>

80106c28 <vector192>:
.globl vector192
vector192:
  pushl $0
80106c28:	6a 00                	push   $0x0
  pushl $192
80106c2a:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106c2f:	e9 fc f2 ff ff       	jmp    80105f30 <alltraps>

80106c34 <vector193>:
.globl vector193
vector193:
  pushl $0
80106c34:	6a 00                	push   $0x0
  pushl $193
80106c36:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106c3b:	e9 f0 f2 ff ff       	jmp    80105f30 <alltraps>

80106c40 <vector194>:
.globl vector194
vector194:
  pushl $0
80106c40:	6a 00                	push   $0x0
  pushl $194
80106c42:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106c47:	e9 e4 f2 ff ff       	jmp    80105f30 <alltraps>

80106c4c <vector195>:
.globl vector195
vector195:
  pushl $0
80106c4c:	6a 00                	push   $0x0
  pushl $195
80106c4e:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106c53:	e9 d8 f2 ff ff       	jmp    80105f30 <alltraps>

80106c58 <vector196>:
.globl vector196
vector196:
  pushl $0
80106c58:	6a 00                	push   $0x0
  pushl $196
80106c5a:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106c5f:	e9 cc f2 ff ff       	jmp    80105f30 <alltraps>

80106c64 <vector197>:
.globl vector197
vector197:
  pushl $0
80106c64:	6a 00                	push   $0x0
  pushl $197
80106c66:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106c6b:	e9 c0 f2 ff ff       	jmp    80105f30 <alltraps>

80106c70 <vector198>:
.globl vector198
vector198:
  pushl $0
80106c70:	6a 00                	push   $0x0
  pushl $198
80106c72:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106c77:	e9 b4 f2 ff ff       	jmp    80105f30 <alltraps>

80106c7c <vector199>:
.globl vector199
vector199:
  pushl $0
80106c7c:	6a 00                	push   $0x0
  pushl $199
80106c7e:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106c83:	e9 a8 f2 ff ff       	jmp    80105f30 <alltraps>

80106c88 <vector200>:
.globl vector200
vector200:
  pushl $0
80106c88:	6a 00                	push   $0x0
  pushl $200
80106c8a:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106c8f:	e9 9c f2 ff ff       	jmp    80105f30 <alltraps>

80106c94 <vector201>:
.globl vector201
vector201:
  pushl $0
80106c94:	6a 00                	push   $0x0
  pushl $201
80106c96:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106c9b:	e9 90 f2 ff ff       	jmp    80105f30 <alltraps>

80106ca0 <vector202>:
.globl vector202
vector202:
  pushl $0
80106ca0:	6a 00                	push   $0x0
  pushl $202
80106ca2:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106ca7:	e9 84 f2 ff ff       	jmp    80105f30 <alltraps>

80106cac <vector203>:
.globl vector203
vector203:
  pushl $0
80106cac:	6a 00                	push   $0x0
  pushl $203
80106cae:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106cb3:	e9 78 f2 ff ff       	jmp    80105f30 <alltraps>

80106cb8 <vector204>:
.globl vector204
vector204:
  pushl $0
80106cb8:	6a 00                	push   $0x0
  pushl $204
80106cba:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106cbf:	e9 6c f2 ff ff       	jmp    80105f30 <alltraps>

80106cc4 <vector205>:
.globl vector205
vector205:
  pushl $0
80106cc4:	6a 00                	push   $0x0
  pushl $205
80106cc6:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106ccb:	e9 60 f2 ff ff       	jmp    80105f30 <alltraps>

80106cd0 <vector206>:
.globl vector206
vector206:
  pushl $0
80106cd0:	6a 00                	push   $0x0
  pushl $206
80106cd2:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106cd7:	e9 54 f2 ff ff       	jmp    80105f30 <alltraps>

80106cdc <vector207>:
.globl vector207
vector207:
  pushl $0
80106cdc:	6a 00                	push   $0x0
  pushl $207
80106cde:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106ce3:	e9 48 f2 ff ff       	jmp    80105f30 <alltraps>

80106ce8 <vector208>:
.globl vector208
vector208:
  pushl $0
80106ce8:	6a 00                	push   $0x0
  pushl $208
80106cea:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106cef:	e9 3c f2 ff ff       	jmp    80105f30 <alltraps>

80106cf4 <vector209>:
.globl vector209
vector209:
  pushl $0
80106cf4:	6a 00                	push   $0x0
  pushl $209
80106cf6:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106cfb:	e9 30 f2 ff ff       	jmp    80105f30 <alltraps>

80106d00 <vector210>:
.globl vector210
vector210:
  pushl $0
80106d00:	6a 00                	push   $0x0
  pushl $210
80106d02:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106d07:	e9 24 f2 ff ff       	jmp    80105f30 <alltraps>

80106d0c <vector211>:
.globl vector211
vector211:
  pushl $0
80106d0c:	6a 00                	push   $0x0
  pushl $211
80106d0e:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106d13:	e9 18 f2 ff ff       	jmp    80105f30 <alltraps>

80106d18 <vector212>:
.globl vector212
vector212:
  pushl $0
80106d18:	6a 00                	push   $0x0
  pushl $212
80106d1a:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106d1f:	e9 0c f2 ff ff       	jmp    80105f30 <alltraps>

80106d24 <vector213>:
.globl vector213
vector213:
  pushl $0
80106d24:	6a 00                	push   $0x0
  pushl $213
80106d26:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106d2b:	e9 00 f2 ff ff       	jmp    80105f30 <alltraps>

80106d30 <vector214>:
.globl vector214
vector214:
  pushl $0
80106d30:	6a 00                	push   $0x0
  pushl $214
80106d32:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106d37:	e9 f4 f1 ff ff       	jmp    80105f30 <alltraps>

80106d3c <vector215>:
.globl vector215
vector215:
  pushl $0
80106d3c:	6a 00                	push   $0x0
  pushl $215
80106d3e:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106d43:	e9 e8 f1 ff ff       	jmp    80105f30 <alltraps>

80106d48 <vector216>:
.globl vector216
vector216:
  pushl $0
80106d48:	6a 00                	push   $0x0
  pushl $216
80106d4a:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106d4f:	e9 dc f1 ff ff       	jmp    80105f30 <alltraps>

80106d54 <vector217>:
.globl vector217
vector217:
  pushl $0
80106d54:	6a 00                	push   $0x0
  pushl $217
80106d56:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106d5b:	e9 d0 f1 ff ff       	jmp    80105f30 <alltraps>

80106d60 <vector218>:
.globl vector218
vector218:
  pushl $0
80106d60:	6a 00                	push   $0x0
  pushl $218
80106d62:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106d67:	e9 c4 f1 ff ff       	jmp    80105f30 <alltraps>

80106d6c <vector219>:
.globl vector219
vector219:
  pushl $0
80106d6c:	6a 00                	push   $0x0
  pushl $219
80106d6e:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106d73:	e9 b8 f1 ff ff       	jmp    80105f30 <alltraps>

80106d78 <vector220>:
.globl vector220
vector220:
  pushl $0
80106d78:	6a 00                	push   $0x0
  pushl $220
80106d7a:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106d7f:	e9 ac f1 ff ff       	jmp    80105f30 <alltraps>

80106d84 <vector221>:
.globl vector221
vector221:
  pushl $0
80106d84:	6a 00                	push   $0x0
  pushl $221
80106d86:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106d8b:	e9 a0 f1 ff ff       	jmp    80105f30 <alltraps>

80106d90 <vector222>:
.globl vector222
vector222:
  pushl $0
80106d90:	6a 00                	push   $0x0
  pushl $222
80106d92:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106d97:	e9 94 f1 ff ff       	jmp    80105f30 <alltraps>

80106d9c <vector223>:
.globl vector223
vector223:
  pushl $0
80106d9c:	6a 00                	push   $0x0
  pushl $223
80106d9e:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106da3:	e9 88 f1 ff ff       	jmp    80105f30 <alltraps>

80106da8 <vector224>:
.globl vector224
vector224:
  pushl $0
80106da8:	6a 00                	push   $0x0
  pushl $224
80106daa:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106daf:	e9 7c f1 ff ff       	jmp    80105f30 <alltraps>

80106db4 <vector225>:
.globl vector225
vector225:
  pushl $0
80106db4:	6a 00                	push   $0x0
  pushl $225
80106db6:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106dbb:	e9 70 f1 ff ff       	jmp    80105f30 <alltraps>

80106dc0 <vector226>:
.globl vector226
vector226:
  pushl $0
80106dc0:	6a 00                	push   $0x0
  pushl $226
80106dc2:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106dc7:	e9 64 f1 ff ff       	jmp    80105f30 <alltraps>

80106dcc <vector227>:
.globl vector227
vector227:
  pushl $0
80106dcc:	6a 00                	push   $0x0
  pushl $227
80106dce:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106dd3:	e9 58 f1 ff ff       	jmp    80105f30 <alltraps>

80106dd8 <vector228>:
.globl vector228
vector228:
  pushl $0
80106dd8:	6a 00                	push   $0x0
  pushl $228
80106dda:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106ddf:	e9 4c f1 ff ff       	jmp    80105f30 <alltraps>

80106de4 <vector229>:
.globl vector229
vector229:
  pushl $0
80106de4:	6a 00                	push   $0x0
  pushl $229
80106de6:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106deb:	e9 40 f1 ff ff       	jmp    80105f30 <alltraps>

80106df0 <vector230>:
.globl vector230
vector230:
  pushl $0
80106df0:	6a 00                	push   $0x0
  pushl $230
80106df2:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106df7:	e9 34 f1 ff ff       	jmp    80105f30 <alltraps>

80106dfc <vector231>:
.globl vector231
vector231:
  pushl $0
80106dfc:	6a 00                	push   $0x0
  pushl $231
80106dfe:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106e03:	e9 28 f1 ff ff       	jmp    80105f30 <alltraps>

80106e08 <vector232>:
.globl vector232
vector232:
  pushl $0
80106e08:	6a 00                	push   $0x0
  pushl $232
80106e0a:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106e0f:	e9 1c f1 ff ff       	jmp    80105f30 <alltraps>

80106e14 <vector233>:
.globl vector233
vector233:
  pushl $0
80106e14:	6a 00                	push   $0x0
  pushl $233
80106e16:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106e1b:	e9 10 f1 ff ff       	jmp    80105f30 <alltraps>

80106e20 <vector234>:
.globl vector234
vector234:
  pushl $0
80106e20:	6a 00                	push   $0x0
  pushl $234
80106e22:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106e27:	e9 04 f1 ff ff       	jmp    80105f30 <alltraps>

80106e2c <vector235>:
.globl vector235
vector235:
  pushl $0
80106e2c:	6a 00                	push   $0x0
  pushl $235
80106e2e:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106e33:	e9 f8 f0 ff ff       	jmp    80105f30 <alltraps>

80106e38 <vector236>:
.globl vector236
vector236:
  pushl $0
80106e38:	6a 00                	push   $0x0
  pushl $236
80106e3a:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106e3f:	e9 ec f0 ff ff       	jmp    80105f30 <alltraps>

80106e44 <vector237>:
.globl vector237
vector237:
  pushl $0
80106e44:	6a 00                	push   $0x0
  pushl $237
80106e46:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106e4b:	e9 e0 f0 ff ff       	jmp    80105f30 <alltraps>

80106e50 <vector238>:
.globl vector238
vector238:
  pushl $0
80106e50:	6a 00                	push   $0x0
  pushl $238
80106e52:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106e57:	e9 d4 f0 ff ff       	jmp    80105f30 <alltraps>

80106e5c <vector239>:
.globl vector239
vector239:
  pushl $0
80106e5c:	6a 00                	push   $0x0
  pushl $239
80106e5e:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106e63:	e9 c8 f0 ff ff       	jmp    80105f30 <alltraps>

80106e68 <vector240>:
.globl vector240
vector240:
  pushl $0
80106e68:	6a 00                	push   $0x0
  pushl $240
80106e6a:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106e6f:	e9 bc f0 ff ff       	jmp    80105f30 <alltraps>

80106e74 <vector241>:
.globl vector241
vector241:
  pushl $0
80106e74:	6a 00                	push   $0x0
  pushl $241
80106e76:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106e7b:	e9 b0 f0 ff ff       	jmp    80105f30 <alltraps>

80106e80 <vector242>:
.globl vector242
vector242:
  pushl $0
80106e80:	6a 00                	push   $0x0
  pushl $242
80106e82:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106e87:	e9 a4 f0 ff ff       	jmp    80105f30 <alltraps>

80106e8c <vector243>:
.globl vector243
vector243:
  pushl $0
80106e8c:	6a 00                	push   $0x0
  pushl $243
80106e8e:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106e93:	e9 98 f0 ff ff       	jmp    80105f30 <alltraps>

80106e98 <vector244>:
.globl vector244
vector244:
  pushl $0
80106e98:	6a 00                	push   $0x0
  pushl $244
80106e9a:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106e9f:	e9 8c f0 ff ff       	jmp    80105f30 <alltraps>

80106ea4 <vector245>:
.globl vector245
vector245:
  pushl $0
80106ea4:	6a 00                	push   $0x0
  pushl $245
80106ea6:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106eab:	e9 80 f0 ff ff       	jmp    80105f30 <alltraps>

80106eb0 <vector246>:
.globl vector246
vector246:
  pushl $0
80106eb0:	6a 00                	push   $0x0
  pushl $246
80106eb2:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106eb7:	e9 74 f0 ff ff       	jmp    80105f30 <alltraps>

80106ebc <vector247>:
.globl vector247
vector247:
  pushl $0
80106ebc:	6a 00                	push   $0x0
  pushl $247
80106ebe:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106ec3:	e9 68 f0 ff ff       	jmp    80105f30 <alltraps>

80106ec8 <vector248>:
.globl vector248
vector248:
  pushl $0
80106ec8:	6a 00                	push   $0x0
  pushl $248
80106eca:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106ecf:	e9 5c f0 ff ff       	jmp    80105f30 <alltraps>

80106ed4 <vector249>:
.globl vector249
vector249:
  pushl $0
80106ed4:	6a 00                	push   $0x0
  pushl $249
80106ed6:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106edb:	e9 50 f0 ff ff       	jmp    80105f30 <alltraps>

80106ee0 <vector250>:
.globl vector250
vector250:
  pushl $0
80106ee0:	6a 00                	push   $0x0
  pushl $250
80106ee2:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106ee7:	e9 44 f0 ff ff       	jmp    80105f30 <alltraps>

80106eec <vector251>:
.globl vector251
vector251:
  pushl $0
80106eec:	6a 00                	push   $0x0
  pushl $251
80106eee:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106ef3:	e9 38 f0 ff ff       	jmp    80105f30 <alltraps>

80106ef8 <vector252>:
.globl vector252
vector252:
  pushl $0
80106ef8:	6a 00                	push   $0x0
  pushl $252
80106efa:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106eff:	e9 2c f0 ff ff       	jmp    80105f30 <alltraps>

80106f04 <vector253>:
.globl vector253
vector253:
  pushl $0
80106f04:	6a 00                	push   $0x0
  pushl $253
80106f06:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106f0b:	e9 20 f0 ff ff       	jmp    80105f30 <alltraps>

80106f10 <vector254>:
.globl vector254
vector254:
  pushl $0
80106f10:	6a 00                	push   $0x0
  pushl $254
80106f12:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106f17:	e9 14 f0 ff ff       	jmp    80105f30 <alltraps>

80106f1c <vector255>:
.globl vector255
vector255:
  pushl $0
80106f1c:	6a 00                	push   $0x0
  pushl $255
80106f1e:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106f23:	e9 08 f0 ff ff       	jmp    80105f30 <alltraps>
80106f28:	66 90                	xchg   %ax,%ax
80106f2a:	66 90                	xchg   %ax,%ax
80106f2c:	66 90                	xchg   %ax,%ax
80106f2e:	66 90                	xchg   %ax,%ax

80106f30 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f30:	55                   	push   %ebp
80106f31:	89 e5                	mov    %esp,%ebp
80106f33:	57                   	push   %edi
80106f34:	56                   	push   %esi
80106f35:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106f36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f3c:	83 ec 2c             	sub    $0x2c,%esp
  a = PGROUNDUP(newsz);
80106f3f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106f45:	39 d3                	cmp    %edx,%ebx
80106f47:	73 76                	jae    80106fbf <deallocuvm.part.0+0x8f>
80106f49:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106f4c:	89 c6                	mov    %eax,%esi
80106f4e:	89 d7                	mov    %edx,%edi
80106f50:	eb 10                	jmp    80106f62 <deallocuvm.part.0+0x32>
80106f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106f58:	42                   	inc    %edx
80106f59:	89 d3                	mov    %edx,%ebx
80106f5b:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106f5e:	39 fb                	cmp    %edi,%ebx
80106f60:	73 5a                	jae    80106fbc <deallocuvm.part.0+0x8c>
  pde = &pgdir[PDX(va)];
80106f62:	89 da                	mov    %ebx,%edx
80106f64:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106f67:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106f6a:	a8 01                	test   $0x1,%al
80106f6c:	74 ea                	je     80106f58 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106f6e:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f70:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106f75:	c1 e9 0a             	shr    $0xa,%ecx
80106f78:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106f7e:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106f85:	85 c0                	test   %eax,%eax
80106f87:	74 cf                	je     80106f58 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80106f89:	8b 10                	mov    (%eax),%edx
80106f8b:	f6 c2 01             	test   $0x1,%dl
80106f8e:	74 22                	je     80106fb2 <deallocuvm.part.0+0x82>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106f90:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106f96:	74 31                	je     80106fc9 <deallocuvm.part.0+0x99>
80106f98:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        panic("kfree");
      char *v = P2V(pa);
80106f9b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80106fa1:	89 14 24             	mov    %edx,(%esp)
80106fa4:	e8 07 b6 ff ff       	call   801025b0 <kfree>
      *pte = 0;
80106fa9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106fac:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106fb2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fb8:	39 fb                	cmp    %edi,%ebx
80106fba:	72 a6                	jb     80106f62 <deallocuvm.part.0+0x32>
80106fbc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    }
  }
  return newsz;
}
80106fbf:	83 c4 2c             	add    $0x2c,%esp
80106fc2:	89 c8                	mov    %ecx,%eax
80106fc4:	5b                   	pop    %ebx
80106fc5:	5e                   	pop    %esi
80106fc6:	5f                   	pop    %edi
80106fc7:	5d                   	pop    %ebp
80106fc8:	c3                   	ret
        panic("kfree");
80106fc9:	c7 04 24 4c 7c 10 80 	movl   $0x80107c4c,(%esp)
80106fd0:	e8 7b 93 ff ff       	call   80100350 <panic>
80106fd5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106fdc:	00 
80106fdd:	8d 76 00             	lea    0x0(%esi),%esi

80106fe0 <mappages>:
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	57                   	push   %edi
80106fe4:	56                   	push   %esi
80106fe5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106fe6:	89 d3                	mov    %edx,%ebx
{
80106fe8:	83 ec 2c             	sub    $0x2c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
80106feb:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106ff1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106ff4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106ff8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ffd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107000:	8b 45 08             	mov    0x8(%ebp),%eax
80107003:	29 d8                	sub    %ebx,%eax
80107005:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107008:	eb 41                	jmp    8010704b <mappages+0x6b>
8010700a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107010:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107012:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107017:	c1 ea 0a             	shr    $0xa,%edx
8010701a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107020:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107027:	85 c0                	test   %eax,%eax
80107029:	74 7d                	je     801070a8 <mappages+0xc8>
    if(*pte & PTE_P)
8010702b:	f6 00 01             	testb  $0x1,(%eax)
8010702e:	0f 85 8e 00 00 00    	jne    801070c2 <mappages+0xe2>
    *pte = pa | perm | PTE_P;
80107034:	8b 55 0c             	mov    0xc(%ebp),%edx
80107037:	09 d6                	or     %edx,%esi
80107039:	83 ce 01             	or     $0x1,%esi
8010703c:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010703e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107041:	39 c3                	cmp    %eax,%ebx
80107043:	74 73                	je     801070b8 <mappages+0xd8>
    a += PGSIZE;
80107045:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
8010704b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010704e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80107051:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80107054:	89 d8                	mov    %ebx,%eax
80107056:	c1 e8 16             	shr    $0x16,%eax
80107059:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
8010705c:	8b 07                	mov    (%edi),%eax
8010705e:	a8 01                	test   $0x1,%al
80107060:	75 ae                	jne    80107010 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107062:	e8 09 b7 ff ff       	call   80102770 <kalloc>
80107067:	85 c0                	test   %eax,%eax
80107069:	89 c2                	mov    %eax,%edx
8010706b:	74 3b                	je     801070a8 <mappages+0xc8>
    memset(pgtab, 0, PGSIZE);
8010706d:	89 14 24             	mov    %edx,(%esp)
80107070:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107075:	31 c0                	xor    %eax,%eax
80107077:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010707b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010707f:	89 55 d8             	mov    %edx,-0x28(%ebp)
80107082:	e8 19 db ff ff       	call   80104ba0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107087:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010708a:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107090:	83 c8 07             	or     $0x7,%eax
80107093:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80107095:	89 d8                	mov    %ebx,%eax
80107097:	c1 e8 0a             	shr    $0xa,%eax
8010709a:	25 fc 0f 00 00       	and    $0xffc,%eax
8010709f:	01 d0                	add    %edx,%eax
801070a1:	eb 88                	jmp    8010702b <mappages+0x4b>
801070a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
801070a8:	83 c4 2c             	add    $0x2c,%esp
      return -1;
801070ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070b0:	5b                   	pop    %ebx
801070b1:	5e                   	pop    %esi
801070b2:	5f                   	pop    %edi
801070b3:	5d                   	pop    %ebp
801070b4:	c3                   	ret
801070b5:	8d 76 00             	lea    0x0(%esi),%esi
801070b8:	83 c4 2c             	add    $0x2c,%esp
  return 0;
801070bb:	31 c0                	xor    %eax,%eax
}
801070bd:	5b                   	pop    %ebx
801070be:	5e                   	pop    %esi
801070bf:	5f                   	pop    %edi
801070c0:	5d                   	pop    %ebp
801070c1:	c3                   	ret
      panic("remap");
801070c2:	c7 04 24 bc 7e 10 80 	movl   $0x80107ebc,(%esp)
801070c9:	e8 82 92 ff ff       	call   80100350 <panic>
801070ce:	66 90                	xchg   %ax,%ax

801070d0 <seginit>:
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801070d6:	e8 d5 ca ff ff       	call   80103bb0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070db:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
801070e0:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
801070e6:	8d 14 80             	lea    (%eax,%eax,4),%edx
801070e9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801070ec:	ba ff ff 00 00       	mov    $0xffff,%edx
801070f1:	c1 e0 04             	shl    $0x4,%eax
801070f4:	89 90 18 28 11 80    	mov    %edx,-0x7feed7e8(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801070fa:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070ff:	89 88 1c 28 11 80    	mov    %ecx,-0x7feed7e4(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107105:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
8010710a:	89 90 20 28 11 80    	mov    %edx,-0x7feed7e0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107110:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107115:	89 88 24 28 11 80    	mov    %ecx,-0x7feed7dc(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010711b:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
80107120:	89 90 28 28 11 80    	mov    %edx,-0x7feed7d8(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107126:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010712b:	89 88 2c 28 11 80    	mov    %ecx,-0x7feed7d4(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107131:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
80107136:	89 90 30 28 11 80    	mov    %edx,-0x7feed7d0(%eax)
8010713c:	89 88 34 28 11 80    	mov    %ecx,-0x7feed7cc(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80107142:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
80107147:	0f b7 d0             	movzwl %ax,%edx
8010714a:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
8010714e:	c1 e8 10             	shr    $0x10,%eax
80107151:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107155:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107158:	0f 01 10             	lgdtl  (%eax)
}
8010715b:	89 ec                	mov    %ebp,%esp
8010715d:	5d                   	pop    %ebp
8010715e:	c3                   	ret
8010715f:	90                   	nop

80107160 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107160:	a1 c4 54 11 80       	mov    0x801154c4,%eax
80107165:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010716a:	0f 22 d8             	mov    %eax,%cr3
}
8010716d:	c3                   	ret
8010716e:	66 90                	xchg   %ax,%ax

80107170 <switchuvm>:
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	83 ec 2c             	sub    $0x2c,%esp
80107179:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010717c:	85 f6                	test   %esi,%esi
8010717e:	0f 84 c5 00 00 00    	je     80107249 <switchuvm+0xd9>
  if(p->kstack == 0)
80107184:	8b 7e 08             	mov    0x8(%esi),%edi
80107187:	85 ff                	test   %edi,%edi
80107189:	0f 84 d2 00 00 00    	je     80107261 <switchuvm+0xf1>
  if(p->pgdir == 0)
8010718f:	8b 5e 04             	mov    0x4(%esi),%ebx
80107192:	85 db                	test   %ebx,%ebx
80107194:	0f 84 bb 00 00 00    	je     80107255 <switchuvm+0xe5>
  pushcli();
8010719a:	e8 91 d7 ff ff       	call   80104930 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010719f:	e8 9c c9 ff ff       	call   80103b40 <mycpu>
801071a4:	89 c3                	mov    %eax,%ebx
801071a6:	e8 95 c9 ff ff       	call   80103b40 <mycpu>
801071ab:	89 c7                	mov    %eax,%edi
801071ad:	e8 8e c9 ff ff       	call   80103b40 <mycpu>
801071b2:	83 c7 08             	add    $0x8,%edi
801071b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801071b8:	e8 83 c9 ff ff       	call   80103b40 <mycpu>
801071bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801071c0:	ba 67 00 00 00       	mov    $0x67,%edx
801071c5:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
801071cc:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801071d3:	83 c1 08             	add    $0x8,%ecx
801071d6:	c1 e9 10             	shr    $0x10,%ecx
801071d9:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801071df:	83 c0 08             	add    $0x8,%eax
801071e2:	b9 99 40 00 00       	mov    $0x4099,%ecx
801071e7:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
801071ee:	c1 e8 18             	shr    $0x18,%eax
801071f1:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
801071f7:	e8 44 c9 ff ff       	call   80103b40 <mycpu>
801071fc:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107203:	e8 38 c9 ff ff       	call   80103b40 <mycpu>
80107208:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010720e:	8b 5e 08             	mov    0x8(%esi),%ebx
80107211:	e8 2a c9 ff ff       	call   80103b40 <mycpu>
80107216:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010721c:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010721f:	e8 1c c9 ff ff       	call   80103b40 <mycpu>
80107224:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
8010722a:	b8 28 00 00 00       	mov    $0x28,%eax
8010722f:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107232:	8b 46 04             	mov    0x4(%esi),%eax
80107235:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010723a:	0f 22 d8             	mov    %eax,%cr3
}
8010723d:	83 c4 2c             	add    $0x2c,%esp
80107240:	5b                   	pop    %ebx
80107241:	5e                   	pop    %esi
80107242:	5f                   	pop    %edi
80107243:	5d                   	pop    %ebp
  popcli();
80107244:	e9 37 d7 ff ff       	jmp    80104980 <popcli>
    panic("switchuvm: no process");
80107249:	c7 04 24 c2 7e 10 80 	movl   $0x80107ec2,(%esp)
80107250:	e8 fb 90 ff ff       	call   80100350 <panic>
    panic("switchuvm: no pgdir");
80107255:	c7 04 24 ed 7e 10 80 	movl   $0x80107eed,(%esp)
8010725c:	e8 ef 90 ff ff       	call   80100350 <panic>
    panic("switchuvm: no kstack");
80107261:	c7 04 24 d8 7e 10 80 	movl   $0x80107ed8,(%esp)
80107268:	e8 e3 90 ff ff       	call   80100350 <panic>
8010726d:	8d 76 00             	lea    0x0(%esi),%esi

80107270 <inituvm>:
{
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	83 ec 38             	sub    $0x38,%esp
80107276:	89 75 f8             	mov    %esi,-0x8(%ebp)
80107279:	8b 75 10             	mov    0x10(%ebp),%esi
8010727c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010727f:	8b 45 08             	mov    0x8(%ebp),%eax
80107282:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80107285:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107288:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
8010728e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107291:	77 59                	ja     801072ec <inituvm+0x7c>
  mem = kalloc();
80107293:	e8 d8 b4 ff ff       	call   80102770 <kalloc>
  memset(mem, 0, PGSIZE);
80107298:	31 d2                	xor    %edx,%edx
8010729a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
8010729e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801072a0:	b8 00 10 00 00       	mov    $0x1000,%eax
801072a5:	89 1c 24             	mov    %ebx,(%esp)
801072a8:	89 44 24 08          	mov    %eax,0x8(%esp)
801072ac:	e8 ef d8 ff ff       	call   80104ba0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801072b1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801072b7:	b9 06 00 00 00       	mov    $0x6,%ecx
801072bc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801072c0:	31 d2                	xor    %edx,%edx
801072c2:	b9 00 10 00 00       	mov    $0x1000,%ecx
801072c7:	89 04 24             	mov    %eax,(%esp)
801072ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801072cd:	e8 0e fd ff ff       	call   80106fe0 <mappages>
  memmove(mem, init, sz);
801072d2:	89 75 10             	mov    %esi,0x10(%ebp)
}
801072d5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  memmove(mem, init, sz);
801072d8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
801072db:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
801072de:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801072e1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801072e4:	89 ec                	mov    %ebp,%esp
801072e6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801072e7:	e9 44 d9 ff ff       	jmp    80104c30 <memmove>
    panic("inituvm: more than a page");
801072ec:	c7 04 24 01 7f 10 80 	movl   $0x80107f01,(%esp)
801072f3:	e8 58 90 ff ff       	call   80100350 <panic>
801072f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801072ff:	00 

80107300 <loaduvm>:
{
80107300:	55                   	push   %ebp
80107301:	89 e5                	mov    %esp,%ebp
80107303:	57                   	push   %edi
80107304:	56                   	push   %esi
80107305:	53                   	push   %ebx
80107306:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80107309:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010730c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010730f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107315:	0f 85 ba 00 00 00    	jne    801073d5 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010731b:	85 ff                	test   %edi,%edi
8010731d:	0f 84 96 00 00 00    	je     801073b9 <loaduvm+0xb9>
80107323:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010732a:	00 
8010732b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107330:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107333:	8b 55 08             	mov    0x8(%ebp),%edx
80107336:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80107338:	89 c1                	mov    %eax,%ecx
8010733a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010733d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107340:	f6 c1 01             	test   $0x1,%cl
80107343:	75 13                	jne    80107358 <loaduvm+0x58>
      panic("loaduvm: address should exist");
80107345:	c7 04 24 1b 7f 10 80 	movl   $0x80107f1b,(%esp)
8010734c:	e8 ff 8f ff ff       	call   80100350 <panic>
80107351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107358:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010735b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107361:	25 fc 0f 00 00       	and    $0xffc,%eax
80107366:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010736d:	85 c9                	test   %ecx,%ecx
8010736f:	74 d4                	je     80107345 <loaduvm+0x45>
    if(sz - i < PGSIZE)
80107371:	89 fb                	mov    %edi,%ebx
80107373:	b8 00 10 00 00       	mov    $0x1000,%eax
80107378:	29 f3                	sub    %esi,%ebx
8010737a:	39 c3                	cmp    %eax,%ebx
8010737c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010737f:	8b 45 14             	mov    0x14(%ebp),%eax
80107382:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80107386:	01 f0                	add    %esi,%eax
80107388:	89 44 24 08          	mov    %eax,0x8(%esp)
    pa = PTE_ADDR(*pte);
8010738c:	8b 01                	mov    (%ecx),%eax
8010738e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107393:	05 00 00 00 80       	add    $0x80000000,%eax
80107398:	89 44 24 04          	mov    %eax,0x4(%esp)
8010739c:	8b 45 10             	mov    0x10(%ebp),%eax
8010739f:	89 04 24             	mov    %eax,(%esp)
801073a2:	e8 99 a7 ff ff       	call   80101b40 <readi>
801073a7:	39 d8                	cmp    %ebx,%eax
801073a9:	75 1d                	jne    801073c8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801073ab:	81 c6 00 10 00 00    	add    $0x1000,%esi
801073b1:	39 fe                	cmp    %edi,%esi
801073b3:	0f 82 77 ff ff ff    	jb     80107330 <loaduvm+0x30>
}
801073b9:	83 c4 1c             	add    $0x1c,%esp
  return 0;
801073bc:	31 c0                	xor    %eax,%eax
}
801073be:	5b                   	pop    %ebx
801073bf:	5e                   	pop    %esi
801073c0:	5f                   	pop    %edi
801073c1:	5d                   	pop    %ebp
801073c2:	c3                   	ret
801073c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801073c8:	83 c4 1c             	add    $0x1c,%esp
      return -1;
801073cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073d0:	5b                   	pop    %ebx
801073d1:	5e                   	pop    %esi
801073d2:	5f                   	pop    %edi
801073d3:	5d                   	pop    %ebp
801073d4:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
801073d5:	c7 04 24 64 81 10 80 	movl   $0x80108164,(%esp)
801073dc:	e8 6f 8f ff ff       	call   80100350 <panic>
801073e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801073e8:	00 
801073e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073f0 <allocuvm>:
{
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	57                   	push   %edi
801073f4:	56                   	push   %esi
801073f5:	53                   	push   %ebx
801073f6:	83 ec 2c             	sub    $0x2c,%esp
801073f9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
801073fc:	85 f6                	test   %esi,%esi
801073fe:	0f 88 9a 00 00 00    	js     8010749e <allocuvm+0xae>
  if(newsz < oldsz)
80107404:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107407:	89 f2                	mov    %esi,%edx
80107409:	0f 82 a1 00 00 00    	jb     801074b0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010740f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107412:	05 ff 0f 00 00       	add    $0xfff,%eax
80107417:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  for(; a < newsz; a += PGSIZE){
8010741c:	39 f0                	cmp    %esi,%eax
  a = PGROUNDUP(oldsz);
8010741e:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
80107420:	0f 83 8d 00 00 00    	jae    801074b3 <allocuvm+0xc3>
80107426:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107429:	eb 4a                	jmp    80107475 <allocuvm+0x85>
8010742b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107430:	89 1c 24             	mov    %ebx,(%esp)
80107433:	31 d2                	xor    %edx,%edx
80107435:	b8 00 10 00 00       	mov    $0x1000,%eax
8010743a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010743e:	89 44 24 08          	mov    %eax,0x8(%esp)
80107442:	e8 59 d7 ff ff       	call   80104ba0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107447:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010744d:	b9 06 00 00 00       	mov    $0x6,%ecx
80107452:	89 04 24             	mov    %eax,(%esp)
80107455:	8b 45 08             	mov    0x8(%ebp),%eax
80107458:	89 fa                	mov    %edi,%edx
8010745a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010745e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107463:	e8 78 fb ff ff       	call   80106fe0 <mappages>
80107468:	40                   	inc    %eax
80107469:	74 55                	je     801074c0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
8010746b:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107471:	39 f7                	cmp    %esi,%edi
80107473:	73 7b                	jae    801074f0 <allocuvm+0x100>
    mem = kalloc();
80107475:	e8 f6 b2 ff ff       	call   80102770 <kalloc>
    if(mem == 0){
8010747a:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010747c:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
8010747e:	75 b0                	jne    80107430 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107480:	c7 04 24 39 7f 10 80 	movl   $0x80107f39,(%esp)
80107487:	e8 f4 91 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
8010748c:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010748f:	74 0d                	je     8010749e <allocuvm+0xae>
80107491:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107494:	89 f2                	mov    %esi,%edx
80107496:	8b 45 08             	mov    0x8(%ebp),%eax
80107499:	e8 92 fa ff ff       	call   80106f30 <deallocuvm.part.0>
    return 0;
8010749e:	31 d2                	xor    %edx,%edx
}
801074a0:	83 c4 2c             	add    $0x2c,%esp
801074a3:	89 d0                	mov    %edx,%eax
801074a5:	5b                   	pop    %ebx
801074a6:	5e                   	pop    %esi
801074a7:	5f                   	pop    %edi
801074a8:	5d                   	pop    %ebp
801074a9:	c3                   	ret
801074aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return oldsz;
801074b0:	8b 55 0c             	mov    0xc(%ebp),%edx
}
801074b3:	83 c4 2c             	add    $0x2c,%esp
801074b6:	89 d0                	mov    %edx,%eax
801074b8:	5b                   	pop    %ebx
801074b9:	5e                   	pop    %esi
801074ba:	5f                   	pop    %edi
801074bb:	5d                   	pop    %ebp
801074bc:	c3                   	ret
801074bd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801074c0:	c7 04 24 51 7f 10 80 	movl   $0x80107f51,(%esp)
801074c7:	e8 b4 91 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
801074cc:	3b 75 0c             	cmp    0xc(%ebp),%esi
801074cf:	74 0d                	je     801074de <allocuvm+0xee>
801074d1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801074d4:	89 f2                	mov    %esi,%edx
801074d6:	8b 45 08             	mov    0x8(%ebp),%eax
801074d9:	e8 52 fa ff ff       	call   80106f30 <deallocuvm.part.0>
      kfree(mem);
801074de:	89 1c 24             	mov    %ebx,(%esp)
801074e1:	e8 ca b0 ff ff       	call   801025b0 <kfree>
    return 0;
801074e6:	31 d2                	xor    %edx,%edx
801074e8:	eb b6                	jmp    801074a0 <allocuvm+0xb0>
801074ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801074f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
801074f3:	83 c4 2c             	add    $0x2c,%esp
801074f6:	5b                   	pop    %ebx
801074f7:	5e                   	pop    %esi
801074f8:	89 d0                	mov    %edx,%eax
801074fa:	5f                   	pop    %edi
801074fb:	5d                   	pop    %ebp
801074fc:	c3                   	ret
801074fd:	8d 76 00             	lea    0x0(%esi),%esi

80107500 <deallocuvm>:
{
80107500:	55                   	push   %ebp
80107501:	89 e5                	mov    %esp,%ebp
80107503:	8b 55 0c             	mov    0xc(%ebp),%edx
80107506:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107509:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010750c:	39 d1                	cmp    %edx,%ecx
8010750e:	73 10                	jae    80107520 <deallocuvm+0x20>
}
80107510:	5d                   	pop    %ebp
80107511:	e9 1a fa ff ff       	jmp    80106f30 <deallocuvm.part.0>
80107516:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010751d:	00 
8010751e:	66 90                	xchg   %ax,%ax
80107520:	5d                   	pop    %ebp
80107521:	89 d0                	mov    %edx,%eax
80107523:	c3                   	ret
80107524:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010752b:	00 
8010752c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107530 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107530:	55                   	push   %ebp
80107531:	89 e5                	mov    %esp,%ebp
80107533:	57                   	push   %edi
80107534:	56                   	push   %esi
80107535:	53                   	push   %ebx
80107536:	83 ec 1c             	sub    $0x1c,%esp
80107539:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010753c:	85 f6                	test   %esi,%esi
8010753e:	74 55                	je     80107595 <freevm+0x65>
  if(newsz >= oldsz)
80107540:	31 c9                	xor    %ecx,%ecx
80107542:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107547:	89 f0                	mov    %esi,%eax
80107549:	89 f3                	mov    %esi,%ebx
8010754b:	e8 e0 f9 ff ff       	call   80106f30 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107550:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107556:	eb 0f                	jmp    80107567 <freevm+0x37>
80107558:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010755f:	00 
80107560:	83 c3 04             	add    $0x4,%ebx
80107563:	39 fb                	cmp    %edi,%ebx
80107565:	74 1f                	je     80107586 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80107567:	8b 03                	mov    (%ebx),%eax
80107569:	a8 01                	test   $0x1,%al
8010756b:	74 f3                	je     80107560 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010756d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  for(i = 0; i < NPDENTRIES; i++){
80107572:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107575:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010757a:	89 04 24             	mov    %eax,(%esp)
8010757d:	e8 2e b0 ff ff       	call   801025b0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80107582:	39 fb                	cmp    %edi,%ebx
80107584:	75 e1                	jne    80107567 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107586:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107589:	83 c4 1c             	add    $0x1c,%esp
8010758c:	5b                   	pop    %ebx
8010758d:	5e                   	pop    %esi
8010758e:	5f                   	pop    %edi
8010758f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107590:	e9 1b b0 ff ff       	jmp    801025b0 <kfree>
    panic("freevm: no pgdir");
80107595:	c7 04 24 6d 7f 10 80 	movl   $0x80107f6d,(%esp)
8010759c:	e8 af 8d ff ff       	call   80100350 <panic>
801075a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801075a8:	00 
801075a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801075b0 <setupkvm>:
{
801075b0:	55                   	push   %ebp
801075b1:	89 e5                	mov    %esp,%ebp
801075b3:	57                   	push   %edi
801075b4:	56                   	push   %esi
801075b5:	53                   	push   %ebx
801075b6:	83 ec 1c             	sub    $0x1c,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
801075b9:	e8 b2 b1 ff ff       	call   80102770 <kalloc>
801075be:	85 c0                	test   %eax,%eax
801075c0:	74 5e                	je     80107620 <setupkvm+0x70>
801075c2:	89 c6                	mov    %eax,%esi
  memset(pgdir, 0, PGSIZE);
801075c4:	31 d2                	xor    %edx,%edx
801075c6:	89 54 24 04          	mov    %edx,0x4(%esp)
801075ca:	b8 00 10 00 00       	mov    $0x1000,%eax
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075cf:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801075d4:	89 44 24 08          	mov    %eax,0x8(%esp)
801075d8:	89 34 24             	mov    %esi,(%esp)
801075db:	e8 c0 d5 ff ff       	call   80104ba0 <memset>
                (uint)k->phys_start, k->perm) < 0) {
801075e0:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801075e3:	8b 4b 08             	mov    0x8(%ebx),%ecx
801075e6:	8b 7b 0c             	mov    0xc(%ebx),%edi
801075e9:	8b 13                	mov    (%ebx),%edx
801075eb:	89 04 24             	mov    %eax,(%esp)
801075ee:	29 c1                	sub    %eax,%ecx
801075f0:	89 f0                	mov    %esi,%eax
801075f2:	89 7c 24 04          	mov    %edi,0x4(%esp)
801075f6:	e8 e5 f9 ff ff       	call   80106fe0 <mappages>
801075fb:	40                   	inc    %eax
801075fc:	74 1a                	je     80107618 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075fe:	83 c3 10             	add    $0x10,%ebx
80107601:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107607:	75 d7                	jne    801075e0 <setupkvm+0x30>
}
80107609:	83 c4 1c             	add    $0x1c,%esp
8010760c:	89 f0                	mov    %esi,%eax
8010760e:	5b                   	pop    %ebx
8010760f:	5e                   	pop    %esi
80107610:	5f                   	pop    %edi
80107611:	5d                   	pop    %ebp
80107612:	c3                   	ret
80107613:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107618:	89 34 24             	mov    %esi,(%esp)
8010761b:	e8 10 ff ff ff       	call   80107530 <freevm>
}
80107620:	83 c4 1c             	add    $0x1c,%esp
    return 0;
80107623:	31 f6                	xor    %esi,%esi
}
80107625:	5b                   	pop    %ebx
80107626:	89 f0                	mov    %esi,%eax
80107628:	5e                   	pop    %esi
80107629:	5f                   	pop    %edi
8010762a:	5d                   	pop    %ebp
8010762b:	c3                   	ret
8010762c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107630 <kvmalloc>:
{
80107630:	55                   	push   %ebp
80107631:	89 e5                	mov    %esp,%ebp
80107633:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107636:	e8 75 ff ff ff       	call   801075b0 <setupkvm>
8010763b:	a3 c4 54 11 80       	mov    %eax,0x801154c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107640:	05 00 00 00 80       	add    $0x80000000,%eax
80107645:	0f 22 d8             	mov    %eax,%cr3
}
80107648:	89 ec                	mov    %ebp,%esp
8010764a:	5d                   	pop    %ebp
8010764b:	c3                   	ret
8010764c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107650 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107650:	55                   	push   %ebp
80107651:	89 e5                	mov    %esp,%ebp
80107653:	83 ec 18             	sub    $0x18,%esp
80107656:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107659:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010765c:	89 c1                	mov    %eax,%ecx
8010765e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107661:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107664:	f6 c2 01             	test   $0x1,%dl
80107667:	75 0f                	jne    80107678 <clearpteu+0x28>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107669:	c7 04 24 7e 7f 10 80 	movl   $0x80107f7e,(%esp)
80107670:	e8 db 8c ff ff       	call   80100350 <panic>
80107675:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107678:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010767b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107681:	25 fc 0f 00 00       	and    $0xffc,%eax
80107686:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
8010768d:	85 c0                	test   %eax,%eax
8010768f:	74 d8                	je     80107669 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107691:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107694:	89 ec                	mov    %ebp,%esp
80107696:	5d                   	pop    %ebp
80107697:	c3                   	ret
80107698:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010769f:	00 

801076a0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801076a0:	55                   	push   %ebp
801076a1:	89 e5                	mov    %esp,%ebp
801076a3:	57                   	push   %edi
801076a4:	56                   	push   %esi
801076a5:	53                   	push   %ebx
801076a6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801076a9:	e8 02 ff ff ff       	call   801075b0 <setupkvm>
801076ae:	85 c0                	test   %eax,%eax
801076b0:	0f 84 e5 00 00 00    	je     8010779b <copyuvm+0xfb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801076b6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801076b9:	89 c2                	mov    %eax,%edx
801076bb:	85 c9                	test   %ecx,%ecx
801076bd:	0f 84 bc 00 00 00    	je     8010777f <copyuvm+0xdf>
801076c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801076c6:	31 ff                	xor    %edi,%edi
801076c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801076cf:	00 
  if(*pde & PTE_P){
801076d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801076d3:	89 f8                	mov    %edi,%eax
801076d5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801076d8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801076db:	a8 01                	test   $0x1,%al
801076dd:	75 11                	jne    801076f0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801076df:	c7 04 24 88 7f 10 80 	movl   $0x80107f88,(%esp)
801076e6:	e8 65 8c ff ff       	call   80100350 <panic>
801076eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801076f0:	89 fa                	mov    %edi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801076f7:	c1 ea 0a             	shr    $0xa,%edx
801076fa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107700:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107707:	85 c0                	test   %eax,%eax
80107709:	74 d4                	je     801076df <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010770b:	8b 18                	mov    (%eax),%ebx
8010770d:	f6 c3 01             	test   $0x1,%bl
80107710:	0f 84 9d 00 00 00    	je     801077b3 <copyuvm+0x113>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107716:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80107718:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
8010771e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107723:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107726:	e8 45 b0 ff ff       	call   80102770 <kalloc>
8010772b:	85 c0                	test   %eax,%eax
8010772d:	89 c6                	mov    %eax,%esi
8010772f:	74 5f                	je     80107790 <copyuvm+0xf0>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107731:	89 34 24             	mov    %esi,(%esp)
80107734:	b8 00 10 00 00       	mov    $0x1000,%eax
80107739:	89 44 24 08          	mov    %eax,0x8(%esp)
8010773d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107740:	05 00 00 00 80       	add    $0x80000000,%eax
80107745:	89 44 24 04          	mov    %eax,0x4(%esp)
80107749:	e8 e2 d4 ff ff       	call   80104c30 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010774e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107754:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107759:	89 04 24             	mov    %eax,(%esp)
8010775c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010775f:	89 fa                	mov    %edi,%edx
80107761:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80107765:	e8 76 f8 ff ff       	call   80106fe0 <mappages>
8010776a:	40                   	inc    %eax
8010776b:	74 33                	je     801077a0 <copyuvm+0x100>
  for(i = 0; i < sz; i += PGSIZE){
8010776d:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107773:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107776:	0f 82 54 ff ff ff    	jb     801076d0 <copyuvm+0x30>
8010777c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  return d;

bad:
  freevm(d);
  return 0;
}
8010777f:	83 c4 2c             	add    $0x2c,%esp
80107782:	89 d0                	mov    %edx,%eax
80107784:	5b                   	pop    %ebx
80107785:	5e                   	pop    %esi
80107786:	5f                   	pop    %edi
80107787:	5d                   	pop    %ebp
80107788:	c3                   	ret
80107789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107790:	8b 55 e0             	mov    -0x20(%ebp),%edx
  freevm(d);
80107793:	89 14 24             	mov    %edx,(%esp)
80107796:	e8 95 fd ff ff       	call   80107530 <freevm>
    return 0;
8010779b:	31 d2                	xor    %edx,%edx
8010779d:	eb e0                	jmp    8010777f <copyuvm+0xdf>
8010779f:	90                   	nop
      kfree(mem);
801077a0:	89 34 24             	mov    %esi,(%esp)
801077a3:	8b 55 e0             	mov    -0x20(%ebp),%edx
801077a6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801077a9:	e8 02 ae ff ff       	call   801025b0 <kfree>
      goto bad;
801077ae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801077b1:	eb e0                	jmp    80107793 <copyuvm+0xf3>
      panic("copyuvm: page not present");
801077b3:	c7 04 24 a2 7f 10 80 	movl   $0x80107fa2,(%esp)
801077ba:	e8 91 8b ff ff       	call   80100350 <panic>
801077bf:	90                   	nop

801077c0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801077c0:	55                   	push   %ebp
801077c1:	89 e5                	mov    %esp,%ebp
801077c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801077c6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801077c9:	89 c1                	mov    %eax,%ecx
801077cb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801077ce:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801077d1:	f6 c2 01             	test   $0x1,%dl
801077d4:	0f 84 79 02 00 00    	je     80107a53 <uva2ka.cold>
  return &pgtab[PTX(va)];
801077da:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801077dd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801077e3:	25 ff 03 00 00       	and    $0x3ff,%eax
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
801077e8:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801077ef:	89 c2                	mov    %eax,%edx
801077f1:	f7 d2                	not    %edx
801077f3:	f6 c2 05             	test   $0x5,%dl
801077f6:	75 10                	jne    80107808 <uva2ka+0x48>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801077f8:	5d                   	pop    %ebp
  return (char*)P2V(PTE_ADDR(*pte));
801077f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801077fe:	05 00 00 00 80       	add    $0x80000000,%eax
}
80107803:	c3                   	ret
80107804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107808:	5d                   	pop    %ebp
80107809:	31 c0                	xor    %eax,%eax
8010780b:	c3                   	ret
8010780c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107810 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107810:	55                   	push   %ebp
80107811:	89 e5                	mov    %esp,%ebp
80107813:	57                   	push   %edi
80107814:	56                   	push   %esi
80107815:	53                   	push   %ebx
80107816:	83 ec 1c             	sub    $0x1c,%esp
80107819:	8b 75 14             	mov    0x14(%ebp),%esi
8010781c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010781f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107822:	85 f6                	test   %esi,%esi
80107824:	75 4b                	jne    80107871 <copyout+0x61>
80107826:	e9 95 00 00 00       	jmp    801078c0 <copyout+0xb0>
8010782b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107830:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107835:	05 00 00 00 80       	add    $0x80000000,%eax
8010783a:	74 70                	je     801078ac <copyout+0x9c>
      return -1;
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
8010783c:	89 54 24 04          	mov    %edx,0x4(%esp)
    n = PGSIZE - (va - va0);
80107840:	89 fb                	mov    %edi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107842:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107845:	29 cb                	sub    %ecx,%ebx
80107847:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010784d:	39 f3                	cmp    %esi,%ebx
8010784f:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107852:	29 f9                	sub    %edi,%ecx
80107854:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80107858:	01 c8                	add    %ecx,%eax
8010785a:	89 04 24             	mov    %eax,(%esp)
8010785d:	e8 ce d3 ff ff       	call   80104c30 <memmove>
    len -= n;
    buf += n;
80107862:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107865:	8d 8f 00 10 00 00    	lea    0x1000(%edi),%ecx
    buf += n;
8010786b:	01 da                	add    %ebx,%edx
  while(len > 0){
8010786d:	29 de                	sub    %ebx,%esi
8010786f:	74 4f                	je     801078c0 <copyout+0xb0>
  if(*pde & PTE_P){
80107871:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107874:	89 c8                	mov    %ecx,%eax
    va0 = (uint)PGROUNDDOWN(va);
80107876:	89 cf                	mov    %ecx,%edi
  pde = &pgdir[PDX(va)];
80107878:	c1 e8 16             	shr    $0x16,%eax
    va0 = (uint)PGROUNDDOWN(va);
8010787b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107881:	8b 04 83             	mov    (%ebx,%eax,4),%eax
80107884:	a8 01                	test   $0x1,%al
80107886:	0f 84 ce 01 00 00    	je     80107a5a <copyout.cold>
  return &pgtab[PTX(va)];
8010788c:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010788e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107893:	c1 eb 0c             	shr    $0xc,%ebx
80107896:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
8010789c:	8b 84 98 00 00 00 80 	mov    -0x80000000(%eax,%ebx,4),%eax
  if((*pte & PTE_U) == 0)
801078a3:	89 c3                	mov    %eax,%ebx
801078a5:	f7 d3                	not    %ebx
801078a7:	f6 c3 05             	test   $0x5,%bl
801078aa:	74 84                	je     80107830 <copyout+0x20>
  }
  return 0;
}
801078ac:	83 c4 1c             	add    $0x1c,%esp
      return -1;
801078af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078b4:	5b                   	pop    %ebx
801078b5:	5e                   	pop    %esi
801078b6:	5f                   	pop    %edi
801078b7:	5d                   	pop    %ebp
801078b8:	c3                   	ret
801078b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078c0:	83 c4 1c             	add    $0x1c,%esp
  return 0;
801078c3:	31 c0                	xor    %eax,%eax
}
801078c5:	5b                   	pop    %ebx
801078c6:	5e                   	pop    %esi
801078c7:	5f                   	pop    %edi
801078c8:	5d                   	pop    %ebp
801078c9:	c3                   	ret
801078ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801078d0 <va2pa>:
// Blank page.
//PAGEBREAK!
// Blank page.

int
va2pa(uint va) {
801078d0:	55                   	push   %ebp
801078d1:	89 e5                	mov    %esp,%ebp
801078d3:	83 ec 08             	sub    $0x8,%esp
801078d6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
801078d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801078dc:	e8 9f c3 ff ff       	call   80103c80 <myproc>
  pde = &pgdir[PDX(va)];
801078e1:	89 da                	mov    %ebx,%edx
801078e3:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801078e6:	8b 40 04             	mov    0x4(%eax),%eax
801078e9:	8b 04 90             	mov    (%eax,%edx,4),%eax
801078ec:	a8 01                	test   $0x1,%al
801078ee:	0f 84 6d 01 00 00    	je     80107a61 <va2pa.cold>
  return &pgtab[PTX(va)];
801078f4:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801078f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801078fb:	c1 ea 0c             	shr    $0xc,%edx
  uint pa;
  pte_t* pte;

  pte = walkpgdir(curproc->pgdir, (char*)va, 0);
  pa = PTE_ADDR(*pte)|(va&0xfff);
801078fe:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  return &pgtab[PTX(va)];
80107904:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  pa = PTE_ADDR(*pte)|(va&0xfff);
8010790a:	8b 84 90 00 00 00 80 	mov    -0x80000000(%eax,%edx,4),%eax
80107911:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107916:	09 d8                	or     %ebx,%eax

  return pa;
}
80107918:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010791b:	89 ec                	mov    %ebp,%esp
8010791d:	5d                   	pop    %ebp
8010791e:	c3                   	ret
8010791f:	90                   	nop

80107920 <get_pgtb_size>:

int
get_pgtb_size(void) {
80107920:	55                   	push   %ebp
80107921:	89 e5                	mov    %esp,%ebp
80107923:	83 ec 08             	sub    $0x8,%esp
80107926:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct proc *curproc = myproc();
80107929:	e8 52 c3 ff ff       	call   80103c80 <myproc>
  uint page_count = 0;
8010792e:	31 c9                	xor    %ecx,%ecx
80107930:	8b 40 04             	mov    0x4(%eax),%eax
80107933:	8d 98 00 10 00 00    	lea    0x1000(%eax),%ebx
80107939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde_t *pde;

  for (int i = 0; i < 1024; i++) {
    pde = &curproc->pgdir[i];
    if ((*pde & PTE_P) == 1) {
80107940:	8b 10                	mov    (%eax),%edx
  for (int i = 0; i < 1024; i++) {
80107942:	83 c0 04             	add    $0x4,%eax
    if ((*pde & PTE_P) == 1) {
80107945:	83 e2 01             	and    $0x1,%edx
80107948:	01 d1                	add    %edx,%ecx
  for (int i = 0; i < 1024; i++) {
8010794a:	39 d8                	cmp    %ebx,%eax
8010794c:	75 f2                	jne    80107940 <get_pgtb_size+0x20>
      page_count++;
    }
  }

  return page_count;
}
8010794e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107951:	89 ec                	mov    %ebp,%esp
80107953:	89 c8                	mov    %ecx,%eax
80107955:	5d                   	pop    %ebp
80107956:	c3                   	ret
80107957:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010795e:	00 
8010795f:	90                   	nop

80107960 <get_usr_pgtb_size>:

int
get_usr_pgtb_size(void) {
80107960:	55                   	push   %ebp
80107961:	89 e5                	mov    %esp,%ebp
80107963:	83 ec 08             	sub    $0x8,%esp
80107966:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct proc *curproc = myproc();
80107969:	e8 12 c3 ff ff       	call   80103c80 <myproc>
  uint page_count = 0;
8010796e:	31 c9                	xor    %ecx,%ecx
80107970:	8b 40 04             	mov    0x4(%eax),%eax
80107973:	8d 98 00 08 00 00    	lea    0x800(%eax),%ebx
80107979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde_t *pde;

  for (int i = 0; i < 512; i++) {
    pde = &curproc->pgdir[i];
    if ((*pde & PTE_P) == 1) {
80107980:	8b 10                	mov    (%eax),%edx
  for (int i = 0; i < 512; i++) {
80107982:	83 c0 04             	add    $0x4,%eax
    if ((*pde & PTE_P) == 1) {
80107985:	83 e2 01             	and    $0x1,%edx
80107988:	01 d1                	add    %edx,%ecx
  for (int i = 0; i < 512; i++) {
8010798a:	39 d8                	cmp    %ebx,%eax
8010798c:	75 f2                	jne    80107980 <get_usr_pgtb_size+0x20>
      page_count++;
    }
  }

  return page_count;
}
8010798e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107991:	89 ec                	mov    %ebp,%esp
80107993:	89 c8                	mov    %ecx,%eax
80107995:	5d                   	pop    %ebp
80107996:	c3                   	ret
80107997:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010799e:	00 
8010799f:	90                   	nop

801079a0 <get_kernel_pgtb_size>:

int
get_kernel_pgtb_size(void) {
801079a0:	55                   	push   %ebp
801079a1:	89 e5                	mov    %esp,%ebp
801079a3:	83 ec 08             	sub    $0x8,%esp
801079a6:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  struct proc *curproc = myproc();
801079a9:	e8 d2 c2 ff ff       	call   80103c80 <myproc>
  uint page_count = 0;
801079ae:	31 c9                	xor    %ecx,%ecx
  pde_t *pde;

  for (int i = 512; i < 1024; i++) {
    pde = &curproc->pgdir[i];
801079b0:	8b 58 04             	mov    0x4(%eax),%ebx
801079b3:	8d 83 00 08 00 00    	lea    0x800(%ebx),%eax
801079b9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801079bf:	90                   	nop
    if ((*pde & PTE_P) == 1) {
801079c0:	8b 10                	mov    (%eax),%edx
  for (int i = 512; i < 1024; i++) {
801079c2:	83 c0 04             	add    $0x4,%eax
    if ((*pde & PTE_P) == 1) {
801079c5:	83 e2 01             	and    $0x1,%edx
801079c8:	01 d1                	add    %edx,%ecx
  for (int i = 512; i < 1024; i++) {
801079ca:	39 d8                	cmp    %ebx,%eax
801079cc:	75 f2                	jne    801079c0 <get_kernel_pgtb_size+0x20>
      page_count++;
    }
  }

  return page_count;
}
801079ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801079d1:	89 ec                	mov    %ebp,%esp
801079d3:	89 c8                	mov    %ecx,%eax
801079d5:	5d                   	pop    %ebp
801079d6:	c3                   	ret
801079d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801079de:	00 
801079df:	90                   	nop

801079e0 <getpapages>:

int
getpapages(pde_t *pgdir) {
801079e0:	55                   	push   %ebp
  int page_count = 0;
  pte_t* pte;

  for (int i = 0; i < 1024; i++) {
801079e1:	31 c9                	xor    %ecx,%ecx
getpapages(pde_t *pgdir) {
801079e3:	89 e5                	mov    %esp,%ebp
801079e5:	57                   	push   %edi
801079e6:	56                   	push   %esi
801079e7:	53                   	push   %ebx
  int page_count = 0;
801079e8:	31 db                	xor    %ebx,%ebx
getpapages(pde_t *pgdir) {
801079ea:	83 ec 04             	sub    $0x4,%esp
801079ed:	8b 7d 08             	mov    0x8(%ebp),%edi
    for (int j = 0; j < 1024; j++) {
801079f0:	89 4d f0             	mov    %ecx,-0x10(%ebp)
801079f3:	89 ce                	mov    %ecx,%esi
getpapages(pde_t *pgdir) {
801079f5:	31 d2                	xor    %edx,%edx
801079f7:	c1 e6 16             	shl    $0x16,%esi
801079fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      unsigned int va = (i << 22) | (j << 12);
80107a00:	89 d0                	mov    %edx,%eax
80107a02:	09 f0                	or     %esi,%eax
  pde = &pgdir[PDX(va)];
80107a04:	89 c1                	mov    %eax,%ecx
80107a06:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107a09:	8b 0c 8f             	mov    (%edi,%ecx,4),%ecx
80107a0c:	f6 c1 01             	test   $0x1,%cl
80107a0f:	74 20                	je     80107a31 <getpapages+0x51>
  return &pgtab[PTX(va)];
80107a11:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107a14:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107a1a:	25 fc 0f 00 00       	and    $0xffc,%eax
80107a1f:	8d 84 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%eax
      pte = walkpgdir(pgdir, (char*)va, 0);
      if (!pte) {
80107a26:	85 c0                	test   %eax,%eax
80107a28:	74 07                	je     80107a31 <getpapages+0x51>
        continue;
      }
      if ((*pte & PTE_P) != 0)
80107a2a:	8b 00                	mov    (%eax),%eax
80107a2c:	83 e0 01             	and    $0x1,%eax
80107a2f:	01 c3                	add    %eax,%ebx
    for (int j = 0; j < 1024; j++) {
80107a31:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107a37:	81 fa 00 00 40 00    	cmp    $0x400000,%edx
80107a3d:	75 c1                	jne    80107a00 <getpapages+0x20>
  for (int i = 0; i < 1024; i++) {
80107a3f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80107a42:	41                   	inc    %ecx
80107a43:	81 f9 00 04 00 00    	cmp    $0x400,%ecx
80107a49:	75 a5                	jne    801079f0 <getpapages+0x10>
        page_count++;
    }
  }

  return page_count;
}
80107a4b:	5a                   	pop    %edx
80107a4c:	89 d8                	mov    %ebx,%eax
80107a4e:	5b                   	pop    %ebx
80107a4f:	5e                   	pop    %esi
80107a50:	5f                   	pop    %edi
80107a51:	5d                   	pop    %ebp
80107a52:	c3                   	ret

80107a53 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107a53:	a1 00 00 00 00       	mov    0x0,%eax
80107a58:	0f 0b                	ud2

80107a5a <copyout.cold>:
80107a5a:	a1 00 00 00 00       	mov    0x0,%eax
80107a5f:	0f 0b                	ud2

80107a61 <va2pa.cold>:
  pa = PTE_ADDR(*pte)|(va&0xfff);
80107a61:	a1 00 00 00 00       	mov    0x0,%eax
80107a66:	0f 0b                	ud2
