# shopping_list

A new Flutter project.

## Firebase real-time db 연결하기 
1. https://firebase.google.com/?hl=ko 로그인, 콘솔로 이동
2. 프로젝트 추가, (애널리틱스 사용 설정 해제)
3. 메뉴 > 빌드 > Realtime Database 
   1. base url 복사 후 사용
   2. 보안 규칙 수정 
        ```json
        {
          /* Visit https://firebase.google.com/docs/database/security to learn more about security rules. */
          "rules": {
            ".read": true,
            ".write": true
          }
         }
        ```
4. **http** library 추가 `flutter pub add http`
5. **http** post: `http.post(url, `
         