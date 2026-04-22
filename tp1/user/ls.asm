
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	2ae000ef          	jal	ra,2be <strlen>
  14:	02051793          	slli	a5,a0,0x20
  18:	9381                	srli	a5,a5,0x20
  1a:	97a6                	add	a5,a5,s1
  1c:	02f00693          	li	a3,47
  20:	0097e963          	bltu	a5,s1,32 <fmtname+0x32>
  24:	0007c703          	lbu	a4,0(a5)
  28:	00d70563          	beq	a4,a3,32 <fmtname+0x32>
  2c:	17fd                	addi	a5,a5,-1
  2e:	fe97fbe3          	bgeu	a5,s1,24 <fmtname+0x24>
    ;
  p++;
  32:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  36:	8526                	mv	a0,s1
  38:	286000ef          	jal	ra,2be <strlen>
  3c:	2501                	sext.w	a0,a0
  3e:	47b5                	li	a5,13
  40:	00a7fa63          	bgeu	a5,a0,54 <fmtname+0x54>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  buf[sizeof(buf)-1] = '\0';
  return buf;
}
  44:	8526                	mv	a0,s1
  46:	70a2                	ld	ra,40(sp)
  48:	7402                	ld	s0,32(sp)
  4a:	64e2                	ld	s1,24(sp)
  4c:	6942                	ld	s2,16(sp)
  4e:	69a2                	ld	s3,8(sp)
  50:	6145                	addi	sp,sp,48
  52:	8082                	ret
  memmove(buf, p, strlen(p));
  54:	8526                	mv	a0,s1
  56:	268000ef          	jal	ra,2be <strlen>
  5a:	00001997          	auipc	s3,0x1
  5e:	fb698993          	addi	s3,s3,-74 # 1010 <buf.0>
  62:	0005061b          	sext.w	a2,a0
  66:	85a6                	mv	a1,s1
  68:	854e                	mv	a0,s3
  6a:	3b6000ef          	jal	ra,420 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  6e:	8526                	mv	a0,s1
  70:	24e000ef          	jal	ra,2be <strlen>
  74:	0005091b          	sext.w	s2,a0
  78:	8526                	mv	a0,s1
  7a:	244000ef          	jal	ra,2be <strlen>
  7e:	1902                	slli	s2,s2,0x20
  80:	02095913          	srli	s2,s2,0x20
  84:	4639                	li	a2,14
  86:	9e09                	subw	a2,a2,a0
  88:	02000593          	li	a1,32
  8c:	01298533          	add	a0,s3,s2
  90:	258000ef          	jal	ra,2e8 <memset>
  buf[sizeof(buf)-1] = '\0';
  94:	00098723          	sb	zero,14(s3)
  return buf;
  98:	84ce                	mv	s1,s3
  9a:	b76d                	j	44 <fmtname+0x44>

000000000000009c <ls>:

void
ls(char *path)
{
  9c:	d9010113          	addi	sp,sp,-624
  a0:	26113423          	sd	ra,616(sp)
  a4:	26813023          	sd	s0,608(sp)
  a8:	24913c23          	sd	s1,600(sp)
  ac:	25213823          	sd	s2,592(sp)
  b0:	25313423          	sd	s3,584(sp)
  b4:	25413023          	sd	s4,576(sp)
  b8:	23513c23          	sd	s5,568(sp)
  bc:	1c80                	addi	s0,sp,624
  be:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  c0:	4581                	li	a1,0
  c2:	478000ef          	jal	ra,53a <open>
  c6:	06054963          	bltz	a0,138 <ls+0x9c>
  ca:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  cc:	d9840593          	addi	a1,s0,-616
  d0:	482000ef          	jal	ra,552 <fstat>
  d4:	06054b63          	bltz	a0,14a <ls+0xae>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  d8:	da041783          	lh	a5,-608(s0)
  dc:	0007869b          	sext.w	a3,a5
  e0:	4705                	li	a4,1
  e2:	08e68063          	beq	a3,a4,162 <ls+0xc6>
  e6:	37f9                	addiw	a5,a5,-2
  e8:	17c2                	slli	a5,a5,0x30
  ea:	93c1                	srli	a5,a5,0x30
  ec:	02f76263          	bltu	a4,a5,110 <ls+0x74>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
  f0:	854a                	mv	a0,s2
  f2:	f0fff0ef          	jal	ra,0 <fmtname>
  f6:	85aa                	mv	a1,a0
  f8:	da842703          	lw	a4,-600(s0)
  fc:	d9c42683          	lw	a3,-612(s0)
 100:	da041603          	lh	a2,-608(s0)
 104:	00001517          	auipc	a0,0x1
 108:	9dc50513          	addi	a0,a0,-1572 # ae0 <malloc+0x10e>
 10c:	013000ef          	jal	ra,91e <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
 110:	8526                	mv	a0,s1
 112:	410000ef          	jal	ra,522 <close>
}
 116:	26813083          	ld	ra,616(sp)
 11a:	26013403          	ld	s0,608(sp)
 11e:	25813483          	ld	s1,600(sp)
 122:	25013903          	ld	s2,592(sp)
 126:	24813983          	ld	s3,584(sp)
 12a:	24013a03          	ld	s4,576(sp)
 12e:	23813a83          	ld	s5,568(sp)
 132:	27010113          	addi	sp,sp,624
 136:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 138:	864a                	mv	a2,s2
 13a:	00001597          	auipc	a1,0x1
 13e:	97658593          	addi	a1,a1,-1674 # ab0 <malloc+0xde>
 142:	4509                	li	a0,2
 144:	7b0000ef          	jal	ra,8f4 <fprintf>
    return;
 148:	b7f9                	j	116 <ls+0x7a>
    fprintf(2, "ls: cannot stat %s\n", path);
 14a:	864a                	mv	a2,s2
 14c:	00001597          	auipc	a1,0x1
 150:	97c58593          	addi	a1,a1,-1668 # ac8 <malloc+0xf6>
 154:	4509                	li	a0,2
 156:	79e000ef          	jal	ra,8f4 <fprintf>
    close(fd);
 15a:	8526                	mv	a0,s1
 15c:	3c6000ef          	jal	ra,522 <close>
    return;
 160:	bf5d                	j	116 <ls+0x7a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 162:	854a                	mv	a0,s2
 164:	15a000ef          	jal	ra,2be <strlen>
 168:	2541                	addiw	a0,a0,16
 16a:	20000793          	li	a5,512
 16e:	00a7f963          	bgeu	a5,a0,180 <ls+0xe4>
      printf("ls: path too long\n");
 172:	00001517          	auipc	a0,0x1
 176:	97e50513          	addi	a0,a0,-1666 # af0 <malloc+0x11e>
 17a:	7a4000ef          	jal	ra,91e <printf>
      break;
 17e:	bf49                	j	110 <ls+0x74>
    strcpy(buf, path);
 180:	85ca                	mv	a1,s2
 182:	dc040513          	addi	a0,s0,-576
 186:	0f0000ef          	jal	ra,276 <strcpy>
    p = buf+strlen(buf);
 18a:	dc040513          	addi	a0,s0,-576
 18e:	130000ef          	jal	ra,2be <strlen>
 192:	1502                	slli	a0,a0,0x20
 194:	9101                	srli	a0,a0,0x20
 196:	dc040793          	addi	a5,s0,-576
 19a:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 19e:	00190993          	addi	s3,s2,1
 1a2:	02f00793          	li	a5,47
 1a6:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1aa:	00001a17          	auipc	s4,0x1
 1ae:	936a0a13          	addi	s4,s4,-1738 # ae0 <malloc+0x10e>
        printf("ls: cannot stat %s\n", buf);
 1b2:	00001a97          	auipc	s5,0x1
 1b6:	916a8a93          	addi	s5,s5,-1770 # ac8 <malloc+0xf6>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ba:	a031                	j	1c6 <ls+0x12a>
        printf("ls: cannot stat %s\n", buf);
 1bc:	dc040593          	addi	a1,s0,-576
 1c0:	8556                	mv	a0,s5
 1c2:	75c000ef          	jal	ra,91e <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1c6:	4641                	li	a2,16
 1c8:	db040593          	addi	a1,s0,-592
 1cc:	8526                	mv	a0,s1
 1ce:	344000ef          	jal	ra,512 <read>
 1d2:	47c1                	li	a5,16
 1d4:	f2f51ee3          	bne	a0,a5,110 <ls+0x74>
      if(de.inum == 0)
 1d8:	db045783          	lhu	a5,-592(s0)
 1dc:	d7ed                	beqz	a5,1c6 <ls+0x12a>
      memmove(p, de.name, DIRSIZ);
 1de:	4639                	li	a2,14
 1e0:	db240593          	addi	a1,s0,-590
 1e4:	854e                	mv	a0,s3
 1e6:	23a000ef          	jal	ra,420 <memmove>
      p[DIRSIZ] = 0;
 1ea:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 1ee:	d9840593          	addi	a1,s0,-616
 1f2:	dc040513          	addi	a0,s0,-576
 1f6:	1a8000ef          	jal	ra,39e <stat>
 1fa:	fc0541e3          	bltz	a0,1bc <ls+0x120>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1fe:	dc040513          	addi	a0,s0,-576
 202:	dffff0ef          	jal	ra,0 <fmtname>
 206:	85aa                	mv	a1,a0
 208:	da842703          	lw	a4,-600(s0)
 20c:	d9c42683          	lw	a3,-612(s0)
 210:	da041603          	lh	a2,-608(s0)
 214:	8552                	mv	a0,s4
 216:	708000ef          	jal	ra,91e <printf>
 21a:	b775                	j	1c6 <ls+0x12a>

000000000000021c <main>:

int
main(int argc, char *argv[])
{
 21c:	1101                	addi	sp,sp,-32
 21e:	ec06                	sd	ra,24(sp)
 220:	e822                	sd	s0,16(sp)
 222:	e426                	sd	s1,8(sp)
 224:	e04a                	sd	s2,0(sp)
 226:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 228:	4785                	li	a5,1
 22a:	02a7d563          	bge	a5,a0,254 <main+0x38>
 22e:	00858493          	addi	s1,a1,8
 232:	ffe5091b          	addiw	s2,a0,-2
 236:	02091793          	slli	a5,s2,0x20
 23a:	01d7d913          	srli	s2,a5,0x1d
 23e:	05c1                	addi	a1,a1,16
 240:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 242:	6088                	ld	a0,0(s1)
 244:	e59ff0ef          	jal	ra,9c <ls>
  for(i=1; i<argc; i++)
 248:	04a1                	addi	s1,s1,8
 24a:	ff249ce3          	bne	s1,s2,242 <main+0x26>
  exit(0);
 24e:	4501                	li	a0,0
 250:	2aa000ef          	jal	ra,4fa <exit>
    ls(".");
 254:	00001517          	auipc	a0,0x1
 258:	8b450513          	addi	a0,a0,-1868 # b08 <malloc+0x136>
 25c:	e41ff0ef          	jal	ra,9c <ls>
    exit(0);
 260:	4501                	li	a0,0
 262:	298000ef          	jal	ra,4fa <exit>

0000000000000266 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 266:	1141                	addi	sp,sp,-16
 268:	e406                	sd	ra,8(sp)
 26a:	e022                	sd	s0,0(sp)
 26c:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 26e:	fafff0ef          	jal	ra,21c <main>
  exit(r);
 272:	288000ef          	jal	ra,4fa <exit>

0000000000000276 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 276:	1141                	addi	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 27c:	87aa                	mv	a5,a0
 27e:	0585                	addi	a1,a1,1
 280:	0785                	addi	a5,a5,1
 282:	fff5c703          	lbu	a4,-1(a1)
 286:	fee78fa3          	sb	a4,-1(a5)
 28a:	fb75                	bnez	a4,27e <strcpy+0x8>
    ;
  return os;
}
 28c:	6422                	ld	s0,8(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret

0000000000000292 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 292:	1141                	addi	sp,sp,-16
 294:	e422                	sd	s0,8(sp)
 296:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 298:	00054783          	lbu	a5,0(a0)
 29c:	cb91                	beqz	a5,2b0 <strcmp+0x1e>
 29e:	0005c703          	lbu	a4,0(a1)
 2a2:	00f71763          	bne	a4,a5,2b0 <strcmp+0x1e>
    p++, q++;
 2a6:	0505                	addi	a0,a0,1
 2a8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2aa:	00054783          	lbu	a5,0(a0)
 2ae:	fbe5                	bnez	a5,29e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2b0:	0005c503          	lbu	a0,0(a1)
}
 2b4:	40a7853b          	subw	a0,a5,a0
 2b8:	6422                	ld	s0,8(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <strlen>:

uint
strlen(const char *s)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e422                	sd	s0,8(sp)
 2c2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c4:	00054783          	lbu	a5,0(a0)
 2c8:	cf91                	beqz	a5,2e4 <strlen+0x26>
 2ca:	0505                	addi	a0,a0,1
 2cc:	87aa                	mv	a5,a0
 2ce:	4685                	li	a3,1
 2d0:	9e89                	subw	a3,a3,a0
 2d2:	00f6853b          	addw	a0,a3,a5
 2d6:	0785                	addi	a5,a5,1
 2d8:	fff7c703          	lbu	a4,-1(a5)
 2dc:	fb7d                	bnez	a4,2d2 <strlen+0x14>
    ;
  return n;
}
 2de:	6422                	ld	s0,8(sp)
 2e0:	0141                	addi	sp,sp,16
 2e2:	8082                	ret
  for(n = 0; s[n]; n++)
 2e4:	4501                	li	a0,0
 2e6:	bfe5                	j	2de <strlen+0x20>

00000000000002e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2ee:	ca19                	beqz	a2,304 <memset+0x1c>
 2f0:	87aa                	mv	a5,a0
 2f2:	1602                	slli	a2,a2,0x20
 2f4:	9201                	srli	a2,a2,0x20
 2f6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2fa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2fe:	0785                	addi	a5,a5,1
 300:	fee79de3          	bne	a5,a4,2fa <memset+0x12>
  }
  return dst;
}
 304:	6422                	ld	s0,8(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret

000000000000030a <strchr>:

char*
strchr(const char *s, char c)
{
 30a:	1141                	addi	sp,sp,-16
 30c:	e422                	sd	s0,8(sp)
 30e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 310:	00054783          	lbu	a5,0(a0)
 314:	cb99                	beqz	a5,32a <strchr+0x20>
    if(*s == c)
 316:	00f58763          	beq	a1,a5,324 <strchr+0x1a>
  for(; *s; s++)
 31a:	0505                	addi	a0,a0,1
 31c:	00054783          	lbu	a5,0(a0)
 320:	fbfd                	bnez	a5,316 <strchr+0xc>
      return (char*)s;
  return 0;
 322:	4501                	li	a0,0
}
 324:	6422                	ld	s0,8(sp)
 326:	0141                	addi	sp,sp,16
 328:	8082                	ret
  return 0;
 32a:	4501                	li	a0,0
 32c:	bfe5                	j	324 <strchr+0x1a>

000000000000032e <gets>:

char*
gets(char *buf, int max)
{
 32e:	711d                	addi	sp,sp,-96
 330:	ec86                	sd	ra,88(sp)
 332:	e8a2                	sd	s0,80(sp)
 334:	e4a6                	sd	s1,72(sp)
 336:	e0ca                	sd	s2,64(sp)
 338:	fc4e                	sd	s3,56(sp)
 33a:	f852                	sd	s4,48(sp)
 33c:	f456                	sd	s5,40(sp)
 33e:	f05a                	sd	s6,32(sp)
 340:	ec5e                	sd	s7,24(sp)
 342:	1080                	addi	s0,sp,96
 344:	8baa                	mv	s7,a0
 346:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 348:	892a                	mv	s2,a0
 34a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 34c:	4aa9                	li	s5,10
 34e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 350:	89a6                	mv	s3,s1
 352:	2485                	addiw	s1,s1,1
 354:	0344d663          	bge	s1,s4,380 <gets+0x52>
    cc = read(0, &c, 1);
 358:	4605                	li	a2,1
 35a:	faf40593          	addi	a1,s0,-81
 35e:	4501                	li	a0,0
 360:	1b2000ef          	jal	ra,512 <read>
    if(cc < 1)
 364:	00a05e63          	blez	a0,380 <gets+0x52>
    buf[i++] = c;
 368:	faf44783          	lbu	a5,-81(s0)
 36c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 370:	01578763          	beq	a5,s5,37e <gets+0x50>
 374:	0905                	addi	s2,s2,1
 376:	fd679de3          	bne	a5,s6,350 <gets+0x22>
  for(i=0; i+1 < max; ){
 37a:	89a6                	mv	s3,s1
 37c:	a011                	j	380 <gets+0x52>
 37e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 380:	99de                	add	s3,s3,s7
 382:	00098023          	sb	zero,0(s3)
  return buf;
}
 386:	855e                	mv	a0,s7
 388:	60e6                	ld	ra,88(sp)
 38a:	6446                	ld	s0,80(sp)
 38c:	64a6                	ld	s1,72(sp)
 38e:	6906                	ld	s2,64(sp)
 390:	79e2                	ld	s3,56(sp)
 392:	7a42                	ld	s4,48(sp)
 394:	7aa2                	ld	s5,40(sp)
 396:	7b02                	ld	s6,32(sp)
 398:	6be2                	ld	s7,24(sp)
 39a:	6125                	addi	sp,sp,96
 39c:	8082                	ret

000000000000039e <stat>:

int
stat(const char *n, struct stat *st)
{
 39e:	1101                	addi	sp,sp,-32
 3a0:	ec06                	sd	ra,24(sp)
 3a2:	e822                	sd	s0,16(sp)
 3a4:	e426                	sd	s1,8(sp)
 3a6:	e04a                	sd	s2,0(sp)
 3a8:	1000                	addi	s0,sp,32
 3aa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3ac:	4581                	li	a1,0
 3ae:	18c000ef          	jal	ra,53a <open>
  if(fd < 0)
 3b2:	02054163          	bltz	a0,3d4 <stat+0x36>
 3b6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3b8:	85ca                	mv	a1,s2
 3ba:	198000ef          	jal	ra,552 <fstat>
 3be:	892a                	mv	s2,a0
  close(fd);
 3c0:	8526                	mv	a0,s1
 3c2:	160000ef          	jal	ra,522 <close>
  return r;
}
 3c6:	854a                	mv	a0,s2
 3c8:	60e2                	ld	ra,24(sp)
 3ca:	6442                	ld	s0,16(sp)
 3cc:	64a2                	ld	s1,8(sp)
 3ce:	6902                	ld	s2,0(sp)
 3d0:	6105                	addi	sp,sp,32
 3d2:	8082                	ret
    return -1;
 3d4:	597d                	li	s2,-1
 3d6:	bfc5                	j	3c6 <stat+0x28>

00000000000003d8 <atoi>:

int
atoi(const char *s)
{
 3d8:	1141                	addi	sp,sp,-16
 3da:	e422                	sd	s0,8(sp)
 3dc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3de:	00054683          	lbu	a3,0(a0)
 3e2:	fd06879b          	addiw	a5,a3,-48
 3e6:	0ff7f793          	zext.b	a5,a5
 3ea:	4625                	li	a2,9
 3ec:	02f66863          	bltu	a2,a5,41c <atoi+0x44>
 3f0:	872a                	mv	a4,a0
  n = 0;
 3f2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3f4:	0705                	addi	a4,a4,1
 3f6:	0025179b          	slliw	a5,a0,0x2
 3fa:	9fa9                	addw	a5,a5,a0
 3fc:	0017979b          	slliw	a5,a5,0x1
 400:	9fb5                	addw	a5,a5,a3
 402:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 406:	00074683          	lbu	a3,0(a4)
 40a:	fd06879b          	addiw	a5,a3,-48
 40e:	0ff7f793          	zext.b	a5,a5
 412:	fef671e3          	bgeu	a2,a5,3f4 <atoi+0x1c>
  return n;
}
 416:	6422                	ld	s0,8(sp)
 418:	0141                	addi	sp,sp,16
 41a:	8082                	ret
  n = 0;
 41c:	4501                	li	a0,0
 41e:	bfe5                	j	416 <atoi+0x3e>

0000000000000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 426:	02b57463          	bgeu	a0,a1,44e <memmove+0x2e>
    while(n-- > 0)
 42a:	00c05f63          	blez	a2,448 <memmove+0x28>
 42e:	1602                	slli	a2,a2,0x20
 430:	9201                	srli	a2,a2,0x20
 432:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 436:	872a                	mv	a4,a0
      *dst++ = *src++;
 438:	0585                	addi	a1,a1,1
 43a:	0705                	addi	a4,a4,1
 43c:	fff5c683          	lbu	a3,-1(a1)
 440:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 444:	fee79ae3          	bne	a5,a4,438 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 448:	6422                	ld	s0,8(sp)
 44a:	0141                	addi	sp,sp,16
 44c:	8082                	ret
    dst += n;
 44e:	00c50733          	add	a4,a0,a2
    src += n;
 452:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 454:	fec05ae3          	blez	a2,448 <memmove+0x28>
 458:	fff6079b          	addiw	a5,a2,-1
 45c:	1782                	slli	a5,a5,0x20
 45e:	9381                	srli	a5,a5,0x20
 460:	fff7c793          	not	a5,a5
 464:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 466:	15fd                	addi	a1,a1,-1
 468:	177d                	addi	a4,a4,-1
 46a:	0005c683          	lbu	a3,0(a1)
 46e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 472:	fee79ae3          	bne	a5,a4,466 <memmove+0x46>
 476:	bfc9                	j	448 <memmove+0x28>

0000000000000478 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 478:	1141                	addi	sp,sp,-16
 47a:	e422                	sd	s0,8(sp)
 47c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 47e:	ca05                	beqz	a2,4ae <memcmp+0x36>
 480:	fff6069b          	addiw	a3,a2,-1
 484:	1682                	slli	a3,a3,0x20
 486:	9281                	srli	a3,a3,0x20
 488:	0685                	addi	a3,a3,1
 48a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 48c:	00054783          	lbu	a5,0(a0)
 490:	0005c703          	lbu	a4,0(a1)
 494:	00e79863          	bne	a5,a4,4a4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 498:	0505                	addi	a0,a0,1
    p2++;
 49a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 49c:	fed518e3          	bne	a0,a3,48c <memcmp+0x14>
  }
  return 0;
 4a0:	4501                	li	a0,0
 4a2:	a019                	j	4a8 <memcmp+0x30>
      return *p1 - *p2;
 4a4:	40e7853b          	subw	a0,a5,a4
}
 4a8:	6422                	ld	s0,8(sp)
 4aa:	0141                	addi	sp,sp,16
 4ac:	8082                	ret
  return 0;
 4ae:	4501                	li	a0,0
 4b0:	bfe5                	j	4a8 <memcmp+0x30>

00000000000004b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4b2:	1141                	addi	sp,sp,-16
 4b4:	e406                	sd	ra,8(sp)
 4b6:	e022                	sd	s0,0(sp)
 4b8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4ba:	f67ff0ef          	jal	ra,420 <memmove>
}
 4be:	60a2                	ld	ra,8(sp)
 4c0:	6402                	ld	s0,0(sp)
 4c2:	0141                	addi	sp,sp,16
 4c4:	8082                	ret

00000000000004c6 <sbrk>:

char *
sbrk(int n) {
 4c6:	1141                	addi	sp,sp,-16
 4c8:	e406                	sd	ra,8(sp)
 4ca:	e022                	sd	s0,0(sp)
 4cc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4ce:	4585                	li	a1,1
 4d0:	0b2000ef          	jal	ra,582 <sys_sbrk>
}
 4d4:	60a2                	ld	ra,8(sp)
 4d6:	6402                	ld	s0,0(sp)
 4d8:	0141                	addi	sp,sp,16
 4da:	8082                	ret

00000000000004dc <sbrklazy>:

char *
sbrklazy(int n) {
 4dc:	1141                	addi	sp,sp,-16
 4de:	e406                	sd	ra,8(sp)
 4e0:	e022                	sd	s0,0(sp)
 4e2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4e4:	4589                	li	a1,2
 4e6:	09c000ef          	jal	ra,582 <sys_sbrk>
}
 4ea:	60a2                	ld	ra,8(sp)
 4ec:	6402                	ld	s0,0(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret

00000000000004f2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4f2:	4885                	li	a7,1
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <exit>:
.global exit
exit:
 li a7, SYS_exit
 4fa:	4889                	li	a7,2
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <wait>:
.global wait
wait:
 li a7, SYS_wait
 502:	488d                	li	a7,3
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 50a:	4891                	li	a7,4
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <read>:
.global read
read:
 li a7, SYS_read
 512:	4895                	li	a7,5
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <write>:
.global write
write:
 li a7, SYS_write
 51a:	48c1                	li	a7,16
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <close>:
.global close
close:
 li a7, SYS_close
 522:	48d5                	li	a7,21
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <kill>:
.global kill
kill:
 li a7, SYS_kill
 52a:	4899                	li	a7,6
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <exec>:
.global exec
exec:
 li a7, SYS_exec
 532:	489d                	li	a7,7
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <open>:
.global open
open:
 li a7, SYS_open
 53a:	48bd                	li	a7,15
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 542:	48c5                	li	a7,17
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 54a:	48c9                	li	a7,18
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 552:	48a1                	li	a7,8
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <link>:
.global link
link:
 li a7, SYS_link
 55a:	48cd                	li	a7,19
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 562:	48d1                	li	a7,20
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 56a:	48a5                	li	a7,9
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <dup>:
.global dup
dup:
 li a7, SYS_dup
 572:	48a9                	li	a7,10
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 57a:	48ad                	li	a7,11
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 582:	48b1                	li	a7,12
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <pause>:
.global pause
pause:
 li a7, SYS_pause
 58a:	48b5                	li	a7,13
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 592:	48b9                	li	a7,14
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <getcnt>:
.global getcnt
getcnt:
 li a7, SYS_getcnt
 59a:	48d9                	li	a7,22
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5a2:	1101                	addi	sp,sp,-32
 5a4:	ec06                	sd	ra,24(sp)
 5a6:	e822                	sd	s0,16(sp)
 5a8:	1000                	addi	s0,sp,32
 5aa:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5ae:	4605                	li	a2,1
 5b0:	fef40593          	addi	a1,s0,-17
 5b4:	f67ff0ef          	jal	ra,51a <write>
}
 5b8:	60e2                	ld	ra,24(sp)
 5ba:	6442                	ld	s0,16(sp)
 5bc:	6105                	addi	sp,sp,32
 5be:	8082                	ret

00000000000005c0 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5c0:	715d                	addi	sp,sp,-80
 5c2:	e486                	sd	ra,72(sp)
 5c4:	e0a2                	sd	s0,64(sp)
 5c6:	fc26                	sd	s1,56(sp)
 5c8:	f84a                	sd	s2,48(sp)
 5ca:	f44e                	sd	s3,40(sp)
 5cc:	0880                	addi	s0,sp,80
 5ce:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 5d0:	c299                	beqz	a3,5d6 <printint+0x16>
 5d2:	0805c163          	bltz	a1,654 <printint+0x94>
  neg = 0;
 5d6:	4881                	li	a7,0
 5d8:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5dc:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 5de:	00000517          	auipc	a0,0x0
 5e2:	53a50513          	addi	a0,a0,1338 # b18 <digits>
 5e6:	883e                	mv	a6,a5
 5e8:	2785                	addiw	a5,a5,1
 5ea:	02c5f733          	remu	a4,a1,a2
 5ee:	972a                	add	a4,a4,a0
 5f0:	00074703          	lbu	a4,0(a4)
 5f4:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 5f8:	872e                	mv	a4,a1
 5fa:	02c5d5b3          	divu	a1,a1,a2
 5fe:	0685                	addi	a3,a3,1
 600:	fec773e3          	bgeu	a4,a2,5e6 <printint+0x26>
  if(neg)
 604:	00088b63          	beqz	a7,61a <printint+0x5a>
    buf[i++] = '-';
 608:	fd078793          	addi	a5,a5,-48
 60c:	97a2                	add	a5,a5,s0
 60e:	02d00713          	li	a4,45
 612:	fee78423          	sb	a4,-24(a5)
 616:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 61a:	02f05663          	blez	a5,646 <printint+0x86>
 61e:	fb840713          	addi	a4,s0,-72
 622:	00f704b3          	add	s1,a4,a5
 626:	fff70993          	addi	s3,a4,-1
 62a:	99be                	add	s3,s3,a5
 62c:	37fd                	addiw	a5,a5,-1
 62e:	1782                	slli	a5,a5,0x20
 630:	9381                	srli	a5,a5,0x20
 632:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 636:	fff4c583          	lbu	a1,-1(s1)
 63a:	854a                	mv	a0,s2
 63c:	f67ff0ef          	jal	ra,5a2 <putc>
  while(--i >= 0)
 640:	14fd                	addi	s1,s1,-1
 642:	ff349ae3          	bne	s1,s3,636 <printint+0x76>
}
 646:	60a6                	ld	ra,72(sp)
 648:	6406                	ld	s0,64(sp)
 64a:	74e2                	ld	s1,56(sp)
 64c:	7942                	ld	s2,48(sp)
 64e:	79a2                	ld	s3,40(sp)
 650:	6161                	addi	sp,sp,80
 652:	8082                	ret
    x = -xx;
 654:	40b005b3          	neg	a1,a1
    neg = 1;
 658:	4885                	li	a7,1
    x = -xx;
 65a:	bfbd                	j	5d8 <printint+0x18>

000000000000065c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 65c:	7119                	addi	sp,sp,-128
 65e:	fc86                	sd	ra,120(sp)
 660:	f8a2                	sd	s0,112(sp)
 662:	f4a6                	sd	s1,104(sp)
 664:	f0ca                	sd	s2,96(sp)
 666:	ecce                	sd	s3,88(sp)
 668:	e8d2                	sd	s4,80(sp)
 66a:	e4d6                	sd	s5,72(sp)
 66c:	e0da                	sd	s6,64(sp)
 66e:	fc5e                	sd	s7,56(sp)
 670:	f862                	sd	s8,48(sp)
 672:	f466                	sd	s9,40(sp)
 674:	f06a                	sd	s10,32(sp)
 676:	ec6e                	sd	s11,24(sp)
 678:	0100                	addi	s0,sp,128
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 67a:	0005c903          	lbu	s2,0(a1)
 67e:	24090c63          	beqz	s2,8d6 <vprintf+0x27a>
 682:	8b2a                	mv	s6,a0
 684:	8a2e                	mv	s4,a1
 686:	8bb2                	mv	s7,a2
  state = 0;
 688:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 68a:	4481                	li	s1,0
 68c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 68e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 692:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 696:	06c00d13          	li	s10,108
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 69a:	07500d93          	li	s11,117
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 69e:	00000c97          	auipc	s9,0x0
 6a2:	47ac8c93          	addi	s9,s9,1146 # b18 <digits>
 6a6:	a005                	j	6c6 <vprintf+0x6a>
        putc(fd, c0);
 6a8:	85ca                	mv	a1,s2
 6aa:	855a                	mv	a0,s6
 6ac:	ef7ff0ef          	jal	ra,5a2 <putc>
 6b0:	a019                	j	6b6 <vprintf+0x5a>
    } else if(state == '%'){
 6b2:	03598263          	beq	s3,s5,6d6 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6b6:	2485                	addiw	s1,s1,1
 6b8:	8726                	mv	a4,s1
 6ba:	009a07b3          	add	a5,s4,s1
 6be:	0007c903          	lbu	s2,0(a5)
 6c2:	20090a63          	beqz	s2,8d6 <vprintf+0x27a>
    c0 = fmt[i] & 0xff;
 6c6:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6ca:	fe0994e3          	bnez	s3,6b2 <vprintf+0x56>
      if(c0 == '%'){
 6ce:	fd579de3          	bne	a5,s5,6a8 <vprintf+0x4c>
        state = '%';
 6d2:	89be                	mv	s3,a5
 6d4:	b7cd                	j	6b6 <vprintf+0x5a>
      if(c0) c1 = fmt[i+1] & 0xff;
 6d6:	c3c1                	beqz	a5,756 <vprintf+0xfa>
 6d8:	00ea06b3          	add	a3,s4,a4
 6dc:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6e0:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6e2:	c681                	beqz	a3,6ea <vprintf+0x8e>
 6e4:	9752                	add	a4,a4,s4
 6e6:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6ea:	03878e63          	beq	a5,s8,726 <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 6ee:	05a78863          	beq	a5,s10,73e <vprintf+0xe2>
      } else if(c0 == 'u'){
 6f2:	0db78b63          	beq	a5,s11,7c8 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6f6:	07800713          	li	a4,120
 6fa:	10e78d63          	beq	a5,a4,814 <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6fe:	07000713          	li	a4,112
 702:	14e78263          	beq	a5,a4,846 <vprintf+0x1ea>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 706:	06300713          	li	a4,99
 70a:	16e78f63          	beq	a5,a4,888 <vprintf+0x22c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 70e:	07300713          	li	a4,115
 712:	18e78563          	beq	a5,a4,89c <vprintf+0x240>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 716:	05579063          	bne	a5,s5,756 <vprintf+0xfa>
        putc(fd, '%');
 71a:	85d6                	mv	a1,s5
 71c:	855a                	mv	a0,s6
 71e:	e85ff0ef          	jal	ra,5a2 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 722:	4981                	li	s3,0
 724:	bf49                	j	6b6 <vprintf+0x5a>
        printint(fd, va_arg(ap, int), 10, 1);
 726:	008b8913          	addi	s2,s7,8
 72a:	4685                	li	a3,1
 72c:	4629                	li	a2,10
 72e:	000ba583          	lw	a1,0(s7)
 732:	855a                	mv	a0,s6
 734:	e8dff0ef          	jal	ra,5c0 <printint>
 738:	8bca                	mv	s7,s2
      state = 0;
 73a:	4981                	li	s3,0
 73c:	bfad                	j	6b6 <vprintf+0x5a>
      } else if(c0 == 'l' && c1 == 'd'){
 73e:	03868663          	beq	a3,s8,76a <vprintf+0x10e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 742:	05a68163          	beq	a3,s10,784 <vprintf+0x128>
      } else if(c0 == 'l' && c1 == 'u'){
 746:	09b68d63          	beq	a3,s11,7e0 <vprintf+0x184>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 74a:	03a68f63          	beq	a3,s10,788 <vprintf+0x12c>
      } else if(c0 == 'l' && c1 == 'x'){
 74e:	07800793          	li	a5,120
 752:	0cf68d63          	beq	a3,a5,82c <vprintf+0x1d0>
        putc(fd, '%');
 756:	85d6                	mv	a1,s5
 758:	855a                	mv	a0,s6
 75a:	e49ff0ef          	jal	ra,5a2 <putc>
        putc(fd, c0);
 75e:	85ca                	mv	a1,s2
 760:	855a                	mv	a0,s6
 762:	e41ff0ef          	jal	ra,5a2 <putc>
      state = 0;
 766:	4981                	li	s3,0
 768:	b7b9                	j	6b6 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 76a:	008b8913          	addi	s2,s7,8
 76e:	4685                	li	a3,1
 770:	4629                	li	a2,10
 772:	000bb583          	ld	a1,0(s7)
 776:	855a                	mv	a0,s6
 778:	e49ff0ef          	jal	ra,5c0 <printint>
        i += 1;
 77c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 77e:	8bca                	mv	s7,s2
      state = 0;
 780:	4981                	li	s3,0
        i += 1;
 782:	bf15                	j	6b6 <vprintf+0x5a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 784:	03860563          	beq	a2,s8,7ae <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 788:	07b60963          	beq	a2,s11,7fa <vprintf+0x19e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 78c:	07800793          	li	a5,120
 790:	fcf613e3          	bne	a2,a5,756 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 794:	008b8913          	addi	s2,s7,8
 798:	4681                	li	a3,0
 79a:	4641                	li	a2,16
 79c:	000bb583          	ld	a1,0(s7)
 7a0:	855a                	mv	a0,s6
 7a2:	e1fff0ef          	jal	ra,5c0 <printint>
        i += 2;
 7a6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 7a8:	8bca                	mv	s7,s2
      state = 0;
 7aa:	4981                	li	s3,0
        i += 2;
 7ac:	b729                	j	6b6 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7ae:	008b8913          	addi	s2,s7,8
 7b2:	4685                	li	a3,1
 7b4:	4629                	li	a2,10
 7b6:	000bb583          	ld	a1,0(s7)
 7ba:	855a                	mv	a0,s6
 7bc:	e05ff0ef          	jal	ra,5c0 <printint>
        i += 2;
 7c0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7c2:	8bca                	mv	s7,s2
      state = 0;
 7c4:	4981                	li	s3,0
        i += 2;
 7c6:	bdc5                	j	6b6 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7c8:	008b8913          	addi	s2,s7,8
 7cc:	4681                	li	a3,0
 7ce:	4629                	li	a2,10
 7d0:	000be583          	lwu	a1,0(s7)
 7d4:	855a                	mv	a0,s6
 7d6:	debff0ef          	jal	ra,5c0 <printint>
 7da:	8bca                	mv	s7,s2
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	bde1                	j	6b6 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7e0:	008b8913          	addi	s2,s7,8
 7e4:	4681                	li	a3,0
 7e6:	4629                	li	a2,10
 7e8:	000bb583          	ld	a1,0(s7)
 7ec:	855a                	mv	a0,s6
 7ee:	dd3ff0ef          	jal	ra,5c0 <printint>
        i += 1;
 7f2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f4:	8bca                	mv	s7,s2
      state = 0;
 7f6:	4981                	li	s3,0
        i += 1;
 7f8:	bd7d                	j	6b6 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7fa:	008b8913          	addi	s2,s7,8
 7fe:	4681                	li	a3,0
 800:	4629                	li	a2,10
 802:	000bb583          	ld	a1,0(s7)
 806:	855a                	mv	a0,s6
 808:	db9ff0ef          	jal	ra,5c0 <printint>
        i += 2;
 80c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 80e:	8bca                	mv	s7,s2
      state = 0;
 810:	4981                	li	s3,0
        i += 2;
 812:	b555                	j	6b6 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 814:	008b8913          	addi	s2,s7,8
 818:	4681                	li	a3,0
 81a:	4641                	li	a2,16
 81c:	000be583          	lwu	a1,0(s7)
 820:	855a                	mv	a0,s6
 822:	d9fff0ef          	jal	ra,5c0 <printint>
 826:	8bca                	mv	s7,s2
      state = 0;
 828:	4981                	li	s3,0
 82a:	b571                	j	6b6 <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 82c:	008b8913          	addi	s2,s7,8
 830:	4681                	li	a3,0
 832:	4641                	li	a2,16
 834:	000bb583          	ld	a1,0(s7)
 838:	855a                	mv	a0,s6
 83a:	d87ff0ef          	jal	ra,5c0 <printint>
        i += 1;
 83e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 840:	8bca                	mv	s7,s2
      state = 0;
 842:	4981                	li	s3,0
        i += 1;
 844:	bd8d                	j	6b6 <vprintf+0x5a>
        printptr(fd, va_arg(ap, uint64));
 846:	008b8793          	addi	a5,s7,8
 84a:	f8f43423          	sd	a5,-120(s0)
 84e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 852:	03000593          	li	a1,48
 856:	855a                	mv	a0,s6
 858:	d4bff0ef          	jal	ra,5a2 <putc>
  putc(fd, 'x');
 85c:	07800593          	li	a1,120
 860:	855a                	mv	a0,s6
 862:	d41ff0ef          	jal	ra,5a2 <putc>
 866:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 868:	03c9d793          	srli	a5,s3,0x3c
 86c:	97e6                	add	a5,a5,s9
 86e:	0007c583          	lbu	a1,0(a5)
 872:	855a                	mv	a0,s6
 874:	d2fff0ef          	jal	ra,5a2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 878:	0992                	slli	s3,s3,0x4
 87a:	397d                	addiw	s2,s2,-1
 87c:	fe0916e3          	bnez	s2,868 <vprintf+0x20c>
        printptr(fd, va_arg(ap, uint64));
 880:	f8843b83          	ld	s7,-120(s0)
      state = 0;
 884:	4981                	li	s3,0
 886:	bd05                	j	6b6 <vprintf+0x5a>
        putc(fd, va_arg(ap, uint32));
 888:	008b8913          	addi	s2,s7,8
 88c:	000bc583          	lbu	a1,0(s7)
 890:	855a                	mv	a0,s6
 892:	d11ff0ef          	jal	ra,5a2 <putc>
 896:	8bca                	mv	s7,s2
      state = 0;
 898:	4981                	li	s3,0
 89a:	bd31                	j	6b6 <vprintf+0x5a>
        if((s = va_arg(ap, char*)) == 0)
 89c:	008b8993          	addi	s3,s7,8
 8a0:	000bb903          	ld	s2,0(s7)
 8a4:	00090f63          	beqz	s2,8c2 <vprintf+0x266>
        for(; *s; s++)
 8a8:	00094583          	lbu	a1,0(s2)
 8ac:	c195                	beqz	a1,8d0 <vprintf+0x274>
          putc(fd, *s);
 8ae:	855a                	mv	a0,s6
 8b0:	cf3ff0ef          	jal	ra,5a2 <putc>
        for(; *s; s++)
 8b4:	0905                	addi	s2,s2,1
 8b6:	00094583          	lbu	a1,0(s2)
 8ba:	f9f5                	bnez	a1,8ae <vprintf+0x252>
        if((s = va_arg(ap, char*)) == 0)
 8bc:	8bce                	mv	s7,s3
      state = 0;
 8be:	4981                	li	s3,0
 8c0:	bbdd                	j	6b6 <vprintf+0x5a>
          s = "(null)";
 8c2:	00000917          	auipc	s2,0x0
 8c6:	24e90913          	addi	s2,s2,590 # b10 <malloc+0x13e>
        for(; *s; s++)
 8ca:	02800593          	li	a1,40
 8ce:	b7c5                	j	8ae <vprintf+0x252>
        if((s = va_arg(ap, char*)) == 0)
 8d0:	8bce                	mv	s7,s3
      state = 0;
 8d2:	4981                	li	s3,0
 8d4:	b3cd                	j	6b6 <vprintf+0x5a>
    }
  }
}
 8d6:	70e6                	ld	ra,120(sp)
 8d8:	7446                	ld	s0,112(sp)
 8da:	74a6                	ld	s1,104(sp)
 8dc:	7906                	ld	s2,96(sp)
 8de:	69e6                	ld	s3,88(sp)
 8e0:	6a46                	ld	s4,80(sp)
 8e2:	6aa6                	ld	s5,72(sp)
 8e4:	6b06                	ld	s6,64(sp)
 8e6:	7be2                	ld	s7,56(sp)
 8e8:	7c42                	ld	s8,48(sp)
 8ea:	7ca2                	ld	s9,40(sp)
 8ec:	7d02                	ld	s10,32(sp)
 8ee:	6de2                	ld	s11,24(sp)
 8f0:	6109                	addi	sp,sp,128
 8f2:	8082                	ret

00000000000008f4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8f4:	715d                	addi	sp,sp,-80
 8f6:	ec06                	sd	ra,24(sp)
 8f8:	e822                	sd	s0,16(sp)
 8fa:	1000                	addi	s0,sp,32
 8fc:	e010                	sd	a2,0(s0)
 8fe:	e414                	sd	a3,8(s0)
 900:	e818                	sd	a4,16(s0)
 902:	ec1c                	sd	a5,24(s0)
 904:	03043023          	sd	a6,32(s0)
 908:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 90c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 910:	8622                	mv	a2,s0
 912:	d4bff0ef          	jal	ra,65c <vprintf>
}
 916:	60e2                	ld	ra,24(sp)
 918:	6442                	ld	s0,16(sp)
 91a:	6161                	addi	sp,sp,80
 91c:	8082                	ret

000000000000091e <printf>:

void
printf(const char *fmt, ...)
{
 91e:	711d                	addi	sp,sp,-96
 920:	ec06                	sd	ra,24(sp)
 922:	e822                	sd	s0,16(sp)
 924:	1000                	addi	s0,sp,32
 926:	e40c                	sd	a1,8(s0)
 928:	e810                	sd	a2,16(s0)
 92a:	ec14                	sd	a3,24(s0)
 92c:	f018                	sd	a4,32(s0)
 92e:	f41c                	sd	a5,40(s0)
 930:	03043823          	sd	a6,48(s0)
 934:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 938:	00840613          	addi	a2,s0,8
 93c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 940:	85aa                	mv	a1,a0
 942:	4505                	li	a0,1
 944:	d19ff0ef          	jal	ra,65c <vprintf>
}
 948:	60e2                	ld	ra,24(sp)
 94a:	6442                	ld	s0,16(sp)
 94c:	6125                	addi	sp,sp,96
 94e:	8082                	ret

0000000000000950 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 950:	1141                	addi	sp,sp,-16
 952:	e422                	sd	s0,8(sp)
 954:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 956:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 95a:	00000797          	auipc	a5,0x0
 95e:	6a67b783          	ld	a5,1702(a5) # 1000 <freep>
 962:	a02d                	j	98c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 964:	4618                	lw	a4,8(a2)
 966:	9f2d                	addw	a4,a4,a1
 968:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 96c:	6398                	ld	a4,0(a5)
 96e:	6310                	ld	a2,0(a4)
 970:	a83d                	j	9ae <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 972:	ff852703          	lw	a4,-8(a0)
 976:	9f31                	addw	a4,a4,a2
 978:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 97a:	ff053683          	ld	a3,-16(a0)
 97e:	a091                	j	9c2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 980:	6398                	ld	a4,0(a5)
 982:	00e7e463          	bltu	a5,a4,98a <free+0x3a>
 986:	00e6ea63          	bltu	a3,a4,99a <free+0x4a>
{
 98a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 98c:	fed7fae3          	bgeu	a5,a3,980 <free+0x30>
 990:	6398                	ld	a4,0(a5)
 992:	00e6e463          	bltu	a3,a4,99a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 996:	fee7eae3          	bltu	a5,a4,98a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 99a:	ff852583          	lw	a1,-8(a0)
 99e:	6390                	ld	a2,0(a5)
 9a0:	02059813          	slli	a6,a1,0x20
 9a4:	01c85713          	srli	a4,a6,0x1c
 9a8:	9736                	add	a4,a4,a3
 9aa:	fae60de3          	beq	a2,a4,964 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9ae:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9b2:	4790                	lw	a2,8(a5)
 9b4:	02061593          	slli	a1,a2,0x20
 9b8:	01c5d713          	srli	a4,a1,0x1c
 9bc:	973e                	add	a4,a4,a5
 9be:	fae68ae3          	beq	a3,a4,972 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9c2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9c4:	00000717          	auipc	a4,0x0
 9c8:	62f73e23          	sd	a5,1596(a4) # 1000 <freep>
}
 9cc:	6422                	ld	s0,8(sp)
 9ce:	0141                	addi	sp,sp,16
 9d0:	8082                	ret

00000000000009d2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9d2:	7139                	addi	sp,sp,-64
 9d4:	fc06                	sd	ra,56(sp)
 9d6:	f822                	sd	s0,48(sp)
 9d8:	f426                	sd	s1,40(sp)
 9da:	f04a                	sd	s2,32(sp)
 9dc:	ec4e                	sd	s3,24(sp)
 9de:	e852                	sd	s4,16(sp)
 9e0:	e456                	sd	s5,8(sp)
 9e2:	e05a                	sd	s6,0(sp)
 9e4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e6:	02051493          	slli	s1,a0,0x20
 9ea:	9081                	srli	s1,s1,0x20
 9ec:	04bd                	addi	s1,s1,15
 9ee:	8091                	srli	s1,s1,0x4
 9f0:	0014899b          	addiw	s3,s1,1
 9f4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9f6:	00000517          	auipc	a0,0x0
 9fa:	60a53503          	ld	a0,1546(a0) # 1000 <freep>
 9fe:	c515                	beqz	a0,a2a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a00:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a02:	4798                	lw	a4,8(a5)
 a04:	02977f63          	bgeu	a4,s1,a42 <malloc+0x70>
 a08:	8a4e                	mv	s4,s3
 a0a:	0009871b          	sext.w	a4,s3
 a0e:	6685                	lui	a3,0x1
 a10:	00d77363          	bgeu	a4,a3,a16 <malloc+0x44>
 a14:	6a05                	lui	s4,0x1
 a16:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a1a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a1e:	00000917          	auipc	s2,0x0
 a22:	5e290913          	addi	s2,s2,1506 # 1000 <freep>
  if(p == SBRK_ERROR)
 a26:	5afd                	li	s5,-1
 a28:	a885                	j	a98 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 a2a:	00000797          	auipc	a5,0x0
 a2e:	5f678793          	addi	a5,a5,1526 # 1020 <base>
 a32:	00000717          	auipc	a4,0x0
 a36:	5cf73723          	sd	a5,1486(a4) # 1000 <freep>
 a3a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a3c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a40:	b7e1                	j	a08 <malloc+0x36>
      if(p->s.size == nunits)
 a42:	02e48c63          	beq	s1,a4,a7a <malloc+0xa8>
        p->s.size -= nunits;
 a46:	4137073b          	subw	a4,a4,s3
 a4a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a4c:	02071693          	slli	a3,a4,0x20
 a50:	01c6d713          	srli	a4,a3,0x1c
 a54:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a56:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a5a:	00000717          	auipc	a4,0x0
 a5e:	5aa73323          	sd	a0,1446(a4) # 1000 <freep>
      return (void*)(p + 1);
 a62:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a66:	70e2                	ld	ra,56(sp)
 a68:	7442                	ld	s0,48(sp)
 a6a:	74a2                	ld	s1,40(sp)
 a6c:	7902                	ld	s2,32(sp)
 a6e:	69e2                	ld	s3,24(sp)
 a70:	6a42                	ld	s4,16(sp)
 a72:	6aa2                	ld	s5,8(sp)
 a74:	6b02                	ld	s6,0(sp)
 a76:	6121                	addi	sp,sp,64
 a78:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a7a:	6398                	ld	a4,0(a5)
 a7c:	e118                	sd	a4,0(a0)
 a7e:	bff1                	j	a5a <malloc+0x88>
  hp->s.size = nu;
 a80:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a84:	0541                	addi	a0,a0,16
 a86:	ecbff0ef          	jal	ra,950 <free>
  return freep;
 a8a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a8e:	dd61                	beqz	a0,a66 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a90:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a92:	4798                	lw	a4,8(a5)
 a94:	fa9777e3          	bgeu	a4,s1,a42 <malloc+0x70>
    if(p == freep)
 a98:	00093703          	ld	a4,0(s2)
 a9c:	853e                	mv	a0,a5
 a9e:	fef719e3          	bne	a4,a5,a90 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 aa2:	8552                	mv	a0,s4
 aa4:	a23ff0ef          	jal	ra,4c6 <sbrk>
  if(p == SBRK_ERROR)
 aa8:	fd551ce3          	bne	a0,s5,a80 <malloc+0xae>
        return 0;
 aac:	4501                	li	a0,0
 aae:	bf65                	j	a66 <malloc+0x94>
