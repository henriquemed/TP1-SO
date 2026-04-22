
user/_getcnt:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  int n, cnt;

  if(argc != 2){
   a:	4789                	li	a5,2
   c:	00f50c63          	beq	a0,a5,24 <main+0x24>
    fprintf(2, "usage: getcnt syscall_number\n");
  10:	00001597          	auipc	a1,0x1
  14:	8a058593          	addi	a1,a1,-1888 # 8b0 <malloc+0xe6>
  18:	4509                	li	a0,2
  1a:	6d2000ef          	jal	ra,6ec <fprintf>
    exit(1);
  1e:	4505                	li	a0,1
  20:	2d2000ef          	jal	ra,2f2 <exit>
  }

  n = atoi(argv[1]);
  24:	6588                	ld	a0,8(a1)
  26:	1aa000ef          	jal	ra,1d0 <atoi>
  2a:	84aa                	mv	s1,a0
  cnt = getcnt(n);
  2c:	366000ef          	jal	ra,392 <getcnt>
  30:	862a                	mv	a2,a0

  if(cnt < 0){
  32:	00054c63          	bltz	a0,4a <main+0x4a>
    fprintf(2, "invalid syscall number\n");
    exit(1);
  }

  printf("syscall %d has been called %d times\n", n, cnt);
  36:	85a6                	mv	a1,s1
  38:	00001517          	auipc	a0,0x1
  3c:	8b050513          	addi	a0,a0,-1872 # 8e8 <malloc+0x11e>
  40:	6d6000ef          	jal	ra,716 <printf>
  exit(0);
  44:	4501                	li	a0,0
  46:	2ac000ef          	jal	ra,2f2 <exit>
    fprintf(2, "invalid syscall number\n");
  4a:	00001597          	auipc	a1,0x1
  4e:	88658593          	addi	a1,a1,-1914 # 8d0 <malloc+0x106>
  52:	4509                	li	a0,2
  54:	698000ef          	jal	ra,6ec <fprintf>
    exit(1);
  58:	4505                	li	a0,1
  5a:	298000ef          	jal	ra,2f2 <exit>

000000000000005e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  5e:	1141                	addi	sp,sp,-16
  60:	e406                	sd	ra,8(sp)
  62:	e022                	sd	s0,0(sp)
  64:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  66:	f9bff0ef          	jal	ra,0 <main>
  exit(r);
  6a:	288000ef          	jal	ra,2f2 <exit>

000000000000006e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  6e:	1141                	addi	sp,sp,-16
  70:	e422                	sd	s0,8(sp)
  72:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  74:	87aa                	mv	a5,a0
  76:	0585                	addi	a1,a1,1
  78:	0785                	addi	a5,a5,1
  7a:	fff5c703          	lbu	a4,-1(a1)
  7e:	fee78fa3          	sb	a4,-1(a5)
  82:	fb75                	bnez	a4,76 <strcpy+0x8>
    ;
  return os;
}
  84:	6422                	ld	s0,8(sp)
  86:	0141                	addi	sp,sp,16
  88:	8082                	ret

000000000000008a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8a:	1141                	addi	sp,sp,-16
  8c:	e422                	sd	s0,8(sp)
  8e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  90:	00054783          	lbu	a5,0(a0)
  94:	cb91                	beqz	a5,a8 <strcmp+0x1e>
  96:	0005c703          	lbu	a4,0(a1)
  9a:	00f71763          	bne	a4,a5,a8 <strcmp+0x1e>
    p++, q++;
  9e:	0505                	addi	a0,a0,1
  a0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a2:	00054783          	lbu	a5,0(a0)
  a6:	fbe5                	bnez	a5,96 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  a8:	0005c503          	lbu	a0,0(a1)
}
  ac:	40a7853b          	subw	a0,a5,a0
  b0:	6422                	ld	s0,8(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strlen>:

uint
strlen(const char *s)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e422                	sd	s0,8(sp)
  ba:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  bc:	00054783          	lbu	a5,0(a0)
  c0:	cf91                	beqz	a5,dc <strlen+0x26>
  c2:	0505                	addi	a0,a0,1
  c4:	87aa                	mv	a5,a0
  c6:	4685                	li	a3,1
  c8:	9e89                	subw	a3,a3,a0
  ca:	00f6853b          	addw	a0,a3,a5
  ce:	0785                	addi	a5,a5,1
  d0:	fff7c703          	lbu	a4,-1(a5)
  d4:	fb7d                	bnez	a4,ca <strlen+0x14>
    ;
  return n;
}
  d6:	6422                	ld	s0,8(sp)
  d8:	0141                	addi	sp,sp,16
  da:	8082                	ret
  for(n = 0; s[n]; n++)
  dc:	4501                	li	a0,0
  de:	bfe5                	j	d6 <strlen+0x20>

00000000000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	1141                	addi	sp,sp,-16
  e2:	e422                	sd	s0,8(sp)
  e4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e6:	ca19                	beqz	a2,fc <memset+0x1c>
  e8:	87aa                	mv	a5,a0
  ea:	1602                	slli	a2,a2,0x20
  ec:	9201                	srli	a2,a2,0x20
  ee:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  f6:	0785                	addi	a5,a5,1
  f8:	fee79de3          	bne	a5,a4,f2 <memset+0x12>
  }
  return dst;
}
  fc:	6422                	ld	s0,8(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret

0000000000000102 <strchr>:

char*
strchr(const char *s, char c)
{
 102:	1141                	addi	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	addi	s0,sp,16
  for(; *s; s++)
 108:	00054783          	lbu	a5,0(a0)
 10c:	cb99                	beqz	a5,122 <strchr+0x20>
    if(*s == c)
 10e:	00f58763          	beq	a1,a5,11c <strchr+0x1a>
  for(; *s; s++)
 112:	0505                	addi	a0,a0,1
 114:	00054783          	lbu	a5,0(a0)
 118:	fbfd                	bnez	a5,10e <strchr+0xc>
      return (char*)s;
  return 0;
 11a:	4501                	li	a0,0
}
 11c:	6422                	ld	s0,8(sp)
 11e:	0141                	addi	sp,sp,16
 120:	8082                	ret
  return 0;
 122:	4501                	li	a0,0
 124:	bfe5                	j	11c <strchr+0x1a>

0000000000000126 <gets>:

char*
gets(char *buf, int max)
{
 126:	711d                	addi	sp,sp,-96
 128:	ec86                	sd	ra,88(sp)
 12a:	e8a2                	sd	s0,80(sp)
 12c:	e4a6                	sd	s1,72(sp)
 12e:	e0ca                	sd	s2,64(sp)
 130:	fc4e                	sd	s3,56(sp)
 132:	f852                	sd	s4,48(sp)
 134:	f456                	sd	s5,40(sp)
 136:	f05a                	sd	s6,32(sp)
 138:	ec5e                	sd	s7,24(sp)
 13a:	1080                	addi	s0,sp,96
 13c:	8baa                	mv	s7,a0
 13e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 140:	892a                	mv	s2,a0
 142:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 144:	4aa9                	li	s5,10
 146:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 148:	89a6                	mv	s3,s1
 14a:	2485                	addiw	s1,s1,1
 14c:	0344d663          	bge	s1,s4,178 <gets+0x52>
    cc = read(0, &c, 1);
 150:	4605                	li	a2,1
 152:	faf40593          	addi	a1,s0,-81
 156:	4501                	li	a0,0
 158:	1b2000ef          	jal	ra,30a <read>
    if(cc < 1)
 15c:	00a05e63          	blez	a0,178 <gets+0x52>
    buf[i++] = c;
 160:	faf44783          	lbu	a5,-81(s0)
 164:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 168:	01578763          	beq	a5,s5,176 <gets+0x50>
 16c:	0905                	addi	s2,s2,1
 16e:	fd679de3          	bne	a5,s6,148 <gets+0x22>
  for(i=0; i+1 < max; ){
 172:	89a6                	mv	s3,s1
 174:	a011                	j	178 <gets+0x52>
 176:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 178:	99de                	add	s3,s3,s7
 17a:	00098023          	sb	zero,0(s3)
  return buf;
}
 17e:	855e                	mv	a0,s7
 180:	60e6                	ld	ra,88(sp)
 182:	6446                	ld	s0,80(sp)
 184:	64a6                	ld	s1,72(sp)
 186:	6906                	ld	s2,64(sp)
 188:	79e2                	ld	s3,56(sp)
 18a:	7a42                	ld	s4,48(sp)
 18c:	7aa2                	ld	s5,40(sp)
 18e:	7b02                	ld	s6,32(sp)
 190:	6be2                	ld	s7,24(sp)
 192:	6125                	addi	sp,sp,96
 194:	8082                	ret

0000000000000196 <stat>:

int
stat(const char *n, struct stat *st)
{
 196:	1101                	addi	sp,sp,-32
 198:	ec06                	sd	ra,24(sp)
 19a:	e822                	sd	s0,16(sp)
 19c:	e426                	sd	s1,8(sp)
 19e:	e04a                	sd	s2,0(sp)
 1a0:	1000                	addi	s0,sp,32
 1a2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a4:	4581                	li	a1,0
 1a6:	18c000ef          	jal	ra,332 <open>
  if(fd < 0)
 1aa:	02054163          	bltz	a0,1cc <stat+0x36>
 1ae:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1b0:	85ca                	mv	a1,s2
 1b2:	198000ef          	jal	ra,34a <fstat>
 1b6:	892a                	mv	s2,a0
  close(fd);
 1b8:	8526                	mv	a0,s1
 1ba:	160000ef          	jal	ra,31a <close>
  return r;
}
 1be:	854a                	mv	a0,s2
 1c0:	60e2                	ld	ra,24(sp)
 1c2:	6442                	ld	s0,16(sp)
 1c4:	64a2                	ld	s1,8(sp)
 1c6:	6902                	ld	s2,0(sp)
 1c8:	6105                	addi	sp,sp,32
 1ca:	8082                	ret
    return -1;
 1cc:	597d                	li	s2,-1
 1ce:	bfc5                	j	1be <stat+0x28>

00000000000001d0 <atoi>:

int
atoi(const char *s)
{
 1d0:	1141                	addi	sp,sp,-16
 1d2:	e422                	sd	s0,8(sp)
 1d4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d6:	00054683          	lbu	a3,0(a0)
 1da:	fd06879b          	addiw	a5,a3,-48
 1de:	0ff7f793          	zext.b	a5,a5
 1e2:	4625                	li	a2,9
 1e4:	02f66863          	bltu	a2,a5,214 <atoi+0x44>
 1e8:	872a                	mv	a4,a0
  n = 0;
 1ea:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1ec:	0705                	addi	a4,a4,1
 1ee:	0025179b          	slliw	a5,a0,0x2
 1f2:	9fa9                	addw	a5,a5,a0
 1f4:	0017979b          	slliw	a5,a5,0x1
 1f8:	9fb5                	addw	a5,a5,a3
 1fa:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1fe:	00074683          	lbu	a3,0(a4)
 202:	fd06879b          	addiw	a5,a3,-48
 206:	0ff7f793          	zext.b	a5,a5
 20a:	fef671e3          	bgeu	a2,a5,1ec <atoi+0x1c>
  return n;
}
 20e:	6422                	ld	s0,8(sp)
 210:	0141                	addi	sp,sp,16
 212:	8082                	ret
  n = 0;
 214:	4501                	li	a0,0
 216:	bfe5                	j	20e <atoi+0x3e>

0000000000000218 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 218:	1141                	addi	sp,sp,-16
 21a:	e422                	sd	s0,8(sp)
 21c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 21e:	02b57463          	bgeu	a0,a1,246 <memmove+0x2e>
    while(n-- > 0)
 222:	00c05f63          	blez	a2,240 <memmove+0x28>
 226:	1602                	slli	a2,a2,0x20
 228:	9201                	srli	a2,a2,0x20
 22a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 22e:	872a                	mv	a4,a0
      *dst++ = *src++;
 230:	0585                	addi	a1,a1,1
 232:	0705                	addi	a4,a4,1
 234:	fff5c683          	lbu	a3,-1(a1)
 238:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 23c:	fee79ae3          	bne	a5,a4,230 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 240:	6422                	ld	s0,8(sp)
 242:	0141                	addi	sp,sp,16
 244:	8082                	ret
    dst += n;
 246:	00c50733          	add	a4,a0,a2
    src += n;
 24a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 24c:	fec05ae3          	blez	a2,240 <memmove+0x28>
 250:	fff6079b          	addiw	a5,a2,-1
 254:	1782                	slli	a5,a5,0x20
 256:	9381                	srli	a5,a5,0x20
 258:	fff7c793          	not	a5,a5
 25c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 25e:	15fd                	addi	a1,a1,-1
 260:	177d                	addi	a4,a4,-1
 262:	0005c683          	lbu	a3,0(a1)
 266:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 26a:	fee79ae3          	bne	a5,a4,25e <memmove+0x46>
 26e:	bfc9                	j	240 <memmove+0x28>

0000000000000270 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 276:	ca05                	beqz	a2,2a6 <memcmp+0x36>
 278:	fff6069b          	addiw	a3,a2,-1
 27c:	1682                	slli	a3,a3,0x20
 27e:	9281                	srli	a3,a3,0x20
 280:	0685                	addi	a3,a3,1
 282:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 284:	00054783          	lbu	a5,0(a0)
 288:	0005c703          	lbu	a4,0(a1)
 28c:	00e79863          	bne	a5,a4,29c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 290:	0505                	addi	a0,a0,1
    p2++;
 292:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 294:	fed518e3          	bne	a0,a3,284 <memcmp+0x14>
  }
  return 0;
 298:	4501                	li	a0,0
 29a:	a019                	j	2a0 <memcmp+0x30>
      return *p1 - *p2;
 29c:	40e7853b          	subw	a0,a5,a4
}
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret
  return 0;
 2a6:	4501                	li	a0,0
 2a8:	bfe5                	j	2a0 <memcmp+0x30>

00000000000002aa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e406                	sd	ra,8(sp)
 2ae:	e022                	sd	s0,0(sp)
 2b0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2b2:	f67ff0ef          	jal	ra,218 <memmove>
}
 2b6:	60a2                	ld	ra,8(sp)
 2b8:	6402                	ld	s0,0(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <sbrk>:

char *
sbrk(int n) {
 2be:	1141                	addi	sp,sp,-16
 2c0:	e406                	sd	ra,8(sp)
 2c2:	e022                	sd	s0,0(sp)
 2c4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2c6:	4585                	li	a1,1
 2c8:	0b2000ef          	jal	ra,37a <sys_sbrk>
}
 2cc:	60a2                	ld	ra,8(sp)
 2ce:	6402                	ld	s0,0(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret

00000000000002d4 <sbrklazy>:

char *
sbrklazy(int n) {
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e406                	sd	ra,8(sp)
 2d8:	e022                	sd	s0,0(sp)
 2da:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2dc:	4589                	li	a1,2
 2de:	09c000ef          	jal	ra,37a <sys_sbrk>
}
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2ea:	4885                	li	a7,1
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2f2:	4889                	li	a7,2
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <wait>:
.global wait
wait:
 li a7, SYS_wait
 2fa:	488d                	li	a7,3
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 302:	4891                	li	a7,4
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <read>:
.global read
read:
 li a7, SYS_read
 30a:	4895                	li	a7,5
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <write>:
.global write
write:
 li a7, SYS_write
 312:	48c1                	li	a7,16
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <close>:
.global close
close:
 li a7, SYS_close
 31a:	48d5                	li	a7,21
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <kill>:
.global kill
kill:
 li a7, SYS_kill
 322:	4899                	li	a7,6
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <exec>:
.global exec
exec:
 li a7, SYS_exec
 32a:	489d                	li	a7,7
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <open>:
.global open
open:
 li a7, SYS_open
 332:	48bd                	li	a7,15
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 33a:	48c5                	li	a7,17
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 342:	48c9                	li	a7,18
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 34a:	48a1                	li	a7,8
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <link>:
.global link
link:
 li a7, SYS_link
 352:	48cd                	li	a7,19
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 35a:	48d1                	li	a7,20
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 362:	48a5                	li	a7,9
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <dup>:
.global dup
dup:
 li a7, SYS_dup
 36a:	48a9                	li	a7,10
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 372:	48ad                	li	a7,11
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 37a:	48b1                	li	a7,12
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <pause>:
.global pause
pause:
 li a7, SYS_pause
 382:	48b5                	li	a7,13
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 38a:	48b9                	li	a7,14
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <getcnt>:
.global getcnt
getcnt:
 li a7, SYS_getcnt
 392:	48d9                	li	a7,22
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 39a:	1101                	addi	sp,sp,-32
 39c:	ec06                	sd	ra,24(sp)
 39e:	e822                	sd	s0,16(sp)
 3a0:	1000                	addi	s0,sp,32
 3a2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3a6:	4605                	li	a2,1
 3a8:	fef40593          	addi	a1,s0,-17
 3ac:	f67ff0ef          	jal	ra,312 <write>
}
 3b0:	60e2                	ld	ra,24(sp)
 3b2:	6442                	ld	s0,16(sp)
 3b4:	6105                	addi	sp,sp,32
 3b6:	8082                	ret

00000000000003b8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3b8:	715d                	addi	sp,sp,-80
 3ba:	e486                	sd	ra,72(sp)
 3bc:	e0a2                	sd	s0,64(sp)
 3be:	fc26                	sd	s1,56(sp)
 3c0:	f84a                	sd	s2,48(sp)
 3c2:	f44e                	sd	s3,40(sp)
 3c4:	0880                	addi	s0,sp,80
 3c6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 3c8:	c299                	beqz	a3,3ce <printint+0x16>
 3ca:	0805c163          	bltz	a1,44c <printint+0x94>
  neg = 0;
 3ce:	4881                	li	a7,0
 3d0:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3d4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3d6:	00000517          	auipc	a0,0x0
 3da:	54250513          	addi	a0,a0,1346 # 918 <digits>
 3de:	883e                	mv	a6,a5
 3e0:	2785                	addiw	a5,a5,1
 3e2:	02c5f733          	remu	a4,a1,a2
 3e6:	972a                	add	a4,a4,a0
 3e8:	00074703          	lbu	a4,0(a4)
 3ec:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 3f0:	872e                	mv	a4,a1
 3f2:	02c5d5b3          	divu	a1,a1,a2
 3f6:	0685                	addi	a3,a3,1
 3f8:	fec773e3          	bgeu	a4,a2,3de <printint+0x26>
  if(neg)
 3fc:	00088b63          	beqz	a7,412 <printint+0x5a>
    buf[i++] = '-';
 400:	fd078793          	addi	a5,a5,-48
 404:	97a2                	add	a5,a5,s0
 406:	02d00713          	li	a4,45
 40a:	fee78423          	sb	a4,-24(a5)
 40e:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 412:	02f05663          	blez	a5,43e <printint+0x86>
 416:	fb840713          	addi	a4,s0,-72
 41a:	00f704b3          	add	s1,a4,a5
 41e:	fff70993          	addi	s3,a4,-1
 422:	99be                	add	s3,s3,a5
 424:	37fd                	addiw	a5,a5,-1
 426:	1782                	slli	a5,a5,0x20
 428:	9381                	srli	a5,a5,0x20
 42a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 42e:	fff4c583          	lbu	a1,-1(s1)
 432:	854a                	mv	a0,s2
 434:	f67ff0ef          	jal	ra,39a <putc>
  while(--i >= 0)
 438:	14fd                	addi	s1,s1,-1
 43a:	ff349ae3          	bne	s1,s3,42e <printint+0x76>
}
 43e:	60a6                	ld	ra,72(sp)
 440:	6406                	ld	s0,64(sp)
 442:	74e2                	ld	s1,56(sp)
 444:	7942                	ld	s2,48(sp)
 446:	79a2                	ld	s3,40(sp)
 448:	6161                	addi	sp,sp,80
 44a:	8082                	ret
    x = -xx;
 44c:	40b005b3          	neg	a1,a1
    neg = 1;
 450:	4885                	li	a7,1
    x = -xx;
 452:	bfbd                	j	3d0 <printint+0x18>

0000000000000454 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 454:	7119                	addi	sp,sp,-128
 456:	fc86                	sd	ra,120(sp)
 458:	f8a2                	sd	s0,112(sp)
 45a:	f4a6                	sd	s1,104(sp)
 45c:	f0ca                	sd	s2,96(sp)
 45e:	ecce                	sd	s3,88(sp)
 460:	e8d2                	sd	s4,80(sp)
 462:	e4d6                	sd	s5,72(sp)
 464:	e0da                	sd	s6,64(sp)
 466:	fc5e                	sd	s7,56(sp)
 468:	f862                	sd	s8,48(sp)
 46a:	f466                	sd	s9,40(sp)
 46c:	f06a                	sd	s10,32(sp)
 46e:	ec6e                	sd	s11,24(sp)
 470:	0100                	addi	s0,sp,128
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 472:	0005c903          	lbu	s2,0(a1)
 476:	24090c63          	beqz	s2,6ce <vprintf+0x27a>
 47a:	8b2a                	mv	s6,a0
 47c:	8a2e                	mv	s4,a1
 47e:	8bb2                	mv	s7,a2
  state = 0;
 480:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 482:	4481                	li	s1,0
 484:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 486:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 48a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 48e:	06c00d13          	li	s10,108
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 492:	07500d93          	li	s11,117
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 496:	00000c97          	auipc	s9,0x0
 49a:	482c8c93          	addi	s9,s9,1154 # 918 <digits>
 49e:	a005                	j	4be <vprintf+0x6a>
        putc(fd, c0);
 4a0:	85ca                	mv	a1,s2
 4a2:	855a                	mv	a0,s6
 4a4:	ef7ff0ef          	jal	ra,39a <putc>
 4a8:	a019                	j	4ae <vprintf+0x5a>
    } else if(state == '%'){
 4aa:	03598263          	beq	s3,s5,4ce <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4ae:	2485                	addiw	s1,s1,1
 4b0:	8726                	mv	a4,s1
 4b2:	009a07b3          	add	a5,s4,s1
 4b6:	0007c903          	lbu	s2,0(a5)
 4ba:	20090a63          	beqz	s2,6ce <vprintf+0x27a>
    c0 = fmt[i] & 0xff;
 4be:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4c2:	fe0994e3          	bnez	s3,4aa <vprintf+0x56>
      if(c0 == '%'){
 4c6:	fd579de3          	bne	a5,s5,4a0 <vprintf+0x4c>
        state = '%';
 4ca:	89be                	mv	s3,a5
 4cc:	b7cd                	j	4ae <vprintf+0x5a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4ce:	c3c1                	beqz	a5,54e <vprintf+0xfa>
 4d0:	00ea06b3          	add	a3,s4,a4
 4d4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4d8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4da:	c681                	beqz	a3,4e2 <vprintf+0x8e>
 4dc:	9752                	add	a4,a4,s4
 4de:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4e2:	03878e63          	beq	a5,s8,51e <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 4e6:	05a78863          	beq	a5,s10,536 <vprintf+0xe2>
      } else if(c0 == 'u'){
 4ea:	0db78b63          	beq	a5,s11,5c0 <vprintf+0x16c>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4ee:	07800713          	li	a4,120
 4f2:	10e78d63          	beq	a5,a4,60c <vprintf+0x1b8>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4f6:	07000713          	li	a4,112
 4fa:	14e78263          	beq	a5,a4,63e <vprintf+0x1ea>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 4fe:	06300713          	li	a4,99
 502:	16e78f63          	beq	a5,a4,680 <vprintf+0x22c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 506:	07300713          	li	a4,115
 50a:	18e78563          	beq	a5,a4,694 <vprintf+0x240>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 50e:	05579063          	bne	a5,s5,54e <vprintf+0xfa>
        putc(fd, '%');
 512:	85d6                	mv	a1,s5
 514:	855a                	mv	a0,s6
 516:	e85ff0ef          	jal	ra,39a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 51a:	4981                	li	s3,0
 51c:	bf49                	j	4ae <vprintf+0x5a>
        printint(fd, va_arg(ap, int), 10, 1);
 51e:	008b8913          	addi	s2,s7,8
 522:	4685                	li	a3,1
 524:	4629                	li	a2,10
 526:	000ba583          	lw	a1,0(s7)
 52a:	855a                	mv	a0,s6
 52c:	e8dff0ef          	jal	ra,3b8 <printint>
 530:	8bca                	mv	s7,s2
      state = 0;
 532:	4981                	li	s3,0
 534:	bfad                	j	4ae <vprintf+0x5a>
      } else if(c0 == 'l' && c1 == 'd'){
 536:	03868663          	beq	a3,s8,562 <vprintf+0x10e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 53a:	05a68163          	beq	a3,s10,57c <vprintf+0x128>
      } else if(c0 == 'l' && c1 == 'u'){
 53e:	09b68d63          	beq	a3,s11,5d8 <vprintf+0x184>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 542:	03a68f63          	beq	a3,s10,580 <vprintf+0x12c>
      } else if(c0 == 'l' && c1 == 'x'){
 546:	07800793          	li	a5,120
 54a:	0cf68d63          	beq	a3,a5,624 <vprintf+0x1d0>
        putc(fd, '%');
 54e:	85d6                	mv	a1,s5
 550:	855a                	mv	a0,s6
 552:	e49ff0ef          	jal	ra,39a <putc>
        putc(fd, c0);
 556:	85ca                	mv	a1,s2
 558:	855a                	mv	a0,s6
 55a:	e41ff0ef          	jal	ra,39a <putc>
      state = 0;
 55e:	4981                	li	s3,0
 560:	b7b9                	j	4ae <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 562:	008b8913          	addi	s2,s7,8
 566:	4685                	li	a3,1
 568:	4629                	li	a2,10
 56a:	000bb583          	ld	a1,0(s7)
 56e:	855a                	mv	a0,s6
 570:	e49ff0ef          	jal	ra,3b8 <printint>
        i += 1;
 574:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 576:	8bca                	mv	s7,s2
      state = 0;
 578:	4981                	li	s3,0
        i += 1;
 57a:	bf15                	j	4ae <vprintf+0x5a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 57c:	03860563          	beq	a2,s8,5a6 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 580:	07b60963          	beq	a2,s11,5f2 <vprintf+0x19e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 584:	07800793          	li	a5,120
 588:	fcf613e3          	bne	a2,a5,54e <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 58c:	008b8913          	addi	s2,s7,8
 590:	4681                	li	a3,0
 592:	4641                	li	a2,16
 594:	000bb583          	ld	a1,0(s7)
 598:	855a                	mv	a0,s6
 59a:	e1fff0ef          	jal	ra,3b8 <printint>
        i += 2;
 59e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5a0:	8bca                	mv	s7,s2
      state = 0;
 5a2:	4981                	li	s3,0
        i += 2;
 5a4:	b729                	j	4ae <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a6:	008b8913          	addi	s2,s7,8
 5aa:	4685                	li	a3,1
 5ac:	4629                	li	a2,10
 5ae:	000bb583          	ld	a1,0(s7)
 5b2:	855a                	mv	a0,s6
 5b4:	e05ff0ef          	jal	ra,3b8 <printint>
        i += 2;
 5b8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ba:	8bca                	mv	s7,s2
      state = 0;
 5bc:	4981                	li	s3,0
        i += 2;
 5be:	bdc5                	j	4ae <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5c0:	008b8913          	addi	s2,s7,8
 5c4:	4681                	li	a3,0
 5c6:	4629                	li	a2,10
 5c8:	000be583          	lwu	a1,0(s7)
 5cc:	855a                	mv	a0,s6
 5ce:	debff0ef          	jal	ra,3b8 <printint>
 5d2:	8bca                	mv	s7,s2
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	bde1                	j	4ae <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d8:	008b8913          	addi	s2,s7,8
 5dc:	4681                	li	a3,0
 5de:	4629                	li	a2,10
 5e0:	000bb583          	ld	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	dd3ff0ef          	jal	ra,3b8 <printint>
        i += 1;
 5ea:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ec:	8bca                	mv	s7,s2
      state = 0;
 5ee:	4981                	li	s3,0
        i += 1;
 5f0:	bd7d                	j	4ae <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f2:	008b8913          	addi	s2,s7,8
 5f6:	4681                	li	a3,0
 5f8:	4629                	li	a2,10
 5fa:	000bb583          	ld	a1,0(s7)
 5fe:	855a                	mv	a0,s6
 600:	db9ff0ef          	jal	ra,3b8 <printint>
        i += 2;
 604:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 606:	8bca                	mv	s7,s2
      state = 0;
 608:	4981                	li	s3,0
        i += 2;
 60a:	b555                	j	4ae <vprintf+0x5a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 60c:	008b8913          	addi	s2,s7,8
 610:	4681                	li	a3,0
 612:	4641                	li	a2,16
 614:	000be583          	lwu	a1,0(s7)
 618:	855a                	mv	a0,s6
 61a:	d9fff0ef          	jal	ra,3b8 <printint>
 61e:	8bca                	mv	s7,s2
      state = 0;
 620:	4981                	li	s3,0
 622:	b571                	j	4ae <vprintf+0x5a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 624:	008b8913          	addi	s2,s7,8
 628:	4681                	li	a3,0
 62a:	4641                	li	a2,16
 62c:	000bb583          	ld	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	d87ff0ef          	jal	ra,3b8 <printint>
        i += 1;
 636:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 638:	8bca                	mv	s7,s2
      state = 0;
 63a:	4981                	li	s3,0
        i += 1;
 63c:	bd8d                	j	4ae <vprintf+0x5a>
        printptr(fd, va_arg(ap, uint64));
 63e:	008b8793          	addi	a5,s7,8
 642:	f8f43423          	sd	a5,-120(s0)
 646:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 64a:	03000593          	li	a1,48
 64e:	855a                	mv	a0,s6
 650:	d4bff0ef          	jal	ra,39a <putc>
  putc(fd, 'x');
 654:	07800593          	li	a1,120
 658:	855a                	mv	a0,s6
 65a:	d41ff0ef          	jal	ra,39a <putc>
 65e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 660:	03c9d793          	srli	a5,s3,0x3c
 664:	97e6                	add	a5,a5,s9
 666:	0007c583          	lbu	a1,0(a5)
 66a:	855a                	mv	a0,s6
 66c:	d2fff0ef          	jal	ra,39a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 670:	0992                	slli	s3,s3,0x4
 672:	397d                	addiw	s2,s2,-1
 674:	fe0916e3          	bnez	s2,660 <vprintf+0x20c>
        printptr(fd, va_arg(ap, uint64));
 678:	f8843b83          	ld	s7,-120(s0)
      state = 0;
 67c:	4981                	li	s3,0
 67e:	bd05                	j	4ae <vprintf+0x5a>
        putc(fd, va_arg(ap, uint32));
 680:	008b8913          	addi	s2,s7,8
 684:	000bc583          	lbu	a1,0(s7)
 688:	855a                	mv	a0,s6
 68a:	d11ff0ef          	jal	ra,39a <putc>
 68e:	8bca                	mv	s7,s2
      state = 0;
 690:	4981                	li	s3,0
 692:	bd31                	j	4ae <vprintf+0x5a>
        if((s = va_arg(ap, char*)) == 0)
 694:	008b8993          	addi	s3,s7,8
 698:	000bb903          	ld	s2,0(s7)
 69c:	00090f63          	beqz	s2,6ba <vprintf+0x266>
        for(; *s; s++)
 6a0:	00094583          	lbu	a1,0(s2)
 6a4:	c195                	beqz	a1,6c8 <vprintf+0x274>
          putc(fd, *s);
 6a6:	855a                	mv	a0,s6
 6a8:	cf3ff0ef          	jal	ra,39a <putc>
        for(; *s; s++)
 6ac:	0905                	addi	s2,s2,1
 6ae:	00094583          	lbu	a1,0(s2)
 6b2:	f9f5                	bnez	a1,6a6 <vprintf+0x252>
        if((s = va_arg(ap, char*)) == 0)
 6b4:	8bce                	mv	s7,s3
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	bbdd                	j	4ae <vprintf+0x5a>
          s = "(null)";
 6ba:	00000917          	auipc	s2,0x0
 6be:	25690913          	addi	s2,s2,598 # 910 <malloc+0x146>
        for(; *s; s++)
 6c2:	02800593          	li	a1,40
 6c6:	b7c5                	j	6a6 <vprintf+0x252>
        if((s = va_arg(ap, char*)) == 0)
 6c8:	8bce                	mv	s7,s3
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	b3cd                	j	4ae <vprintf+0x5a>
    }
  }
}
 6ce:	70e6                	ld	ra,120(sp)
 6d0:	7446                	ld	s0,112(sp)
 6d2:	74a6                	ld	s1,104(sp)
 6d4:	7906                	ld	s2,96(sp)
 6d6:	69e6                	ld	s3,88(sp)
 6d8:	6a46                	ld	s4,80(sp)
 6da:	6aa6                	ld	s5,72(sp)
 6dc:	6b06                	ld	s6,64(sp)
 6de:	7be2                	ld	s7,56(sp)
 6e0:	7c42                	ld	s8,48(sp)
 6e2:	7ca2                	ld	s9,40(sp)
 6e4:	7d02                	ld	s10,32(sp)
 6e6:	6de2                	ld	s11,24(sp)
 6e8:	6109                	addi	sp,sp,128
 6ea:	8082                	ret

00000000000006ec <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6ec:	715d                	addi	sp,sp,-80
 6ee:	ec06                	sd	ra,24(sp)
 6f0:	e822                	sd	s0,16(sp)
 6f2:	1000                	addi	s0,sp,32
 6f4:	e010                	sd	a2,0(s0)
 6f6:	e414                	sd	a3,8(s0)
 6f8:	e818                	sd	a4,16(s0)
 6fa:	ec1c                	sd	a5,24(s0)
 6fc:	03043023          	sd	a6,32(s0)
 700:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 704:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 708:	8622                	mv	a2,s0
 70a:	d4bff0ef          	jal	ra,454 <vprintf>
}
 70e:	60e2                	ld	ra,24(sp)
 710:	6442                	ld	s0,16(sp)
 712:	6161                	addi	sp,sp,80
 714:	8082                	ret

0000000000000716 <printf>:

void
printf(const char *fmt, ...)
{
 716:	711d                	addi	sp,sp,-96
 718:	ec06                	sd	ra,24(sp)
 71a:	e822                	sd	s0,16(sp)
 71c:	1000                	addi	s0,sp,32
 71e:	e40c                	sd	a1,8(s0)
 720:	e810                	sd	a2,16(s0)
 722:	ec14                	sd	a3,24(s0)
 724:	f018                	sd	a4,32(s0)
 726:	f41c                	sd	a5,40(s0)
 728:	03043823          	sd	a6,48(s0)
 72c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 730:	00840613          	addi	a2,s0,8
 734:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 738:	85aa                	mv	a1,a0
 73a:	4505                	li	a0,1
 73c:	d19ff0ef          	jal	ra,454 <vprintf>
}
 740:	60e2                	ld	ra,24(sp)
 742:	6442                	ld	s0,16(sp)
 744:	6125                	addi	sp,sp,96
 746:	8082                	ret

0000000000000748 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 748:	1141                	addi	sp,sp,-16
 74a:	e422                	sd	s0,8(sp)
 74c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 74e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 752:	00001797          	auipc	a5,0x1
 756:	8ae7b783          	ld	a5,-1874(a5) # 1000 <freep>
 75a:	a02d                	j	784 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 75c:	4618                	lw	a4,8(a2)
 75e:	9f2d                	addw	a4,a4,a1
 760:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 764:	6398                	ld	a4,0(a5)
 766:	6310                	ld	a2,0(a4)
 768:	a83d                	j	7a6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 76a:	ff852703          	lw	a4,-8(a0)
 76e:	9f31                	addw	a4,a4,a2
 770:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 772:	ff053683          	ld	a3,-16(a0)
 776:	a091                	j	7ba <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	6398                	ld	a4,0(a5)
 77a:	00e7e463          	bltu	a5,a4,782 <free+0x3a>
 77e:	00e6ea63          	bltu	a3,a4,792 <free+0x4a>
{
 782:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	fed7fae3          	bgeu	a5,a3,778 <free+0x30>
 788:	6398                	ld	a4,0(a5)
 78a:	00e6e463          	bltu	a3,a4,792 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78e:	fee7eae3          	bltu	a5,a4,782 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 792:	ff852583          	lw	a1,-8(a0)
 796:	6390                	ld	a2,0(a5)
 798:	02059813          	slli	a6,a1,0x20
 79c:	01c85713          	srli	a4,a6,0x1c
 7a0:	9736                	add	a4,a4,a3
 7a2:	fae60de3          	beq	a2,a4,75c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7aa:	4790                	lw	a2,8(a5)
 7ac:	02061593          	slli	a1,a2,0x20
 7b0:	01c5d713          	srli	a4,a1,0x1c
 7b4:	973e                	add	a4,a4,a5
 7b6:	fae68ae3          	beq	a3,a4,76a <free+0x22>
    p->s.ptr = bp->s.ptr;
 7ba:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7bc:	00001717          	auipc	a4,0x1
 7c0:	84f73223          	sd	a5,-1980(a4) # 1000 <freep>
}
 7c4:	6422                	ld	s0,8(sp)
 7c6:	0141                	addi	sp,sp,16
 7c8:	8082                	ret

00000000000007ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ca:	7139                	addi	sp,sp,-64
 7cc:	fc06                	sd	ra,56(sp)
 7ce:	f822                	sd	s0,48(sp)
 7d0:	f426                	sd	s1,40(sp)
 7d2:	f04a                	sd	s2,32(sp)
 7d4:	ec4e                	sd	s3,24(sp)
 7d6:	e852                	sd	s4,16(sp)
 7d8:	e456                	sd	s5,8(sp)
 7da:	e05a                	sd	s6,0(sp)
 7dc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7de:	02051493          	slli	s1,a0,0x20
 7e2:	9081                	srli	s1,s1,0x20
 7e4:	04bd                	addi	s1,s1,15
 7e6:	8091                	srli	s1,s1,0x4
 7e8:	0014899b          	addiw	s3,s1,1
 7ec:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7ee:	00001517          	auipc	a0,0x1
 7f2:	81253503          	ld	a0,-2030(a0) # 1000 <freep>
 7f6:	c515                	beqz	a0,822 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7fa:	4798                	lw	a4,8(a5)
 7fc:	02977f63          	bgeu	a4,s1,83a <malloc+0x70>
 800:	8a4e                	mv	s4,s3
 802:	0009871b          	sext.w	a4,s3
 806:	6685                	lui	a3,0x1
 808:	00d77363          	bgeu	a4,a3,80e <malloc+0x44>
 80c:	6a05                	lui	s4,0x1
 80e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 812:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 816:	00000917          	auipc	s2,0x0
 81a:	7ea90913          	addi	s2,s2,2026 # 1000 <freep>
  if(p == SBRK_ERROR)
 81e:	5afd                	li	s5,-1
 820:	a885                	j	890 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 822:	00000797          	auipc	a5,0x0
 826:	7ee78793          	addi	a5,a5,2030 # 1010 <base>
 82a:	00000717          	auipc	a4,0x0
 82e:	7cf73b23          	sd	a5,2006(a4) # 1000 <freep>
 832:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 834:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 838:	b7e1                	j	800 <malloc+0x36>
      if(p->s.size == nunits)
 83a:	02e48c63          	beq	s1,a4,872 <malloc+0xa8>
        p->s.size -= nunits;
 83e:	4137073b          	subw	a4,a4,s3
 842:	c798                	sw	a4,8(a5)
        p += p->s.size;
 844:	02071693          	slli	a3,a4,0x20
 848:	01c6d713          	srli	a4,a3,0x1c
 84c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 84e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 852:	00000717          	auipc	a4,0x0
 856:	7aa73723          	sd	a0,1966(a4) # 1000 <freep>
      return (void*)(p + 1);
 85a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 85e:	70e2                	ld	ra,56(sp)
 860:	7442                	ld	s0,48(sp)
 862:	74a2                	ld	s1,40(sp)
 864:	7902                	ld	s2,32(sp)
 866:	69e2                	ld	s3,24(sp)
 868:	6a42                	ld	s4,16(sp)
 86a:	6aa2                	ld	s5,8(sp)
 86c:	6b02                	ld	s6,0(sp)
 86e:	6121                	addi	sp,sp,64
 870:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 872:	6398                	ld	a4,0(a5)
 874:	e118                	sd	a4,0(a0)
 876:	bff1                	j	852 <malloc+0x88>
  hp->s.size = nu;
 878:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 87c:	0541                	addi	a0,a0,16
 87e:	ecbff0ef          	jal	ra,748 <free>
  return freep;
 882:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 886:	dd61                	beqz	a0,85e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 888:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 88a:	4798                	lw	a4,8(a5)
 88c:	fa9777e3          	bgeu	a4,s1,83a <malloc+0x70>
    if(p == freep)
 890:	00093703          	ld	a4,0(s2)
 894:	853e                	mv	a0,a5
 896:	fef719e3          	bne	a4,a5,888 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 89a:	8552                	mv	a0,s4
 89c:	a23ff0ef          	jal	ra,2be <sbrk>
  if(p == SBRK_ERROR)
 8a0:	fd551ce3          	bne	a0,s5,878 <malloc+0xae>
        return 0;
 8a4:	4501                	li	a0,0
 8a6:	bf65                	j	85e <malloc+0x94>
