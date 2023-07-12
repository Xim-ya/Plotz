# Convention

## 레이어별 모듈 이름 및 파일이름

- data > api
    - <***>_response.dart, ***Response, res() (응답)
    - <***>_request.dart, ***Request, req (요청)
  
- domain > useCase
    - <***>_use_case.dart
  
- domain > model
    - content_model.dart,
    - Content

## 데이터 지칭 (내부 변수 및 클래스 타입)

- 어레이 데이터
    - movies(O), movieList(X) , MovieList
- 어레이 데이터 원소
    - movie, Movie

## 메소드명
- Bool 타입 상태값 데이터 호출
  - is<****>

  

## CRUD 동작

- 데이터 호출
    - load (api 통신)
    - get (local database 접근)


- 데이터 저장
    - save  (api 통신)
    - store (local database 접근)

- 데이터 변경
    - update (api 통신)
    - change (local database 접근)

- 데이터 제거
    - delete, remove (api 통신)
    - clear (local database 접근)


- 데이터 생성
    - create (api 통신)
    - generate (local database 접근)



