# mongDB
- 문서 데이터베이스의 하나로, 가장 인기 있는 NoSQL 데이터베이스

### 특징
- Schema-less: 고정된 스키마가 없고, 같은 Collection 안에서도 문서가 다른 구조를 가질 수 있음
- RDBMS 의 Join 이 없음
- 대신, CRUD ( Create, Read, Update, Delete)가 매우 효율적이고 빠르게 작동함
- Scale-Out 이 용이하고, Sharding (여러 데이터베이스에 데이터를 분할하는 기법) 으로 클러스터
구축 가능

### 문서
- 문서는 mongoDB의 레코드이며, 필드와 값으로 구성되어 있음
- JSON 혹은 XML 처럼 데이터를 표기할 수 있는 형태를 다룸
- 문서의 예
    - _id: 자동 생성되는 primary key
    - name: first 와 last 로 구성된 문서를 갖고 있음
    - birth/death: 날짜형 값을 가짐
    - contribs: 문자형 배열을 가짐
    - views: 수치형 값을 가짐
### Dot Notation (.)
MongoDB에서는 .을 찍어 세부 레벨의 객체에 접근 가능  
예1. `contribs: [ "Turing machine", "Turing test", "Turingery" ]`  
=> Turingery 에 접근하기 위해서는 contribs.2 를 입력  

예2. `name: { first: "Alan", last: "Turing" }, contact: { phone: { type: "cell", number: "111-222-3333" }}`  
=> contact 아래 phone 에 있는 number에 접근하기 위해서는
contact.phone.number 를 입력

### 컬렉션
- 컬렉션(collection)은 문서들의 집합

## mongoDB vs RDBMS
|mongoDB|RDBMS|
|---|---|
|Database|Database|
|Tabel|Collection|
|Tuple/Row|Document|
|Column|Key/Field|
|Tabel Join|Embedded Documents|
|Primary Key|Primary Key(_id)|

## 기본 명령어
- MongoDB shell로 진행
1. 데이터베이스 목록 보기  
`show dbs`
2. 컬렉션 목록 보기  
`show collections`
3. A 데이터베이스 사용하기  
`use A`
4. 코드를 읽기 쉽게  
`pretty`

### insert
- 컬렉션에 문서를 삽입할 때 사용 

`db.collection.insert()`  
```shell
db.student.insert({
    name: '아무개1',
    age: 12,
    major: 'Date Science',
	interest: ['Playing game'],
	course: {
		course_name: 'Big Data',
		credit: 3,
		grade: 'A'}
})
```
`db.collection.insertMany()` -> 여러개 삽입

```shell
db.student.insertMany([{	
	name: '아무개2',
	age: 23,
	major: 'Date Base',
	interest: ['Watching TV','Playing game'],
	course: {
		course_name: 'Data Base',
		credit: 3,
		grade: 'A+'}
},

{	
	name: '아무개3',
	age: 23,
	major: 'Programming',
	interest: ['Youtube','Instagram'],
	course: {
		course_name: 'Programming3',
		credit: 3,
		grade: 'A+'}
}])
```

### find
- 비교연산자

|Operator|Meaning|Description|
|---|---|---|
|$eq|equals|일치하는 값|
|$gt|greater than|큰 값|
|$gte|greater than or equals|크거나 같은 값|
$lt|less than|작은 값|
$lte|less than or equals|작거나 같은 값|
$ne|not equal|일치하지 않는 값|
$in|in an array|배열 안에 속하는 값|
$nin|none in an array|배열 안에 속하지 않는 값|

- 예시  
    `db.student.find({age:{$gte: 23, $lte: 27}})`

---
- 논리 연산자

|Operator|Description|
|---|---|
|$or|OR|
|$and|AND|
|$not|NOT|
|$nor|A도 B도 아님|

- 예시
    ```shell
    db.student.find({ 
        $or:[
        {
        major: '데이터사이언스'
        },
        {
        GPA: {$gt: 3.0}
        }
        ]})
    ```

### sort / limit / skip
- sort : 1 이면 오름차순, -1이면 내림차순으로 정렬 (mysql의 order by)
`db.collection.find().sort()`  
`db.student.find().sort({name:-1}).pretty()` 

- limit : 특정 개수만큼만 결과 표시  
`db.collection.find().limit()`  
`db.student.find().limit(3)`
- skip : 처음 n 개의 결과를 건너 뛰고 결과를 보여줌  
`db.collection.find().skip()`  
`db.student.find().skip(3)`

### update
`db.collection_name.update(query, update)`
- 존재하는 문서의 내용을 바꿈 (SQL의 UPDATE와 유사)
- <query>에는 찾을 문서의 조건을 설정
- <update>에는 바꿀 내용을 넣음

```shell
db.student.update(
{name: ‘홍길동’},
{$set: {age: 30}}
)
-- // $set 은 SQL의 set 과 동일
```

```shell
db.student.update(
{name: ‘홍길동’},
{$inc: {age: 1}}
)
-- $inc 는 수치형 데이터를 변경할
때 사용
```
- update에 사용되는 예약어

|Operator|Description|
|---|---|
|$inc|field의 value를 지정한 수만큼 증가|
|$rename|field 이름을 rename|
|$setOnInsert|update()의 upsert가 true로 설정되었을 경우 document가 insert될 때의 field value 설정|
|$set|update할 field의 value 설정|
|$unset|document에서 설정된 field 삭제|
|$min|설정값이 field value보다 작은 경우만 update|
|$max|설정값이 field value보다 큰 경우만 update|
|$currentDate|현재 시간 설정|

## remove
`db.collection.remove(<query>)`
- query 조건에 맞는 문서를 찾아 삭제함.
ex1. GPA가 1.0 미만이면 삭제
```shell
db.student.remove(
    {gpa : {$lt:1.0}}
)
```
ex2. 모든 문서 삭제  
`db.student.remove({})`

## drop 
- 컬렉션 삭제  
`db.collections.drop()`  
- 데이터베이스 삭제  
`db.dropDatabase()`

## function
- SQL의 procedure 나 function 처럼 사용자 정의 함수를 구성할 수 있음
- java script 형태로 구성
```shell
db.student.find().forEach(function(doc) {
print("Students: " + doc.name)
})
exports = function() {
return "Hello, world!";
};
```

## aggregate
- find로 해결하지 못하는 복잡한 연산을 가능하게 해줌
- Sharding 기반의 데이터를 빠르게 처리/집계하는 프레임워크
- $group, $match, $project, $limit, $sort
- group by 가능
```shell
db.student.aggregate([{
$group: {
_id: '$major',
number: {'$sum': 1}
}
}])

db.restaurant.aggregate([{
$group: {
_id: '$type_of_food',
number: {'$sum': '$rating'}
}
}])
```


