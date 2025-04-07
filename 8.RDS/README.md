# 8. RDS (시간 남으면 서비스 실습)
## 8.1: 수동으로 RDS 셋팅
* https://ap-northeast-2.console.aws.amazon.com/rds/home?region=ap-northeast-2#launch-dbinstance:
* RDS 생성 
  - Mysl
  - Templates : Free tier 
  - Master password : 직접 지정 (메모 필수)
  - 나머지는 기본 옵션 사용.
  - i1에서 "mysql -h <endpoint정보> -p -uadmin"
* 삭제 방법 
  - 1. db 선택 후 Modify 버튼 클릭 후 "Deletion protection" 옵션 제거
  - 2. "Deletion protection" 옵션 제거(운영중인 DB는 S3 버킷 설정 후 옵션 사용)
  - 3. "delete me" 선택 후 "Delete DB ~" 클릭

---

## 8.2: Terraform으로 RDS 인스턴스 생성
* * README.md 참고 : https://github.com/Finfra/aws/blob/main/1.6.2.RDS/README.md

## 8.3: RDS 성능 모니터링 및 튜닝
* RDS > Database > terratest-example-nowage에서 Endpoint & port 정보 확인 (aws rds describe-db-instances --query "DBInstances[?DBInstanceIdentifier=='terratest-example-nowage'].Endpoint.Address" --output text)
* i1에서 아래 명령으로 접속 
```
mysql -h <Endpoint> -P 3306 -u root -p
```
* 아래 명령으로 Index 확인 Performance
```
-- 1. db1 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS db1;
USE db1;

-- 2. t1 테이블 생성 (id1은 PK로 설정)
CREATE TABLE t1 (
    id1 INT NOT NULL AUTO_INCREMENT,
    id2 VARCHAR(255),
    PRIMARY KEY (id1)
);

-- 3. 대량 데이터 입력 (예를 들어 10000개의 데이터를 입력)
INSERT INTO t1 (id2) VALUES ('data_1');
INSERT INTO t1 (id2) SELECT CONCAT('data_', id1 + 1) FROM t1 ;
INSERT INTO t1 (id2) SELECT CONCAT('data_', id1 + 1) FROM t1 ;
<충분히 느려질때 까지 반복>


-- 4. 질의 실행계획 확인 (인덱스 생성 전)
EXPLAIN SELECT * FROM t1 WHERE id2 = 'data_1234';

-- 5. 인덱스 생성 (id2 컬럼에 대한 인덱스 생성)
CREATE INDEX idx_id2 ON t1 (id2);

-- 6. 질의 실행계획 확인 (인덱스 생성 후)
EXPLAIN SELECT * FROM t1 WHERE id2 = 'data_123';
```
