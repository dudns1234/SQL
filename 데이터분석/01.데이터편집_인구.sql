# 01_인구_데이터_분석

SELECT * FROM TB_PBTRNSP_DATA;
SELECT * FROM TB_POPLTN_DATA;

-- 데이터 분석은 데이터를 살펴보는것. 즉 EDA
-- 1. 어떤 기준으로 분석을 할 것인가 => CATEGORY
	-- - 지역
    -- - 나이대 (0_9, 10_19, 20_29, ... )
    -- - 남/여 나이대 별 인구수
-- 2. Category 존재 유무 (제일중요)
	-- 어떤식으로 파악하냐면 카테고리가 COLUMN에 있는지, ROW에 있는지 보면 됨 => COLUMN에 있을 경우 SQL로 분석 불가(PYTHON은 어떻게 가능한데 비효율적임)
    -- 현재 데이터는 COLUMN에 카테고리 정보가 들어가있음 => 전체_0~9, 10~19, 20~29, ... 남자_0~9, 10~19, 20~29, ..., 여자_0~9, 10~19, 20~29, ...  => 컬럼에 존재할 경우 분석이 불가함.
    -- 분석이 용이한 형태로 전처리해야함.
    
-- 3. Data Lake -> Data Warehouse(Container) -> Data Mart : 따로따로 정의해서 만들어야함!!
	-- Data Lake
		-- DATA가 구분없이 쌓여진 상황 (Lake : 호수) 예를들어, 호수안에 데이터(File : csv, JSON, ...)들이 저장되어 있다. (파일형식으로 저장되어 있다 => 최소한의 폴더만??) 파일시스템이지 DB가 아님. 그냥 폴더안에 csv파일 형태로 저장되어 있는게 Data Lake! (덩치 많이 키우면!)
        -- 호수에 우럭, 광어, 우럭, 우럭, 도다리, 광어
    -- Data Warehouse(Container)
		-- 말 그대로 창고의 역할!
        -- 데이터끼리 묶어주는 것. 광어끼리, 우럭끼리, 도다리끼리
        -- 전처리가 필요한 대상 데이터 (= 목적에 맞게 데이터를 전처리하기 위한 대상 데이터가 쌓여가는 곳)
        -- 데이터 분석 가능할 수도 불가능할 수도 있음. 
        -- DB가 되기도 함!
        -- 안정적으로 데이터 관리하면서 전처리 할 수 있음
        -- (깔끔히 정리해놓는 과정)
	-- Data Mart
		-- 분석가능하고 머신러닝이 가능한 상태의 데이터
        -- 창고에서 꺼내 손질한(전처리 완료) 데이터를 저장
        -- 나의 목적에 맞게 손질 : MySQL, Matplotlib, Seaborn
        -- 사용자에게 공급하기 위한 Data임!!
        -- ex. 광어 테이블이 있으면 광어 분석을 하기 위해서 여러가지 항목이 있는데 뭐 양식여부, 크기, 무게, 채집일 등을 데이터
	
    -- 이제 우리는 Data Warehouse에서 Data Mart로 바꿔주는 작업을 SQL로 진행하는 것임! (SQL, Pandas, 등등이 가능)
    
SELECT * FROM TB_POPLTN;
-- 아까와는 다르게 집계에 대한 정보가 컬럼에 없음.
-- 집계에 대한 정보를 행으로 관리한다는 의미~~ => 코드화!
-- EDA를 할 때는 기준 정보가 필요함 ex. M - 000 / M - 010 / F - 010 => 이때 필요한건 코드 테이블을 위한 Caretesian join임!

## 코드화를 진행한 쿼리! => 이제 분석 가능해짐.
INSERT INTO TB_POPLTN
SELECT A.ADMINIST_ZONE_NO, A.ADMINIST_ZONE_NM, A.STD_MT
     , CASE WHEN LVL1 = 1 THEN 'M' WHEN LVL1 = 2 THEN 'F' WHEN LVL1 = 3 THEN 'T' END AS POPLTN_SE_CD  -- 4. 인구수에 대한 성별코드
     , CASE WHEN LVL2 = 1  THEN '000' WHEN LVL2 = 2  THEN '010' WHEN LVL2 = 3  THEN '020' -- 5. 나이대를 구하기 위함
            WHEN LVL2 = 4  THEN '030' WHEN LVL2 = 5  THEN '040' WHEN LVL2 = 6  THEN '050'
            WHEN LVL2 = 7  THEN '060' WHEN LVL2 = 8  THEN '070' WHEN LVL2 = 9  THEN '080'
            WHEN LVL2 = 10 THEN '090' WHEN LVL2 = 11 THEN '100'
       END AS AGRDE_SE_CD
     , CASE WHEN LVL1 = 1 AND LVL2 = 1  THEN MALE_POPLTN_CO_0_9     WHEN LVL1 = 1 AND LVL2 = 2  THEN MALE_POPLTN_CO_10_19 -- 6. 남자고 어린이면 MALE_POPLTN_CO_0_9로 하겠다.
            WHEN LVL1 = 1 AND LVL2 = 3  THEN MALE_POPLTN_CO_20_29   WHEN LVL1 = 1 AND LVL2 = 4  THEN MALE_POPLTN_CO_30_39
            WHEN LVL1 = 1 AND LVL2 = 5  THEN MALE_POPLTN_CO_40_49   WHEN LVL1 = 1 AND LVL2 = 6  THEN MALE_POPLTN_CO_50_59
            WHEN LVL1 = 1 AND LVL2 = 7  THEN MALE_POPLTN_CO_60_69   WHEN LVL1 = 1 AND LVL2 = 8  THEN MALE_POPLTN_CO_70_79
            WHEN LVL1 = 1 AND LVL2 = 9  THEN MALE_POPLTN_CO_80_89   WHEN LVL1 = 1 AND LVL2 = 10 THEN MALE_POPLTN_CO_90_99
            WHEN LVL1 = 1 AND LVL2 = 11 THEN MALE_POPLTN_CO_100     WHEN LVL1 = 2 AND LVL2 = 1  THEN FEMALE_POPLTN_CO_0_9
            WHEN LVL1 = 2 AND LVL2 = 2  THEN FEMALE_POPLTN_CO_10_19 WHEN LVL1 = 2 AND LVL2 = 3  THEN FEMALE_POPLTN_CO_20_29
            WHEN LVL1 = 2 AND LVL2 = 4  THEN FEMALE_POPLTN_CO_30_39 WHEN LVL1 = 2 AND LVL2 = 5  THEN FEMALE_POPLTN_CO_40_49
            WHEN LVL1 = 2 AND LVL2 = 6  THEN FEMALE_POPLTN_CO_50_59 WHEN LVL1 = 2 AND LVL2 = 7  THEN FEMALE_POPLTN_CO_60_69
            WHEN LVL1 = 2 AND LVL2 = 8  THEN FEMALE_POPLTN_CO_70_79 WHEN LVL1 = 2 AND LVL2 = 9  THEN FEMALE_POPLTN_CO_80_89
            WHEN LVL1 = 2 AND LVL2 = 10 THEN FEMALE_POPLTN_CO_90_99 WHEN LVL1 = 2 AND LVL2 = 11 THEN FEMALE_POPLTN_CO_100
            WHEN LVL1 = 3 AND LVL2 = 1  THEN POPLTN_CO_0_9          WHEN LVL1 = 3 AND LVL2 = 2  THEN POPLTN_CO_10_19
            WHEN LVL1 = 3 AND LVL2 = 3  THEN POPLTN_CO_20_29        WHEN LVL1 = 3 AND LVL2 = 4  THEN POPLTN_CO_30_39
            WHEN LVL1 = 3 AND LVL2 = 5  THEN POPLTN_CO_40_49        WHEN LVL1 = 3 AND LVL2 = 6  THEN POPLTN_CO_50_59
            WHEN LVL1 = 3 AND LVL2 = 7  THEN POPLTN_CO_60_69        WHEN LVL1 = 3 AND LVL2 = 8  THEN POPLTN_CO_70_79
            WHEN LVL1 = 3 AND LVL2 = 9  THEN POPLTN_CO_80_89        WHEN LVL1 = 3 AND LVL2 = 10 THEN POPLTN_CO_90_99
            WHEN LVL1 = 3 AND LVL2 = 11 THEN POPLTN_CO_100 END AS POPLTN_CNT
  FROM
     ( -- 1. 무조건 서브쿼리
      SELECT SUBSTR(ADMINIST_ZONE, INSTR(ADMINIST_ZONE, '(') + 1, 10) AS ADMINIST_ZONE_NO  -- 3. SUBSTR('HELLO',1,3); 하면 결과 HEL, SUBSTR('HELLO(BYE)',1,3); 하면 괄호의 인덱스를 찾고싶다 => INSTR('HELLO(BYE)','('); 하면 결과 6 => 7번째부터 10개의 데이터
           , SUBSTR(ADMINIST_ZONE, 1, INSTR(ADMINIST_ZONE, '(')-1) AS ADMINIST_ZONE_NM, -- 3. ADMINIST_ZONE 값에서 1번째부터 5번째까지의 데이터를 ADMINIST_ZONE_NM에다가 넣기
             '202304' AS STD_MT
           , MALE_POPLTN_CO_0_9    , MALE_POPLTN_CO_10_19  , MALE_POPLTN_CO_20_29
           , MALE_POPLTN_CO_30_39  , MALE_POPLTN_CO_40_49  , MALE_POPLTN_CO_50_59
           , MALE_POPLTN_CO_60_69  , MALE_POPLTN_CO_70_79  , MALE_POPLTN_CO_80_89  , MALE_POPLTN_CO_90_99  , MALE_POPLTN_CO_100
           , FEMALE_POPLTN_CO_0_9  , FEMALE_POPLTN_CO_10_19, FEMALE_POPLTN_CO_20_29
           , FEMALE_POPLTN_CO_30_39, FEMALE_POPLTN_CO_40_49, FEMALE_POPLTN_CO_50_59
           , FEMALE_POPLTN_CO_60_69, FEMALE_POPLTN_CO_70_79, FEMALE_POPLTN_CO_80_89, FEMALE_POPLTN_CO_90_99, FEMALE_POPLTN_CO_100
           , POPLTN_CO_0_9         , POPLTN_CO_10_19, POPLTN_CO_20_29
           , POPLTN_CO_30_39       , POPLTN_CO_40_49, POPLTN_CO_50_59
           , POPLTN_CO_60_69       , POPLTN_CO_70_79, POPLTN_CO_80_89, POPLTN_CO_90_99, POPLTN_CO_100
           , LVL1, LVL2
        FROM TB_POPLTN_DATA, -- 2. 서브쿼리중 FROM 절 부터 => 테이블이 조인인데 없다? CARTESIAN JOIN임.
             (SELECT (tmp1.idx) AS LVL1 FROM (SELECT 1 as idx UNION SELECT 2 UNION SELECT 3) tmp1) LVL1,  -- LV_1(성별)에 1,2,3이 들어있는 코드테이블(1:남자, 2:여자, 3:전체)
             (SELECT (tmp2.idx) AS LVL2 FROM (SELECT 1 as idx UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) tmp2) LVL2 -- LV_2(나이대)에 1~11이 들어있는 코드테이블
             -- 만든 LV_1, LV_2로 TB_POPLTN_DATA와 CATESIAN JOIN이 발생하는것
     ) A ;

COMMIT;

SELECT * FROM TB_POPLTN; -- 분석가능한 상태로 데이터 편집된 상황