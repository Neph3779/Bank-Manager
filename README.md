**프로젝트명: 뱅크매니저**

**프로젝트 설명:** GCD 대신 Operation Queue를 활용해 은행에서 대기중인 다양한 등급의 손님들을 손님의 등급(Vvip, Vip, 일반) 순서대로 여러개의 창구에서 비동기적으로 처리하는 과정을 Console창과 UI를 통해 볼 수 있도록 두 단계에 거쳐 구현한 프로젝트

**프로젝트 기간: 2021/04/26 ~ 2021/05/07 (약 2주)**

### Console앱 작동화면

Console앱 설명: 랜덤한 등급과 인원수의 손님을 3개의 창구에서 등급우선순으로 처리하는 과정을 나타내는 프로그램. 

대기중인 손님 중 등급 우선순위가 가장 높은 손님을 먼저 처리하며, 대출업무의 소요시간은 1.1초, 예금업무의 소요시간은 0.7초로 세팅되어있음.

<img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20220923182331.gif" alt="화면 기록 2022-09-23 오후 6.08.22" style="zoom:50%;" />



## 주요 학습 내용

- Operation Queue, Dispatch Queue에 대한 이해
- Protocol Oriented Programming의 시도
- 객체의 기능별 분리
- Unit test
- Result Type을 통한 값, 에러 전달



## 주요 피드백 및 개선 내역

**Step1 PR 링크:** https://github.com/yagom-academy/ios-bank-manager/pull/33

**Step2 PR 링크:** https://github.com/yagom-academy/ios-bank-manager/pull/42



> 피드백 1: 테스트만을 위해서 존재하는 프로퍼티를 실제 프로덕션 코드에 두는 방법은
> 테스트를하기위해서 private -> public으로 접근제한자를 여는 것 과 크게 다르지 않을 것 같아요 🤔

테스트를 위한 프로퍼티의 경우에는 프로토콜을 통해 Spy나 Mock을 만들어 확인했어야 했다. 또한 접근제어자를 테스트코드를 위해서 열어놓는 것은 바람직하지 못한 접근법이었다.



> 피드백 2: `setUp()`, `tearDown()`
> 메소드에 대해서도 참고해보셔도 좋을 것 같아요

피드백을 통해 setUpWithErrors, tearDownWithErrors 등 테스트 코드에서 사용되는 메서드와 활용법에 대해 알아볼 수 있었다. 모든 테스트 케이스마다 저것들이 호출되는 것도 알게 되었다.

> 피드백 3: 로직들이 모두 Protocol에 있어서 구현체에는 로직이 없군요 음!
> 어떤 로직들인 프로토콜에서 구현하고 어떤 로직들은 구현체에만 있어야할 것들도 있지 않을까요?

프로토콜의 extension에 구현부를 만들 수 있는 것을 남용해서 구현체에 있어야 할 코드와 프로토콜에 있어야 할 코드의 구분이 없어졌다. 피드백을 바탕으로 둘을 분리하는 작업을 거쳤다.



> 피드백 4: inout으로 받아서 RandomGenerator의 내부에서 Bank를 바꾸는 부분이 있네요
> 이 과정은 강한 커플링이 생기고 테스트하기 어렵겠네요

객체가 다른 인스턴스의 내부값을 직접 수정하는 작업이 있었는데 이는 커플링이 강하게 생기는 코드였다. 해당 부분을 담당하는 객체를 따로 빼내어서 해결했다.



> ```swift
> func createRandomNumberInRange(_ start: Int, to end: Int) -> Int {
>   return Int.random(in: start...end)
>   }
> ```
>
> 피드백 5: 만약 start가 end 보다 크면 어떻게 되나요?

PS를 하면서도 종종 봤던 에러인데 range가 거꾸로 되면 런타임 에러가 난다. 

start <= end를 체크하는 로직을 추가하여 개선했다.



> ```swift
> func test_getNewTicket_호출시_ticketNumber_반환이_정상적으로되는지() {
>   let firstTicketNumber = dummyBank?.getNewTicketNumber()
>   XCTAssertEqual(firstTicketNumber, 1)
>   }
> ```
>
> 테스트의 메소드 이름이 조금 더 명확하면 좋을 것 같아요
> 정상적인게 어떤 건지? 아예 **처음 호출시 0이 반환되는지**와같은 보다 명확한 스펙을 전달하는건 어떨까요

test 메서드의 네이밍에 관한 피드백이었다. "정상적으로되는지"와 같은 모호한 표현을 버리고 더 정확한 스펙을 가지고 네이밍을 짓는 방향으로 개선했다.



## 시간이 지나고 다시 본 뱅크매니저 프로젝트

### 문제점

- Protocol Oriented Programming이란 것을 처음듣고 만든 첫 프로젝트라 프로토콜을 어떻게 사용해야 하는지도 모르면서 무작정 모든 기능에 프로토콜을 집어넣었다. 결과적으로 아무 의미없는 프로토콜들이 잔뜩 들어가서 코드가 오히려 난잡해지는 상황이 벌어졌다.
- 기능의 분리가 제대로 이루어지지 않은 부분들이 보인다.
  - Customer 객체가 들고 있는 Enum type들이 random이라는 연산 프로퍼티를 가지고 있는데, 이는 random하게 고객을 생성하기 위한 것이므로 이 기능은 Customer 객체가 들고있기 보다는 RandomGenerator에서 처리하는 것이 맞다고 판단하게 되었다.
- 성능적 측면만을 고려한 나머지 side effect를 고려하지 않은 객체의 타입(struct) 선택
  - struct는 값 타입이기 때문에 인자로 들어가게 될 시에 값을 복사하므로 인스턴스를 주고받는 과정에서 인스턴스 내의 값 변경이 목적이더라도 값 변경이 이루어지지 않는 경우가 많음
  - 처음에 이를 고려하지 않고 제작하여 트러블 슈팅이 많았음
- 잘못된 네이밍의 test double들
  - test double의 용어 개념에 대해 이해하지 못한 상태에서 작성된 테스트 코드라 dummy, mock등의 단어가 혼용되어 남발되었다.
- View와 Controller가 전혀 분리되어있지 않다
  - 앞선 step들에서 consoleViewController를 먼저 제작하게 한 이유는 view, controller 분리를 먼저 하도록 유도하는 과정이었을 것 같은데 console상에 print하는건 어디서든 간단하게 할 수 있었기 때문에 print를 아무데나 남발을 했었고, 이는 의존성관계가 여러군데 걸리는 원인이 되었다.




### 리팩토링 + 추가 구현내역

- Console앱에 구현된 Test를 리팩토링하여 불필요한 protocol, test들의 삭제, 알맞은 test double 용어로 교체하는 과정 등을 진행했다.
- print문이 남용되어 view와 controller부분이 전혀 분리되지 않았던 문제를 UI app 구현시에는 delegate 패턴, escaping 클로저의 인자전달 등의 방법으로 해결했다.
- Compositional layout과 diffable datasource를 활용해 UI적으로도 은행원의 업무가 보일 수 있도록 앱을 완성시켰다.



### UI앱 작동화면

<img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20221019160629.gif" alt="BankManager" style="zoom:50%;" />
