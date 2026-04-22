
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	02c000ef          	jal	ra,4a <matchhere>
  22:	e919                	bnez	a0,38 <matchstar+0x38>
  }while(*text!='\0' && (*text++==c || c=='.'));
  24:	0004c783          	lbu	a5,0(s1)
  28:	cb89                	beqz	a5,3a <matchstar+0x3a>
  2a:	0485                	addi	s1,s1,1
  2c:	2781                	sext.w	a5,a5
  2e:	ff2786e3          	beq	a5,s2,1a <matchstar+0x1a>
  32:	ff4904e3          	beq	s2,s4,1a <matchstar+0x1a>
  36:	a011                	j	3a <matchstar+0x3a>
      return 1;
  38:	4505                	li	a0,1
  return 0;
}
  3a:	70a2                	ld	ra,40(sp)
  3c:	7402                	ld	s0,32(sp)
  3e:	64e2                	ld	s1,24(sp)
  40:	6942                	ld	s2,16(sp)
  42:	69a2                	ld	s3,8(sp)
  44:	6a02                	ld	s4,0(sp)
  46:	6145                	addi	sp,sp,48
  48:	8082                	ret

000000000000004a <matchhere>:
  if(re[0] == '\0')
  4a:	00054703          	lbu	a4,0(a0)
  4e:	c73d                	beqz	a4,bc <matchhere+0x72>
{
  50:	1141                	addi	sp,sp,-16
  52:	e406                	sd	ra,8(sp)
  54:	e022                	sd	s0,0(sp)
  56:	0800                	addi	s0,sp,16
  58:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5a:	00154683          	lbu	a3,1(a0)
  5e:	02a00613          	li	a2,42
  62:	02c68563          	beq	a3,a2,8c <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  66:	02400613          	li	a2,36
  6a:	02c70863          	beq	a4,a2,9a <matchhere+0x50>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  6e:	0005c683          	lbu	a3,0(a1)
  return 0;
  72:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  74:	ca81                	beqz	a3,84 <matchhere+0x3a>
  76:	02e00613          	li	a2,46
  7a:	02c70b63          	beq	a4,a2,b0 <matchhere+0x66>
  return 0;
  7e:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  80:	02d70863          	beq	a4,a3,b0 <matchhere+0x66>
}
  84:	60a2                	ld	ra,8(sp)
  86:	6402                	ld	s0,0(sp)
  88:	0141                	addi	sp,sp,16
  8a:	8082                	ret
    return matchstar(re[0], re+2, text);
  8c:	862e                	mv	a2,a1
  8e:	00250593          	addi	a1,a0,2
  92:	853a                	mv	a0,a4
  94:	f6dff0ef          	jal	ra,0 <matchstar>
  98:	b7f5                	j	84 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  9a:	c691                	beqz	a3,a6 <matchhere+0x5c>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  9c:	0005c683          	lbu	a3,0(a1)
  a0:	fef9                	bnez	a3,7e <matchhere+0x34>
  return 0;
  a2:	4501                	li	a0,0
  a4:	b7c5                	j	84 <matchhere+0x3a>
    return *text == '\0';
  a6:	0005c503          	lbu	a0,0(a1)
  aa:	00153513          	seqz	a0,a0
  ae:	bfd9                	j	84 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b0:	0585                	addi	a1,a1,1
  b2:	00178513          	addi	a0,a5,1
  b6:	f95ff0ef          	jal	ra,4a <matchhere>
  ba:	b7e9                	j	84 <matchhere+0x3a>
    return 1;
  bc:	4505                	li	a0,1
}
  be:	8082                	ret

00000000000000c0 <match>:
{
  c0:	1101                	addi	sp,sp,-32
  c2:	ec06                	sd	ra,24(sp)
  c4:	e822                	sd	s0,16(sp)
  c6:	e426                	sd	s1,8(sp)
  c8:	e04a                	sd	s2,0(sp)
  ca:	1000                	addi	s0,sp,32
  cc:	892a                	mv	s2,a0
  ce:	84ae                	mv	s1,a1
  if(re[0] == '^')
  d0:	00054703          	lbu	a4,0(a0)
  d4:	05e00793          	li	a5,94
  d8:	00f70c63          	beq	a4,a5,f0 <match+0x30>
    if(matchhere(re, text))
  dc:	85a6                	mv	a1,s1
  de:	854a                	mv	a0,s2
  e0:	f6bff0ef          	jal	ra,4a <matchhere>
  e4:	e911                	bnez	a0,f8 <match+0x38>
  }while(*text++ != '\0');
  e6:	0485                	addi	s1,s1,1
  e8:	fff4c783          	lbu	a5,-1(s1)
  ec:	fbe5                	bnez	a5,dc <match+0x1c>
  ee:	a031                	j	fa <match+0x3a>
    return matchhere(re+1, text);
  f0:	0505                	addi	a0,a0,1
  f2:	f59ff0ef          	jal	ra,4a <matchhere>
  f6:	a011                	j	fa <match+0x3a>
      return 1;
  f8:	4505                	li	a0,1
}
  fa:	60e2                	ld	ra,24(sp)
  fc:	6442                	ld	s0,16(sp)
  fe:	64a2                	ld	s1,8(sp)
 100:	6902                	ld	s2,0(sp)
 102:	6105                	addi	sp,sp,32
 104:	8082                	ret

0000000000000106 <grep>:
{
 106:	715d                	addi	sp,sp,-80
 108:	e486                	sd	ra,72(sp)
 10a:	e0a2                	sd	s0,64(sp)
 10c:	fc26                	sd	s1,56(sp)
 10e:	f84a                	sd	s2,48(sp)
 110:	f44e                	sd	s3,40(sp)
 112:	f052                	sd	s4,32(sp)
 114:	ec56                	sd	s5,24(sp)
 116:	e85a                	sd	s6,16(sp)
 118:	e45e                	sd	s7,8(sp)
 11a:	0880                	addi	s0,sp,80
 11c:	89aa                	mv	s3,a0
 11e:	8b2e                	mv	s6,a1
  m = 0;
 120:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 122:	3ff00b93          	li	s7,1023
 126:	00001a97          	auipc	s5,0x1
 12a:	eeaa8a93          	addi	s5,s5,-278 # 1010 <buf>
 12e:	a835                	j	16a <grep+0x64>
      p = q+1;
 130:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 134:	45a9                	li	a1,10
 136:	854a                	mv	a0,s2
 138:	1ba000ef          	jal	ra,2f2 <strchr>
 13c:	84aa                	mv	s1,a0
 13e:	c505                	beqz	a0,166 <grep+0x60>
      *q = 0;
 140:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 144:	85ca                	mv	a1,s2
 146:	854e                	mv	a0,s3
 148:	f79ff0ef          	jal	ra,c0 <match>
 14c:	d175                	beqz	a0,130 <grep+0x2a>
        *q = '\n';
 14e:	47a9                	li	a5,10
 150:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 154:	00148613          	addi	a2,s1,1
 158:	4126063b          	subw	a2,a2,s2
 15c:	85ca                	mv	a1,s2
 15e:	4505                	li	a0,1
 160:	3a2000ef          	jal	ra,502 <write>
 164:	b7f1                	j	130 <grep+0x2a>
    if(m > 0){
 166:	03404363          	bgtz	s4,18c <grep+0x86>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 16a:	414b863b          	subw	a2,s7,s4
 16e:	014a85b3          	add	a1,s5,s4
 172:	855a                	mv	a0,s6
 174:	386000ef          	jal	ra,4fa <read>
 178:	02a05463          	blez	a0,1a0 <grep+0x9a>
    m += n;
 17c:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 180:	014a87b3          	add	a5,s5,s4
 184:	00078023          	sb	zero,0(a5)
    p = buf;
 188:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 18a:	b76d                	j	134 <grep+0x2e>
      m -= p - buf;
 18c:	415907b3          	sub	a5,s2,s5
 190:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 194:	8652                	mv	a2,s4
 196:	85ca                	mv	a1,s2
 198:	8556                	mv	a0,s5
 19a:	26e000ef          	jal	ra,408 <memmove>
 19e:	b7f1                	j	16a <grep+0x64>
}
 1a0:	60a6                	ld	ra,72(sp)
 1a2:	6406                	ld	s0,64(sp)
 1a4:	74e2                	ld	s1,56(sp)
 1a6:	7942                	ld	s2,48(sp)
 1a8:	79a2                	ld	s3,40(sp)
 1aa:	7a02                	ld	s4,32(sp)
 1ac:	6ae2                	ld	s5,24(sp)
 1ae:	6b42                	ld	s6,16(sp)
 1b0:	6ba2                	ld	s7,8(sp)
 1b2:	6161                	addi	sp,sp,80
 1b4:	8082                	ret

00000000000001b6 <main>:
{
 1b6:	7139                	addi	sp,sp,-64
 1b8:	fc06                	sd	ra,56(sp)
 1ba:	f822                	sd	s0,48(sp)
 1bc:	f426                	sd	s1,40(sp)
 1be:	f04a                	sd	s2,32(sp)
 1c0:	ec4e                	sd	s3,24(sp)
 1c2:	e852                	sd	s4,16(sp)
 1c4:	e456                	sd	s5,8(sp)
 1c6:	0080                	addi	s0,sp,64
  if(argc <= 1){
 1c8:	4785                	li	a5,1
 1ca:	04a7d663          	bge	a5,a0,216 <main+0x60>
  pattern = argv[1];
 1ce:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1d2:	4789                	li	a5,2
 1d4:	04a7db63          	bge	a5,a0,22a <main+0x74>
 1d8:	01058913          	addi	s2,a1,16
 1dc:	ffd5099b          	addiw	s3,a0,-3
 1e0:	02099793          	slli	a5,s3,0x20
 1e4:	01d7d993          	srli	s3,a5,0x1d
 1e8:	05e1                	addi	a1,a1,24
 1ea:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], O_RDONLY)) < 0){
 1ec:	4581                	li	a1,0
 1ee:	00093503          	ld	a0,0(s2)
 1f2:	330000ef          	jal	ra,522 <open>
 1f6:	84aa                	mv	s1,a0
 1f8:	04054063          	bltz	a0,238 <main+0x82>
    grep(pattern, fd);
 1fc:	85aa                	mv	a1,a0
 1fe:	8552                	mv	a0,s4
 200:	f07ff0ef          	jal	ra,106 <grep>
    close(fd);
 204:	8526                	mv	a0,s1
 206:	304000ef          	jal	ra,50a <close>
  for(i = 2; i < argc; i++){
 20a:	0921                	addi	s2,s2,8
 20c:	ff3910e3          	bne	s2,s3,1ec <main+0x36>
  exit(0);
 210:	4501                	li	a0,0
 212:	2d0000ef          	jal	ra,4e2 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 216:	00001597          	auipc	a1,0x1
 21a:	88a58593          	addi	a1,a1,-1910 # aa0 <malloc+0xe6>
 21e:	4509                	li	a0,2
 220:	6bc000ef          	jal	ra,8dc <fprintf>
    exit(1);
 224:	4505                	li	a0,1
 226:	2bc000ef          	jal	ra,4e2 <exit>
    grep(pattern, 0);
 22a:	4581                	li	a1,0
 22c:	8552                	mv	a0,s4
 22e:	ed9ff0ef          	jal	ra,106 <grep>
    exit(0);
 232:	4501                	li	a0,0
 234:	2ae000ef          	jal	ra,4e2 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 238:	00093583          	ld	a1,0(s2)
 23c:	00001517          	auipc	a0,0x1
 240:	88450513          	addi	a0,a0,-1916 # ac0 <malloc+0x106>
 244:	6c2000ef          	jal	ra,906 <printf>
      exit(1);
 248:	4505                	li	a0,1
 24a:	298000ef          	jal	ra,4e2 <exit>

000000000000024e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 24e:	1141                	addi	sp,sp,-16
 250:	e406                	sd	ra,8(sp)
 252:	e022                	sd	s0,0(sp)
 254:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 256:	f61ff0ef          	jal	ra,1b6 <main>
  exit(r);
 25a:	288000ef          	jal	ra,4e2 <exit>

000000000000025e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 264:	87aa                	mv	a5,a0
 266:	0585                	addi	a1,a1,1
 268:	0785                	addi	a5,a5,1
 26a:	fff5c703          	lbu	a4,-1(a1)
 26e:	fee78fa3          	sb	a4,-1(a5)
 272:	fb75                	bnez	a4,266 <strcpy+0x8>
    ;
  return os;
}
 274:	6422                	ld	s0,8(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret

000000000000027a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 27a:	1141                	addi	sp,sp,-16
 27c:	e422                	sd	s0,8(sp)
 27e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 280:	00054783          	lbu	a5,0(a0)
 284:	cb91                	beqz	a5,298 <strcmp+0x1e>
 286:	0005c703          	lbu	a4,0(a1)
 28a:	00f71763          	bne	a4,a5,298 <strcmp+0x1e>
    p++, q++;
 28e:	0505                	addi	a0,a0,1
 290:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 292:	00054783          	lbu	a5,0(a0)
 296:	fbe5                	bnez	a5,286 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 298:	0005c503          	lbu	a0,0(a1)
}
 29c:	40a7853b          	subw	a0,a5,a0
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret

00000000000002a6 <strlen>:

uint
strlen(const char *s)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ac:	00054783          	lbu	a5,0(a0)
 2b0:	cf91                	beqz	a5,2cc <strlen+0x26>
 2b2:	0505                	addi	a0,a0,1
 2b4:	87aa                	mv	a5,a0
 2b6:	4685                	li	a3,1
 2b8:	9e89                	subw	a3,a3,a0
 2ba:	00f6853b          	addw	a0,a3,a5
 2be:	0785                	addi	a5,a5,1
 2c0:	fff7c703          	lbu	a4,-1(a5)
 2c4:	fb7d                	bnez	a4,2ba <strlen+0x14>
    ;
  return n;
}
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  for(n = 0; s[n]; n++)
 2cc:	4501                	li	a0,0
 2ce:	bfe5                	j	2c6 <strlen+0x20>

00000000000002d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2d6:	ca19                	beqz	a2,2ec <memset+0x1c>
 2d8:	87aa                	mv	a5,a0
 2da:	1602                	slli	a2,a2,0x20
 2dc:	9201                	srli	a2,a2,0x20
 2de:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2e2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2e6:	0785                	addi	a5,a5,1
 2e8:	fee79de3          	bne	a5,a4,2e2 <memset+0x12>
  }
  return dst;
}
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	addi	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <strchr>:

char*
strchr(const char *s, char c)
{
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2f8:	00054783          	lbu	a5,0(a0)
 2fc:	cb99                	beqz	a5,312 <strchr+0x20>
    if(*s == c)
 2fe:	00f58763          	beq	a1,a5,30c <strchr+0x1a>
  for(; *s; s++)
 302:	0505                	addi	a0,a0,1
 304:	00054783          	lbu	a5,0(a0)
 308:	fbfd                	bnez	a5,2fe <strchr+0xc>
      return (char*)s;
  return 0;
 30a:	4501                	li	a0,0
}
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret
  return 0;
 312:	4501                	li	a0,0
 314:	bfe5                	j	30c <strchr+0x1a>

0000000000000316 <gets>:

char*
gets(char *buf, int max)
{
 316:	711d                	addi	sp,sp,-96
 318:	ec86                	sd	ra,88(sp)
 31a:	e8a2                	sd	s0,80(sp)
 31c:	e4a6                	sd	s1,72(sp)
 31e:	e0ca                	sd	s2,64(sp)
 320:	fc4e                	sd	s3,56(sp)
 322:	f852                	sd	s4,48(sp)
 324:	f456                	sd	s5,40(sp)
 326:	f05a                	sd	s6,32(sp)
 328:	ec5e                	sd	s7,24(sp)
 32a:	1080                	addi	s0,sp,96
 32c:	8baa                	mv	s7,a0
 32e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 330:	892a                	mv	s2,a0
 332:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 334:	4aa9                	li	s5,10
 336:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 338:	89a6                	mv	s3,s1
 33a:	2485                	addiw	s1,s1,1
 33c:	0344d663          	bge	s1,s4,368 <gets+0x52>
    cc = read(0, &c, 1);
 340:	4605                	li	a2,1
 342:	faf40593          	addi	a1,s0,-81
 346:	4501                	li	a0,0
 348:	1b2000ef          	jal	ra,4fa <read>
    if(cc < 1)
 34c:	00a05e63          	blez	a0,368 <gets+0x52>
    buf[i++] = c;
 350:	faf44783          	lbu	a5,-81(s0)
 354:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 358:	01578763          	beq	a5,s5,366 <gets+0x50>
 35c:	0905                	addi	s2,s2,1
 35e:	fd679de3          	bne	a5,s6,338 <gets+0x22>
  for(i=0; i+1 < max; ){
 362:	89a6                	mv	s3,s1
 364:	a011                	j	368 <gets+0x52>
 366:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 368:	99de                	add	s3,s3,s7
 36a:	00098023          	sb	zero,0(s3)
  return buf;
}
 36e:	855e                	mv	a0,s7
 370:	60e6                	ld	ra,88(sp)
 372:	6446                	ld	s0,80(sp)
 374:	64a6                	ld	s1,72(sp)
 376:	6906                	ld	s2,64(sp)
 378:	79e2                	ld	s3,56(sp)
 37a:	7a42                	ld	s4,48(sp)
 37c:	7aa2                	ld	s5,40(sp)
 37e:	7b02                	ld	s6,32(sp)
 380:	6be2                	ld	s7,24(sp)
 382:	6125                	addi	sp,sp,96
 384:	8082                	ret

0000000000000386 <stat>:

int
stat(const char *n, struct stat *st)
{
 386:	1101                	addi	sp,sp,-32
 388:	ec06                	sd	ra,24(sp)
 38a:	e822                	sd	s0,16(sp)
 38c:	e426                	sd	s1,8(sp)
 38e:	e04a                	sd	s2,0(sp)
 390:	1000                	addi	s0,sp,32
 392:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 394:	4581                	li	a1,0
 396:	18c000ef          	jal	ra,522 <open>
  if(fd < 0)
 39a:	02054163          	bltz	a0,3bc <stat+0x36>
 39e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3a0:	85ca                	mv	a1,s2
 3a2:	198000ef          	jal	ra,53a <fstat>
 3a6:	892a                	mv	s2,a0
  close(fd);
 3a8:	8526                	mv	a0,s1
 3aa:	160000ef          	jal	ra,50a <close>
  return r;
}
 3ae:	854a                	mv	a0,s2
 3b0:	60e2                	ld	ra,24(sp)
 3b2:	6442                	ld	s0,16(sp)
 3b4:	64a2                	ld	s1,8(sp)
 3b6:	6902                	ld	s2,0(sp)
 3b8:	6105                	addi	sp,sp,32
 3ba:	8082                	ret
    return -1;
 3bc:	597d                	li	s2,-1
 3be:	bfc5                	j	3ae <stat+0x28>

00000000000003c0 <atoi>:

int
atoi(const char *s)
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c6:	00054683          	lbu	a3,0(a0)
 3ca:	fd06879b          	addiw	a5,a3,-48
 3ce:	0ff7f793          	zext.b	a5,a5
 3d2:	4625                	li	a2,9
 3d4:	02f66863          	bltu	a2,a5,404 <atoi+0x44>
 3d8:	872a                	mv	a4,a0
  n = 0;
 3da:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3dc:	0705                	addi	a4,a4,1
 3de:	0025179b          	slliw	a5,a0,0x2
 3e2:	9fa9                	addw	a5,a5,a0
 3e4:	0017979b          	slliw	a5,a5,0x1
 3e8:	9fb5                	addw	a5,a5,a3
 3ea:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3ee:	00074683          	lbu	a3,0(a4)
 3f2:	fd06879b          	addiw	a5,a3,-48
 3f6:	0ff7f793          	zext.b	a5,a5
 3fa:	fef671e3          	bgeu	a2,a5,3dc <atoi+0x1c>
  return n;
}
 3fe:	6422                	ld	s0,8(sp)
 400:	0141                	addi	sp,sp,16
 402:	8082                	ret
  n = 0;
 404:	4501                	li	a0,0
 406:	bfe5                	j	3fe <atoi+0x3e>

0000000000000408 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 408:	1141                	addi	sp,sp,-16
 40a:	e422                	sd	s0,8(sp)
 40c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 40e:	02b57463          	bgeu	a0,a1,436 <memmove+0x2e>
    while(n-- > 0)
 412:	00c05f63          	blez	a2,430 <memmove+0x28>
 416:	1602                	slli	a2,a2,0x20
 418:	9201                	srli	a2,a2,0x20
 41a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 41e:	872a                	mv	a4,a0
      *dst++ = *src++;
 420:	0585                	addi	a1,a1,1
 422:	0705                	addi	a4,a4,1
 424:	fff5c683          	lbu	a3,-1(a1)
 428:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 42c:	fee79ae3          	bne	a5,a4,420 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 430:	6422                	ld	s0,8(sp)
 432:	0141                	addi	sp,sp,16
 434:	8082                	ret
    dst += n;
 436:	00c50733          	add	a4,a0,a2
    src += n;
 43a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 43c:	fec05ae3          	blez	a2,430 <memmove+0x28>
 440:	fff6079b          	addiw	a5,a2,-1
 444:	1782                	slli	a5,a5,0x20
 446:	9381                	srli	a5,a5,0x20
 448:	fff7c793          	not	a5,a5
 44c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 44e:	15fd                	addi	a1,a1,-1
 450:	177d                	addi	a4,a4,-1
 452:	0005c683          	lbu	a3,0(a1)
 456:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 45a:	fee79ae3          	bne	a5,a4,44e <memmove+0x46>
 45e:	bfc9                	j	430 <memmove+0x28>

0000000000000460 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 460:	1141                	addi	sp,sp,-16
 462:	e422                	sd	s0,8(sp)
 464:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 466:	ca05                	beqz	a2,496 <memcmp+0x36>
 468:	fff6069b          	addiw	a3,a2,-1
 46c:	1682                	slli	a3,a3,0x20
 46e:	9281                	srli	a3,a3,0x20
 470:	0685                	addi	a3,a3,1
 472:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 474:	00054783          	lbu	a5,0(a0)
 478:	0005c703          	lbu	a4,0(a1)
 47c:	00e79863          	bne	a5,a4,48c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 480:	0505                	addi	a0,a0,1
    p2++;
 482:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 484:	fed518e3          	bne	a0,a3,474 <memcmp+0x14>
  }
  return 0;
 488:	4501                	li	a0,0
 48a:	a019                	j	490 <memcmp+0x30>
      return *p1 - *p2;
 48c:	40e7853b          	subw	a0,a5,a4
}
 490:	6422                	ld	s0,8(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret
  return 0;
 496:	4501                	li	a0,0
 498:	bfe5                	j	490 <memcmp+0x30>

000000000000049a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 49a:	1141                	addi	sp,sp,-16
 49c:	e406                	sd	ra,8(sp)
 49e:	e022                	sd	s0,0(sp)
 4a0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4a2:	f67ff0ef          	jal	ra,408 <memmove>
}
 4a6:	60a2                	ld	ra,8(sp)
 4a8:	6402                	ld	s0,0(sp)
 4aa:	0141                	addi	sp,sp,16
 4ac:	8082                	ret

00000000000004ae <sbrk>:

char *
sbrk(int n) {
 4ae:	1141                	addi	sp,sp,-16
 4b0:	e406                	sd	ra,8(sp)
 4b2:	e022                	sd	s0,0(sp)
 4b4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4b6:	4585                	li	a1,1
 4b8:	0b2000ef          	jal	ra,56a <sys_sbrk>
}
 4bc:	60a2                	ld	ra,8(sp)
 4be:	6402                	ld	s0,0(sp)
 4c0:	0141                	addi	sp,sp,16
 4c2:	8082                	ret

00000000000004c4 <sbrklazy>:

char *
sbrklazy(int n) {
 4c4:	1141                	addi	sp,sp,-16
 4c6:	e406                	sd	ra,8(sp)
 4c8:	e022                	sd	s0,0(sp)
 4ca:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4cc:	4589                	li	a1,2
 4ce:	09c000ef          	jal	ra,56a <sys_sbrk>
}
 4d2:	60a2                	ld	ra,8(sp)
 4d4:	6402                	ld	s0,0(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret

00000000000004da <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4da:	4885                	li	a7,1
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e2:	4889                	li	a7,2
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ea:	488d                	li	a7,3
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f2:	4891                	li	a7,4
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <read>:
.global read
read:
 li a7, SYS_read
 4fa:	4895                	li	a7,5
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <write>:
.global write
write:
 li a7, SYS_write
 502:	48c1                	li	a7,16
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <close>:
.global close
close:
 li a7, SYS_close
 50a:	48d5                	li	a7,21
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <kill>:
.global kill
kill:
 li a7, SYS_kill
 512:	4899                	li	a7,6
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <exec>:
.global exec
exec:
 li a7, SYS_exec
 51a:	489d                	li	a7,7
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <open>:
.global open
open:
 li a7, SYS_open
 522:	48bd                	li	a7,15
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 52a:	48c5                	li	a7,17
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 532:	48c9                	li	a7,18
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 53a:	48a1                	li	a7,8
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <link>:
.global link
link:
 li a7, SYS_link
 542:	48cd                	li	a7,19
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 54a:	48d1                	li	a7,20
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 552:	48a5                	li	a7,9
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <dup>:
.global dup
dup:
 li a7, SYS_dup
 55a:	48a9                	li	a7,10
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 562:	48ad                	li	a7,11
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 56a:	48b1                	li	a7,12
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <pause>:
.global pause
pause:
 li a7, SYS_pause
 572:	48b5                	li	a7,13
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 57a:	48b9                	li	a7,14
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <getcnt>:
.global getcnt
getcnt:
 li a7, SYS_getcnt
 582:	48d9                	li	a7,22
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 58a:	1101                	addi	sp,sp,-32
 58c:	ec06                	sd	ra,24(sp)
 58e:	e822                	sd	s0,16(sp)
 590:	1000                	addi	s0,sp,32
 592:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 596:	4605                	li	a2,1
 598:	fef40593          	addi	a1,s0,-17
 59c:	f67ff0ef          	jal	ra,502 <write>
}
 5a0:	60e2                	ld	ra,24(sp)
 5a2:	6442                	ld	s0,16(sp)
 5a4:	6105                	addi	sp,sp,32
 5a6:	8082                	ret

00000000000005a8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5a8:	715d                	addi	sp,sp,-80
 5aa:	e486                	sd	ra,72(sp)
 5ac:	e0a2                	sd	s0,64(sp)
 5ae:	fc26                	sd	s1,56(sp)
 5b0:	f84a                	sd	s2,48(sp)
 5b2:	f44e                	sd	s3,40(sp)
 5b4:	0880                	addi	s0,sp,80
 5b6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 5b8:	c299                	beqz	a3,5be <printint+0x16>
 5ba:	0805c163          	bltz	a1,63c <printint+0x94>
  neg = 0;
 5be:	4881                	li	a7,0
 5c0:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5c4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 5c6:	00000517          	auipc	a0,0x0
 5ca:	51a50513          	addi	a0,a0,1306 # ae0 <digits>
 5ce:	883e                	mv	a6,a5
 5d0:	2785                	addiw	a5,a5,1
 5d2:	02c5f733          	remu	a4,a1,a2
 5d6:	972a                	add	a4,a4,a0
 5d8:	00074703          	lbu	a4,0(a4)
 5dc:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 5e0:	872e                	mv	a4,a1
 5e2:	02c5d5b3          	divu	a1,a1,a2
 5e6:	0685                	addi	a3,a3,1
 5e8:	fec773e3          	bgeu	a4,a2,5ce <printint+0x26>
  if(neg)
 5ec:	00088b63          	beqz	a7,602 <printint+0x5a>
    buf[i++] = '-';
 5f0:	fd078793          	addi	a5,a5,-48
 5f4:	97a2                	add	a5,a5,s0
 5f6:	02d00713          	li	a4,45
 5fa:	fee78423          	sb	a4,-24(a5)
 5fe:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 602:	02f05663          	blez	a5,62e <printint+0x86>
 606:	fb840713          	addi	a4,s0,-72
 60a:	00f704b3          	add	s1,a4,a5
 60e:	fff70993          	addi	s3,a4,-1
 612:	99be                	add	s3,s3,a5
 614:	37fd                	addiw	a5,a5,-1
 616:	1782                	slli	a5,a5,0x20
 618:	9381                	srli	a5,a5,0x20
 61a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 61e:	fff4c583          	lbu	a1,-1(s1)
 622:	854a                	mv	a0,s2
 624:	f67ff0ef          	jal	ra,58a <putc>
  while(--i >= 0)
 628:	14fd                	addi	s1,s1,-1
 62a:	ff349ae3          	bne	s1,s3,61e <printint+0x76>
}
 62e:	60a6                	ld	ra,72(sp)
 630:	6406                	ld	s0,64(sp)
 632:	74e2                	ld	s1,56(sp)
 634:	7942                	ld	s2,48(sp)
 636:	79a2                	ld	s3,40(sp)
 638:	6161                	addi	sp,sp,80
 63a:	8082                	ret
    x = -xx;
 63c:	40b005b3          	neg	a1,a1
    neg = 1;
 640:	4885                	li	a7,1
    x = -xx;
 642:	bfbd                	j	5c0 <printint+0x18>

0000000000000644 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 644:	7119                	addi	sp,sp,-128
 646:	fc86                	sd	ra,120(sp)
 648:	f8a2                	sd	s0,112(sp)
 64a:	f4a6                	sd	s1,104(sp)
 64c:	f0ca                	sd	s2,96(sp)
 64e:	ecce                	sd	s3,88(sp)
 650:	e8d2                	sd	s4,80(sp)
 652:	e4d6                	sd	s5,72(sp)
 654:	e0da                	sd	s6,64(sp)
 656:	fc5e                	sd	s7,56(sp)
 658:	f862                	sd	s8,48(sp)
 65a:	f466                	sd	s9,40(sp)
 65c:	f06a                	sd	s10,32(sp)
 65e:	ec6e                	sd	s11,24(sp)
 660:	0100                	addi	s0,sp,128
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 662:	0005c903          	lbu	s2,0(a1)
 666:	24090c63          	beqz	s2,8be <vprintf+0x27a>
 66a:	8b2a                	mv	s6,a0
 66c:	8a2e                	mv	s4,a1
 66e:	8bb2                	mv	s7,a2
  state = 0;
 670:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 672:	4481                	li	s1,0
 674:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 676:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 67a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 67e:	06c00d13          	li	s10,108
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 682:	07500d93          	li	s11,117
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 686:	00000c97          	auipc	s9,0x0
 68a:	45ac8c93          	addi	s9,s9,1114 # ae0 <digits>
 68e:	a005                	j	6ae <vprintf+0x6a>
        putc(fd, c0);
 690:	85ca                	mv	a1,s2
 692:	855a                	mv	a0,s6
 694:	ef7ff0ef          	jal	ra,58a <putc>
 698:	a019                	j	69e <vprintf+0x5a>
    } else if(state == '%'){
 69a:	03598263          	beq	s3,s5,6be <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 69e:	2485                	addiw	s1,s1,1
 6a0:	8726                	mv	a4,s1
 6a2:	009a07b3          	add	a5,s4,s1
 6a6:	0007c903          	lbu	s2,0(a5)
 6aa:	20090a63          	beqz	s2,8be <vprintf+0x27a>
    c0 = fmt[i] & 0xff;
 6ae:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6b2:	fe0994e3          	bnez	s3,69a <vprintf+0x56>
      if(c0 == '%'){
 6b6:	fd579de3          	bne	a5,s5,690 <vprintf+0x4c>
        state = '%';
 6ba:	89be                	mv	s3,a5
 6bc:	b7cd                	j	69e <vprintf+0x5a>
      if(c0) c1 = fmt[i+1] & 0xff;
 6be:	c3c1                	beqz	a5,73e <vprintf+0xfa>
 6c0:	00ea06b3          	add	a3,s4,a4
 6c4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6c8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6ca:	c681                	beqz	a3,6d2 <vprintf+0x8e>
 6cc:	9752                	add	a4,a4,s4
 6ce:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6d2:	03878e63          	beq	a5,s8,70e <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 6d6:	05a78863          	beq	a5,s10,726 <vprintf+0xe2>
      } else if(c0 == 'u'){
 6da:	0db78b63          	beq	a5,s11,7b0 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6de:	07800713          	li	a4,120
 6e2:	10e78d63          	beq	a5,a4,7fc <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6e6:	07000713          	li	a4,112
 6ea:	14e78263          	beq	a5,a4,82e <vprintf+0x1ea>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 6ee:	06300713          	li	a4,99
 6f2:	16e78f63          	beq	a5,a4,870 <vprintf+0x22c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 6f6:	07300713          	li	a4,115
 6fa:	18e78563          	beq	a5,a4,884 <vprintf+0x240>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6fe:	05579063          	bne	a5,s5,73e <vprintf+0xfa>
        putc(fd, '%');
 702:	85d6                	mv	a1,s5
 704:	855a                	mv	a0,s6
 706:	e85ff0ef          	jal	ra,58a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 70a:	4981                	li	s3,0
 70c:	bf49                	j	69e <vprintf+0x5a>
        printint(fd, va_arg(ap, int), 10, 1);
 70e:	008b8913          	addi	s2,s7,8
 712:	4685                	li	a3,1
 714:	4629                	li	a2,10
 716:	000ba583          	lw	a1,0(s7)
 71a:	855a                	mv	a0,s6
 71c:	e8dff0ef          	jal	ra,5a8 <printint>
 720:	8bca                	mv	s7,s2
      state = 0;
 722:	4981                	li	s3,0
 724:	bfad                	j	69e <vprintf+0x5a>
      } else if(c0 == 'l' && c1 == 'd'){
 726:	03868663          	beq	a3,s8,752 <vprintf+0x10e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 72a:	05a68163          	beq	a3,s10,76c <vprintf+0x128>
      } else if(c0 == 'l' && c1 == 'u'){
 72e:	09b68d63          	beq	a3,s11,7c8 <vprintf+0x184>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 732:	03a68f63          	beq	a3,s10,770 <vprintf+0x12c>
      } else if(c0 == 'l' && c1 == 'x'){
 736:	07800793          	li	a5,120
 73a:	0cf68d63          	beq	a3,a5,814 <vprintf+0x1d0>
        putc(fd, '%');
 73e:	85d6                	mv	a1,s5
 740:	855a                	mv	a0,s6
 742:	e49ff0ef          	jal	ra,58a <putc>
        putc(fd, c0);
 746:	85ca                	mv	a1,s2
 748:	855a                	mv	a0,s6
 74a:	e41ff0ef          	jal	ra,58a <putc>
      state = 0;
 74e:	4981                	li	s3,0
 750:	b7b9                	j	69e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 752:	008b8913          	addi	s2,s7,8
 756:	4685                	li	a3,1
 758:	4629                	li	a2,10
 75a:	000bb583          	ld	a1,0(s7)
 75e:	855a                	mv	a0,s6
 760:	e49ff0ef          	jal	ra,5a8 <printint>
        i += 1;
 764:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 766:	8bca                	mv	s7,s2
      state = 0;
 768:	4981                	li	s3,0
        i += 1;
 76a:	bf15                	j	69e <vprintf+0x5a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 76c:	03860563          	beq	a2,s8,796 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 770:	07b60963          	beq	a2,s11,7e2 <vprintf+0x19e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 774:	07800793          	li	a5,120
 778:	fcf613e3          	bne	a2,a5,73e <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 77c:	008b8913          	addi	s2,s7,8
 780:	4681                	li	a3,0
 782:	4641                	li	a2,16
 784:	000bb583          	ld	a1,0(s7)
 788:	855a                	mv	a0,s6
 78a:	e1fff0ef          	jal	ra,5a8 <printint>
        i += 2;
 78e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 790:	8bca                	mv	s7,s2
      state = 0;
 792:	4981                	li	s3,0
        i += 2;
 794:	b729                	j	69e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 796:	008b8913          	addi	s2,s7,8
 79a:	4685                	li	a3,1
 79c:	4629                	li	a2,10
 79e:	000bb583          	ld	a1,0(s7)
 7a2:	855a                	mv	a0,s6
 7a4:	e05ff0ef          	jal	ra,5a8 <printint>
        i += 2;
 7a8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7aa:	8bca                	mv	s7,s2
      state = 0;
 7ac:	4981                	li	s3,0
        i += 2;
 7ae:	bdc5                	j	69e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7b0:	008b8913          	addi	s2,s7,8
 7b4:	4681                	li	a3,0
 7b6:	4629                	li	a2,10
 7b8:	000be583          	lwu	a1,0(s7)
 7bc:	855a                	mv	a0,s6
 7be:	debff0ef          	jal	ra,5a8 <printint>
 7c2:	8bca                	mv	s7,s2
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	bde1                	j	69e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7c8:	008b8913          	addi	s2,s7,8
 7cc:	4681                	li	a3,0
 7ce:	4629                	li	a2,10
 7d0:	000bb583          	ld	a1,0(s7)
 7d4:	855a                	mv	a0,s6
 7d6:	dd3ff0ef          	jal	ra,5a8 <printint>
        i += 1;
 7da:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7dc:	8bca                	mv	s7,s2
      state = 0;
 7de:	4981                	li	s3,0
        i += 1;
 7e0:	bd7d                	j	69e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7e2:	008b8913          	addi	s2,s7,8
 7e6:	4681                	li	a3,0
 7e8:	4629                	li	a2,10
 7ea:	000bb583          	ld	a1,0(s7)
 7ee:	855a                	mv	a0,s6
 7f0:	db9ff0ef          	jal	ra,5a8 <printint>
        i += 2;
 7f4:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f6:	8bca                	mv	s7,s2
      state = 0;
 7f8:	4981                	li	s3,0
        i += 2;
 7fa:	b555                	j	69e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7fc:	008b8913          	addi	s2,s7,8
 800:	4681                	li	a3,0
 802:	4641                	li	a2,16
 804:	000be583          	lwu	a1,0(s7)
 808:	855a                	mv	a0,s6
 80a:	d9fff0ef          	jal	ra,5a8 <printint>
 80e:	8bca                	mv	s7,s2
      state = 0;
 810:	4981                	li	s3,0
 812:	b571                	j	69e <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 814:	008b8913          	addi	s2,s7,8
 818:	4681                	li	a3,0
 81a:	4641                	li	a2,16
 81c:	000bb583          	ld	a1,0(s7)
 820:	855a                	mv	a0,s6
 822:	d87ff0ef          	jal	ra,5a8 <printint>
        i += 1;
 826:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 828:	8bca                	mv	s7,s2
      state = 0;
 82a:	4981                	li	s3,0
        i += 1;
 82c:	bd8d                	j	69e <vprintf+0x5a>
        printptr(fd, va_arg(ap, uint64));
 82e:	008b8793          	addi	a5,s7,8
 832:	f8f43423          	sd	a5,-120(s0)
 836:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 83a:	03000593          	li	a1,48
 83e:	855a                	mv	a0,s6
 840:	d4bff0ef          	jal	ra,58a <putc>
  putc(fd, 'x');
 844:	07800593          	li	a1,120
 848:	855a                	mv	a0,s6
 84a:	d41ff0ef          	jal	ra,58a <putc>
 84e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 850:	03c9d793          	srli	a5,s3,0x3c
 854:	97e6                	add	a5,a5,s9
 856:	0007c583          	lbu	a1,0(a5)
 85a:	855a                	mv	a0,s6
 85c:	d2fff0ef          	jal	ra,58a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 860:	0992                	slli	s3,s3,0x4
 862:	397d                	addiw	s2,s2,-1
 864:	fe0916e3          	bnez	s2,850 <vprintf+0x20c>
        printptr(fd, va_arg(ap, uint64));
 868:	f8843b83          	ld	s7,-120(s0)
      state = 0;
 86c:	4981                	li	s3,0
 86e:	bd05                	j	69e <vprintf+0x5a>
        putc(fd, va_arg(ap, uint32));
 870:	008b8913          	addi	s2,s7,8
 874:	000bc583          	lbu	a1,0(s7)
 878:	855a                	mv	a0,s6
 87a:	d11ff0ef          	jal	ra,58a <putc>
 87e:	8bca                	mv	s7,s2
      state = 0;
 880:	4981                	li	s3,0
 882:	bd31                	j	69e <vprintf+0x5a>
        if((s = va_arg(ap, char*)) == 0)
 884:	008b8993          	addi	s3,s7,8
 888:	000bb903          	ld	s2,0(s7)
 88c:	00090f63          	beqz	s2,8aa <vprintf+0x266>
        for(; *s; s++)
 890:	00094583          	lbu	a1,0(s2)
 894:	c195                	beqz	a1,8b8 <vprintf+0x274>
          putc(fd, *s);
 896:	855a                	mv	a0,s6
 898:	cf3ff0ef          	jal	ra,58a <putc>
        for(; *s; s++)
 89c:	0905                	addi	s2,s2,1
 89e:	00094583          	lbu	a1,0(s2)
 8a2:	f9f5                	bnez	a1,896 <vprintf+0x252>
        if((s = va_arg(ap, char*)) == 0)
 8a4:	8bce                	mv	s7,s3
      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	bbdd                	j	69e <vprintf+0x5a>
          s = "(null)";
 8aa:	00000917          	auipc	s2,0x0
 8ae:	22e90913          	addi	s2,s2,558 # ad8 <malloc+0x11e>
        for(; *s; s++)
 8b2:	02800593          	li	a1,40
 8b6:	b7c5                	j	896 <vprintf+0x252>
        if((s = va_arg(ap, char*)) == 0)
 8b8:	8bce                	mv	s7,s3
      state = 0;
 8ba:	4981                	li	s3,0
 8bc:	b3cd                	j	69e <vprintf+0x5a>
    }
  }
}
 8be:	70e6                	ld	ra,120(sp)
 8c0:	7446                	ld	s0,112(sp)
 8c2:	74a6                	ld	s1,104(sp)
 8c4:	7906                	ld	s2,96(sp)
 8c6:	69e6                	ld	s3,88(sp)
 8c8:	6a46                	ld	s4,80(sp)
 8ca:	6aa6                	ld	s5,72(sp)
 8cc:	6b06                	ld	s6,64(sp)
 8ce:	7be2                	ld	s7,56(sp)
 8d0:	7c42                	ld	s8,48(sp)
 8d2:	7ca2                	ld	s9,40(sp)
 8d4:	7d02                	ld	s10,32(sp)
 8d6:	6de2                	ld	s11,24(sp)
 8d8:	6109                	addi	sp,sp,128
 8da:	8082                	ret

00000000000008dc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8dc:	715d                	addi	sp,sp,-80
 8de:	ec06                	sd	ra,24(sp)
 8e0:	e822                	sd	s0,16(sp)
 8e2:	1000                	addi	s0,sp,32
 8e4:	e010                	sd	a2,0(s0)
 8e6:	e414                	sd	a3,8(s0)
 8e8:	e818                	sd	a4,16(s0)
 8ea:	ec1c                	sd	a5,24(s0)
 8ec:	03043023          	sd	a6,32(s0)
 8f0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8f4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8f8:	8622                	mv	a2,s0
 8fa:	d4bff0ef          	jal	ra,644 <vprintf>
}
 8fe:	60e2                	ld	ra,24(sp)
 900:	6442                	ld	s0,16(sp)
 902:	6161                	addi	sp,sp,80
 904:	8082                	ret

0000000000000906 <printf>:

void
printf(const char *fmt, ...)
{
 906:	711d                	addi	sp,sp,-96
 908:	ec06                	sd	ra,24(sp)
 90a:	e822                	sd	s0,16(sp)
 90c:	1000                	addi	s0,sp,32
 90e:	e40c                	sd	a1,8(s0)
 910:	e810                	sd	a2,16(s0)
 912:	ec14                	sd	a3,24(s0)
 914:	f018                	sd	a4,32(s0)
 916:	f41c                	sd	a5,40(s0)
 918:	03043823          	sd	a6,48(s0)
 91c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 920:	00840613          	addi	a2,s0,8
 924:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 928:	85aa                	mv	a1,a0
 92a:	4505                	li	a0,1
 92c:	d19ff0ef          	jal	ra,644 <vprintf>
}
 930:	60e2                	ld	ra,24(sp)
 932:	6442                	ld	s0,16(sp)
 934:	6125                	addi	sp,sp,96
 936:	8082                	ret

0000000000000938 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 938:	1141                	addi	sp,sp,-16
 93a:	e422                	sd	s0,8(sp)
 93c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 93e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 942:	00000797          	auipc	a5,0x0
 946:	6be7b783          	ld	a5,1726(a5) # 1000 <freep>
 94a:	a02d                	j	974 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 94c:	4618                	lw	a4,8(a2)
 94e:	9f2d                	addw	a4,a4,a1
 950:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 954:	6398                	ld	a4,0(a5)
 956:	6310                	ld	a2,0(a4)
 958:	a83d                	j	996 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 95a:	ff852703          	lw	a4,-8(a0)
 95e:	9f31                	addw	a4,a4,a2
 960:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 962:	ff053683          	ld	a3,-16(a0)
 966:	a091                	j	9aa <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 968:	6398                	ld	a4,0(a5)
 96a:	00e7e463          	bltu	a5,a4,972 <free+0x3a>
 96e:	00e6ea63          	bltu	a3,a4,982 <free+0x4a>
{
 972:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 974:	fed7fae3          	bgeu	a5,a3,968 <free+0x30>
 978:	6398                	ld	a4,0(a5)
 97a:	00e6e463          	bltu	a3,a4,982 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97e:	fee7eae3          	bltu	a5,a4,972 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 982:	ff852583          	lw	a1,-8(a0)
 986:	6390                	ld	a2,0(a5)
 988:	02059813          	slli	a6,a1,0x20
 98c:	01c85713          	srli	a4,a6,0x1c
 990:	9736                	add	a4,a4,a3
 992:	fae60de3          	beq	a2,a4,94c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 996:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 99a:	4790                	lw	a2,8(a5)
 99c:	02061593          	slli	a1,a2,0x20
 9a0:	01c5d713          	srli	a4,a1,0x1c
 9a4:	973e                	add	a4,a4,a5
 9a6:	fae68ae3          	beq	a3,a4,95a <free+0x22>
    p->s.ptr = bp->s.ptr;
 9aa:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9ac:	00000717          	auipc	a4,0x0
 9b0:	64f73a23          	sd	a5,1620(a4) # 1000 <freep>
}
 9b4:	6422                	ld	s0,8(sp)
 9b6:	0141                	addi	sp,sp,16
 9b8:	8082                	ret

00000000000009ba <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ba:	7139                	addi	sp,sp,-64
 9bc:	fc06                	sd	ra,56(sp)
 9be:	f822                	sd	s0,48(sp)
 9c0:	f426                	sd	s1,40(sp)
 9c2:	f04a                	sd	s2,32(sp)
 9c4:	ec4e                	sd	s3,24(sp)
 9c6:	e852                	sd	s4,16(sp)
 9c8:	e456                	sd	s5,8(sp)
 9ca:	e05a                	sd	s6,0(sp)
 9cc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ce:	02051493          	slli	s1,a0,0x20
 9d2:	9081                	srli	s1,s1,0x20
 9d4:	04bd                	addi	s1,s1,15
 9d6:	8091                	srli	s1,s1,0x4
 9d8:	0014899b          	addiw	s3,s1,1
 9dc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9de:	00000517          	auipc	a0,0x0
 9e2:	62253503          	ld	a0,1570(a0) # 1000 <freep>
 9e6:	c515                	beqz	a0,a12 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ea:	4798                	lw	a4,8(a5)
 9ec:	02977f63          	bgeu	a4,s1,a2a <malloc+0x70>
 9f0:	8a4e                	mv	s4,s3
 9f2:	0009871b          	sext.w	a4,s3
 9f6:	6685                	lui	a3,0x1
 9f8:	00d77363          	bgeu	a4,a3,9fe <malloc+0x44>
 9fc:	6a05                	lui	s4,0x1
 9fe:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a02:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a06:	00000917          	auipc	s2,0x0
 a0a:	5fa90913          	addi	s2,s2,1530 # 1000 <freep>
  if(p == SBRK_ERROR)
 a0e:	5afd                	li	s5,-1
 a10:	a885                	j	a80 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 a12:	00001797          	auipc	a5,0x1
 a16:	9fe78793          	addi	a5,a5,-1538 # 1410 <base>
 a1a:	00000717          	auipc	a4,0x0
 a1e:	5ef73323          	sd	a5,1510(a4) # 1000 <freep>
 a22:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a24:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a28:	b7e1                	j	9f0 <malloc+0x36>
      if(p->s.size == nunits)
 a2a:	02e48c63          	beq	s1,a4,a62 <malloc+0xa8>
        p->s.size -= nunits;
 a2e:	4137073b          	subw	a4,a4,s3
 a32:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a34:	02071693          	slli	a3,a4,0x20
 a38:	01c6d713          	srli	a4,a3,0x1c
 a3c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a3e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a42:	00000717          	auipc	a4,0x0
 a46:	5aa73f23          	sd	a0,1470(a4) # 1000 <freep>
      return (void*)(p + 1);
 a4a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a4e:	70e2                	ld	ra,56(sp)
 a50:	7442                	ld	s0,48(sp)
 a52:	74a2                	ld	s1,40(sp)
 a54:	7902                	ld	s2,32(sp)
 a56:	69e2                	ld	s3,24(sp)
 a58:	6a42                	ld	s4,16(sp)
 a5a:	6aa2                	ld	s5,8(sp)
 a5c:	6b02                	ld	s6,0(sp)
 a5e:	6121                	addi	sp,sp,64
 a60:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a62:	6398                	ld	a4,0(a5)
 a64:	e118                	sd	a4,0(a0)
 a66:	bff1                	j	a42 <malloc+0x88>
  hp->s.size = nu;
 a68:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a6c:	0541                	addi	a0,a0,16
 a6e:	ecbff0ef          	jal	ra,938 <free>
  return freep;
 a72:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a76:	dd61                	beqz	a0,a4e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a78:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a7a:	4798                	lw	a4,8(a5)
 a7c:	fa9777e3          	bgeu	a4,s1,a2a <malloc+0x70>
    if(p == freep)
 a80:	00093703          	ld	a4,0(s2)
 a84:	853e                	mv	a0,a5
 a86:	fef719e3          	bne	a4,a5,a78 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 a8a:	8552                	mv	a0,s4
 a8c:	a23ff0ef          	jal	ra,4ae <sbrk>
  if(p == SBRK_ERROR)
 a90:	fd551ce3          	bne	a0,s5,a68 <malloc+0xae>
        return 0;
 a94:	4501                	li	a0,0
 a96:	bf65                	j	a4e <malloc+0x94>
