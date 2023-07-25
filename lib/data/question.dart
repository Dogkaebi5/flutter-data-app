class Questions {
  List<Map> basicInfo = [
    {"title": "결혼여부",
    "option" : ["미혼", "기혼"]},
    {"title": "자녀유무",
    "option" : ["없음", "있음"]},
    {"title": "최종학력",
    "option" : ["고졸 및 이하", "전문대", "대학", "대학원"]},
    {"title": "직종",
    "option" : ["관리직", "사무직", "학생", "무직"]},
    {"title": "소득수준",
    "option" : ["3000만 이하","3000만~5000만","5000만~1억", "1억 이상"]},
    {"title": "거주지역(도/시)"},
    {"title": "거주지역(시/구/군)"}
  ];

  Map region = {
    "서울특별시": ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"], 
    "부산광역시": ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"], 
    "대구광역시": ["군위군", "남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"], 
    "인천광역시": ["강화군", "계양구", "남동구", "동구", "미추홀구", "부평구", "서구", "연수구", "옹진군", "중구"], 
    "광주광역시": ["광산구", "남구", "동구", "북구", "서구"], 
    "대전광역시": ["대덕구", "동구", "서구", "유성구", "중구"], 
    "울산광역시": ["남구", "동구", "북구", "울주군" "중구"], 
    "세종특별자치시": [""], 
    "경기도": ["가평군", "고양시 덕양구", "고양시 일산동구", "고양시 일산서구", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시 분당구", "성남시 수정구", "성남시 중원구", "수원시 권선구", "수원시 영통구", "수원시 장안구", "수원시 팔달구", "시흥시", "안산시 단원구", "안산시 상록구", "안성시", "안양시 동안구", "안양시 만안구", "양주시", "양평군", "여주시", "연천군", "오산시", "용인시 기흥구", "용인시 수지구", "용인시 처인구", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"], 
    "강원특별자치도": ["강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군", "양양군", "영월군", "원주시", "인제군", "정선군", "철원군", "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군"], 
    "충청북도": ["괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "제천시", "증평군", "진천군", "청주시 상당구", "청주시 서원구", "청주시 청원구", "청주시 흥덕구", "충주시"], 
    "충청남도": ["계룡시", "공주시", "금산군", "논산시", "당진시", "보령시", "부여군", "서산시", "서천군", "아산시", "예산군", "천안시 동남구", "천안시 서북구", "청양군", "태안군", "홍성군"], 
    "전라북도": ["고창군", "군산시", "김제시", "남원시", "무주군", "부안군", "순창군", "완주군", "익산시", "임실군", "장수군", "전주시 덕진구", "전주시 완산구", "정읍시", "진안군"], 
    "전라남도": ["강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시", "담양군", "목포시", "무안군", "보성군", "순천시", "신안군", "여수시", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"], 
    "경상북도": ["경산시", "경주시", "고령군", "구미시", "김천시", "문경시", "봉화군", "상주시", "성주군", "안동시", "영덕군", "영양군", "영주시", "영천시", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군", "포항시 남구", "포항시 북구"], 
    "경상남도": ["거제시", "거창군", "고성군", "김해시", "남해군", "밀양시", "사천시", "산청군", "양산시", "의령군", "진주시", "창녕군", "창원시 마산합포구", "창원시 마산회원구", "창원시 성산구", "창원시 의창구", "창원시 진해구", "통영시", "하동군", "함안군", "함양군", "합천군"], 
    "제주특별자치도": ["서귀포시", "제주시"]
  };

  Map<String, List<Map<String, dynamic>>> interests = {
    "보험설계": [
      {"title": "가입한 보험이 있으신가요?",
      "option": ["10개 이상", "6~10개", "3~5개", "1~2개", "없음"]},
      {"title": "어떻게 해당 보험에 가입하셨나요?",
      "option" : ["소설광고", "지인 소개", "영업 전화", "검색", "기타"]},
      {"title": "월 평균 납입하는 보험료는?",
      "option" : ["100만 이상", "50~100만", "10~50만", "10만 이하", "없음"]},
      {"title": "신규/추가로 보험 상담/가입할 의향이 있나요?",
      "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "보험 구매에 중요시 하는 점은?",
      "option" : ["보상", "비용", "전문성", "지인추천", "소셜 및 입소문"]},
      {"title": "현재 관심있는 보험의 종류는 무엇인가요?",
      "option" : ["생명", "중질환", "전문성", "치아", "실비보험", "기타"]}], 
    "대출": [
      {"title": "현재 대출이 있으신가요?",
      "option" : ["주택담보대출", "신용대출", "없음"]},
      {"title": "어떻게 대출 상품을 선택하셨나요?",
      "option" : ["소설광고", "지인 소개", "영업 전화", "직접 방문 신청", "검색"]},
      {"title": "대출금 현황은?",
      "option" : ["1억 이상", "5000~1억", "3000~5000만", "3000만 이하", "없음"]},
      {"title": "월 상환금액은 얼마나 되나요?",
      "option" : ["800만 이상", "500~800만", "200~500만", "100~200만", "100만 이하"]},
      {"title": "신규/추가로 대출받을 계획이 있나요?",
      "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "대출에 중요시 하는 점은?",
      "option" : ["가능 최대액", "이자율", "전문가 추천", "지인추천", "소셜 및 입소문"]},
      {"title": "현재 기타 관심있는 대출은 무엇인가요?",
      "option" : ["주택담보대출", "자동차 담보대출", "신용대출"]}] , 
    "예금/적금": [
      {"title": "가입한 정기 예/적금이 있으신가요?",
      "option" : ["1억 이상", "5000~1억", "1000~5000만", "1000만 이하", "없음"]},
      {"title": "어떻게 대출 상품을 선택하셨나요?",
      "option" : ["소설광고", "지인 소개", "영업 전화", "직접 방문 신청", "검색"]},
      {"title": "가입한 상품의 저축 기간은 얼마나 되나요?",
      "option" : ["5년 이상", "3~5년", "1~3년", "1년 미만", "없음"]},
      {"title": "월 정기 저축하고 있는 금액이 얼마인가요?",
      "option" : ["500만 이상", "100~300만", "50~100만", "50만", "없음"]},
      {"title": "신규/추가로 대출받을 계획이 있나요?",
      "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "예/적금 상품 가입시 중요시하는 점은?",
      "option" : ["금리", "최대금액", "은행 신용도", "지인추천", "소셜 및 입소문"]}], 
    "부동산": [
      {"title": "보유 중인 부동산이 있으신가요?",
      "option" : ["10개 이상", "6~10개", "3~5개", "1~2개", "없음"]},
      {"title": "어떤 경로로 부동산을 구매하셨나요?",
      "option" : ["온라인 광고", "온라인 플랫폼", "부동산", "영업 전화", "직거래"]},
      {"title": "신규/추가로 부동산 매입 계획이 있는지?",
      "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "부동산 거래에 중요시하는 점은?",
      "option" : ["투자성", "임대료 투자", "전문가 추천", "지인추천", "소셜 및 입소문"]},
      {"title": "현재 관심있는 부동산 매물은 무엇인가요?",
      "option" : ["아파트", "재개발 지역", "외곽 휴양용", "부동산 매도"]},
      {"title": "부동산 경매에 참여해본 적이 있으신가요??",
      "option" : ["있다", "없다"]},
      {"title": "부동산 경매를 선호하는 이유는?",
      "option" : ["시세보다 저렴한 가격", "정보가 빠르고 정확하며 접근 용이", "안전하고 간편한 매수(입찰) 절차", "부동산 규제를 피할 수 있음", "기타"]},
      {"title": "경매 정보를 어디에서 얻으시나요?",
      "option" : ["법원경매정보 사이트", "유료경매 사이트", "경매전문 카페나 동호회", "경매컨설팅업체", "기타"]},
      {"title": "연간 평균 경매 입찰 횟수는?",
      "option" : ["월 1~2회", "분기당 1~2회", "반기당 1~2회", "연 1~2회", "좋은 매물에 따라 입찰"]},
      {"title": "신규/추가로 경매에 입찰할 계획이 있나요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},
      {"title": "경매 입찰 물건을 선택하는 기준은 무엇인가요?",
      "option" : ["예상 수익 (추후 시세 급등 예상되는 매물)", "합당한 경매 가격 (낙찰가율 고려)", "입지와 현재 매물 상태 (임장)", "권리 분석 결과 (문제되지 않을 매물인지)", "기타"]},], 
    "주식": [
      {"title": "보유 중인 주식이 있으신가요?",
      "option" : ["1억 이상", "5000~1억", "1000~5000만", "1000만 이하", "없음"]},
      {"title": "주식을 보유하고 있는 이유는 무엇인가요?",
      "option" : ["투자 목적", "배당금", "영업권 참여"]},
      {"title": "보유한 주식에 투자한 이유는 무엇인가요?",
      "option" : ["재무제표 혹 기술 분석", "전문가 추천", "지인 추천", "온라인 추천", "뉴스 및 이슈"]},
      {"title": "월 주식 거래액은 얼마정도인가요?",
      "option" : ["1000만 이상", "500~1000만", "100~500만", "100만 이하", "없음"]},
      {"title": "신규/추가로 주식을 매입할 계획이 있나요?",
      "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "주식 투자에서 중요시하는 점은?",
      "option" : ["투자성", "배당금", "전문가 추천", "지인추천", "소셜 및 입소문"]},
      {"title": "주로 거래하는 상품은 무엇인가요?",
      "option" : ["국내 주식", "해외 주식", "선물 거래", "외환 거래", "없음"]},
      {"title": "사용 중인 증권사를 선택한 이유는?",
      "option" : ["소셜 광고", "지인 소개", "영업 전화", "검색"]},
      {"title": "증권사를 변경할 의향이 있으신가요?",
      "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "증권사를 선택하는 기준은?",
      "option" : ["가입 이벤트", "UI 편리성", "증권사 신뢰도", "수수료", "외환 환전 등 기타 편리 기능"]}], 
    "가상자산": [
      {"title": "보유 중인 가상자산이 있으신가요?",
      "option" : ["1억 이상", "5000~1억", "1000~5000만", "1000만 이하", "없음"]},
      {"title": "가상자산을 보유하고 있는 이유는 무엇인가요?",
      "option" : ["투자 목적", "1차 시장 투자자", "커뮤니티 참여", "관련 업종 종사"]},
      {"title": "보유한 코인/토큰을 구매한 이유는 무엇인가요?",
      "option" : ["전문가 추천", "지인 추천", "온라인 추천", "뉴스 및 이슈"]},
      {"title": "월 가상자산 거래액은 얼마정도인가요?",
      "option" : ["1000만 이상", "500~1000만", "100~500만", "100만 이하", "없음"]},
      {"title": "신규/추가로 가상자산에 투자할 의향이 있으신가요?",
      "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "가상자산 투자에서 중요시하는 점은?",
      "option" : ["투자성", "오너 권리", "전문가 추천", "지인추천", "소셜 및 입소문"]},
      {"title": "현재 어떤 거래소를 이용중인가요?",
      "option" : ["국내 거래소", "해외 메이저 거래소", "해외 소형 거래소", "없음"]},
      {"title": "사용 중인 거래소를 선택한 이유는 무엇인가요?",
      "option" : ["소셜 광고", "지인 소개", "영업 전화", "검색"]},
      {"title": "거래소를 변경할 의향이 있으신가요?",
      "option" : ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "거래소 선택하는 기준은?",
      "option" : ["가입 이벤트", "UI 편리성", "브랜드 신뢰성 투명성", "지인추천", "카피 트레이너"]}], 
    "골프": [
      {"title": "골프를 시작하신지 얼마나 되셨나요?",
      "option" : ["10년 이상", "6~10년", "1~5년", "1년 이하", "없음"]},
      {"title": "골프를 하는 목적은 무엇인가요?",
      "option" : ["개인의 건강을 위해", "지인과의 친목활동", "단순 취미 활동", "접대 등 직업상 필요", "지인/친구의 권유"]},
      {"title": "연간 평균 골프장 라운드 횟수는?",
      "option" : ["10회 이상", "6~10회", "3~5회", "1~2회", "없음"]},
      {"title": "한달 평균 골프에 지출하는 비용은?(스크린, 연습장, 라운드비 포함)",
      "option" : ["70만원 이상", "50만원 이상~70만원 미만", "30만원 이상~50만원 미만", "20만원 이상~30만원 미만", "20만원 미만"]},
      {"title": "앞으로 골프를 시작/지속할 의향은 얼마나 있나요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},
      {"title": "골프장 선택에서 가장 중요한 기준은?",
      "option" : ["가격 (저렴한 라운드 비용)", "위치 (골프장의 접근성)", "장소의 질 (좋은 코스상태와 레이아웃)", "서비스 (직원들의 서비스)", "시설 (훌륭한 시설)"]},

      {"title": "골프연습장/스크린골프장을 이용해본 경험이 있나요?",
      "option" : ["있다", "없다"]},
      {"title": "골프연습장/스크린골프장에서 골프를 치는 이유는?",
      "option" : ["계절에 관계 없이 이용 가능", "필드 대비 저렴한 비용", "가족/친구와 함께 여가 향유", "혼자 연습하기에 적절", "집/직장 근처에 있어서"]},
      {"title": "어떻게 골프연습장/스크린골프장을 이용하게 되었나요?",
      "option" : ["지인의 추천", "집/회사 근처에 위치(접근성)", "인터넷 커뮤니티 후기", "브랜드", "기타"]},
      {"title": "한달 평균 스크린 골프 이용 횟수는?",
      "option" : ["10회 이상", "5회 이상~10회 미만", "3~4회", "1~2회", "없음"]},
      {"title": "앞으로 골프연습장/스크린 이용을 시작/지속할 의향은 얼마나 되나요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},
      {"title": "골프연습장/스크린 선택에서 고려하는 요소는 무엇인가요?",
      "option" : ["가격", "접근성", "시설", "서비스", "기타"]},

      {"title": "골프 레슨을 받아본 경험이 있나요?",
      "option" : ["있다", "없다"]},
      {"title": "골프 레슨을 받은 이유는 무엇인가요?",
      "option" : ["골프를 처음 시작해서", "전반적인 골프 수준 향상을 위해", "공이 잘 맞지 않아서", "골프를 쉬다가 다시 시작해서", "기타"]},
      {"title": "어떤 경로로 레슨 아카데미/프로를 찾는지?",
      "option" : ["지인의 추천", "집/회사 근처에 위치(접근성)", "인터넷 커뮤니티 후기", "TV 등 매체 광고", "기타"]},
      {"title": "골프 레슨을 받았거나 받고 있다면 그 기간은?",
      "option" : ["꾸준히 받는 중이다", "2년 이상", "1년 이하", "3개월 이하", "원 포인트식 레슨"]},
      {"title": "지금까지 골프 레슨비로 지출한 비용은?",
      "option" : ["300만원 이상", "200만원 이상~300만원 미만", "100만원 이상~200만원 미만", "50만원 이상~100만원 미만", "50만원 미만"]},
      {"title": "앞으로 골프 레슨을 신규/추가로 받을 의향이 있으신가요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},
      {"title": "골프 레슨을 받을 때 가장 중요시하는 것은?",
      "option" : ["티칭프로의 실력", "접근성", "비용", "티칭프로의 경력", "아카데미 시설"]},
      {"title": "골프 레슨을 받아본 경험이 없거나 받고 있지 않은 이유는?",
      "option" : ["시간, 비용 등이 없어서", "마음에 드는 티칭프로를 찾기 힘들어서", "집이나 회사 근처에 아카데미가 없어서", "책이나 영상으로 독학을 하는 게 더 좋아서", "레슨이 필요하지 않아서"]},

      {"title": "주로 골프용품을 구입하는 곳은?",
      "option" : ["인터넷 쇼핑몰", "골프 전문 매장", "골프장 내 프로샵", "백화점", "대형마트"]},
      {"title": "평균 1년 동안 골프용품 구매로 지출하는 비용은?",
      "option" : ["300만원 이상", "200만원 이상~300만원 미만", "100만원 이상~200만원 미만", "50만원 이상~100만원 미만", "50만원 미만"]},
      {"title": "골프용품 구매 시 가장 고려하는 요인은 무엇인가요?",
      "option" : ["제품의 성능", "브랜드", "가성비", "지인이나 프로의 추천", "개인 선호도"]},
      {"title": "골프용품에 대한 정보가 필요할 때 참고하는 것은?",
      "option" : ["온라인 쇼핑몰", "온라인 동호회 및 블로그", "언론광고", "지인의 권유", "프로가 사용하는 용품"]}], 
    "테니스": [
      {"title": "테니스를 시작하신지 얼마나 되셨나요?",
      "option" : ["20년 이상", "10년~20년 미만", "10~15년 미만", "1년 이하", "없음"]},
      {"title": "테니스를 하는 목적은 무엇인가요?",
      "option" : ["개인의 건강을 위해", "지인과의 친목활동", "단순 취미 활동", "사내 동아리 활동", "가족간의 화합"]},
      {"title": "일주일에 테니스를 몇 번이나 치나요?",
      "option" : ["5회 이상", "4회", "2~3회", "1회", "없음"]},
      {"title": "한달 평균 테니스에 지출하는 비용은?",
      "option" : ["30만원 이상", "20만원~30만원 미만", "10만원~20만원 미만", "5만원~10만원 미만", "5만원 미만"]},
      {"title": "앞으로 테니스를 시작/지속할 의향은 얼마나 있나요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},

      {"title": "테니스 레슨을 받아본 경험이 있나요?",
      "option" : ["있다", "없다"]},
      {"title": "테니스 레슨을 받은 이유는 무엇인가요?",
      "option" : ["테니스를 처음 시작해서", "전반적인 테니스 수준 향상을 위해", "공이 잘 맞지 않아서", "테니스를 쉬다가 다시 시작해서", "기타"]},
      {"title": "어떤 경로로 레슨 아카데미/프로를 찾는지?",
      "option" : ["지인의 추천", "집/회사 근처에 위치(접근성)", "인터넷 커뮤니티 후기", "TV 등 매체 광고", "기타"]},
      {"title": "테니스 레슨을 받았거나 받고 있다면 그 기간은?",
      "option" : ["꾸준히 받는 중이다", "2년 이상", "1년 이하", "3개월 이하", "원 포인트식 레슨"]},
      {"title": "지금까지 테니스 레슨비로 지출한 비용은?",
      "option" : ["100만원 이상", "50~100만원", "30~50만원", "10~30만원", "10만원 미만"]},
      {"title": "앞으로 테니스 레슨을 신규/추가로 받을 의향이 있으신가요?",
      "option" : ["있음", "없음"]},
      {"title": "테니스 레슨을 받을 때 가장 중요시하는 것은??",
      "option" : ["티칭프로의 실력", "접근성", "비용", "티칭프로의 경력", "아카데미 시설"]},
      
      {"title": "테니스 용품을 어디에서 구입하시나요?",
      "option" : ["인터넷 쇼핑몰", "테니스 전문 매장", "할인 마트", "백화점", "기타"]},
      {"title": "평균 1년 동안 골프용품 구매로 지출하는 비용은?",
      "option" : ["100만원 이상", "70만원 이상~100만원 미만", "40만원 이상~70만원 미만", "20만원 이상~40만원 미만", "520만원 미만"]},
      {"title": "테니스 용품 구매 시 가장 고려하는 요인은 무엇인가요?",
      "option" : ["제품의 성능", "브랜드", "가성비", "지인이나 프로의 추천", "개인 선호도"]},], 
    "피트니스": [
      {"title": "헬스장(피트니스클럽 등)에 등록해본 경험이 있습니까?",
      "option" : ["있음", "없음"]},
      {"title": "헬스장을 이용하는 이유는?",
      "option" : ["건강", "사교", "다이어트", "취미", "기타"]},
      {"title": "헬스를 어떻게 알게 되셨나요?",
      "option" : ["포털 검색", "인스타그램 등 SNS", "외부 간판 및 배너", "지인 소개", "기타"]},
      {"title": "헬스클럽에 얼마나 자주 방문하시나요?",
      "option" : ["매일", "주 4~5회", "주 2~3회", "주 1회", "주 1회 이하"]},
      {"title": "한달 평균 헬스에 지출하는 비용은?",
      "option" : ["100만원 이상", "70만원 이상~100만원 미만", "70만원 이상~100만원 미만", "70만원 이상~100만원 미만", "20만원 미만"]},
      {"title": "앞으로 헬스를 시작/지속할 의향은 얼마나 있나요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},
      {"title": "헬스장을 선택하는 기준은?",
      "option" : ["가격", "위치(접근성)", "장소의 질", "트레이너", "기타"]},
      {"title": "유료운동시설을 이용하지 않는 이유는?",
      "option" : ["홈짐/기구 등으로 홈트레이닝", "밀폐된 공간 코로나 등 감염병 위험", "PT(퍼스널트레이닝) 영업", "비용에 대한 부담", "마음에 드는 시설을 찾기 어려움"]}], 
    "요가": [
      {"title": "요가/필라테스 센터에 등록해본 경험이 있나요?",
      "option" : ["있음", "없음"]},
      {"title": "요가/필라테스 센터에 등록한 이유는?",
      "option" : ["건강", "사교", "다이어트", "취미", "기타"]},
      {"title": "요가/필라테스를 어떻게 알게 되셨나요?",
      "option" : ["포털 검색", "인스타그램 등 SNS", "외부 간판 및 배너", "지인 소개", "기타"]},
      {"title": "요가/필라테스를 얼마나 자주 하시나요?",
      "option" : ["매일", "주 4~5회", "주 2~3회", "주 1회", "주 1회 이하"]},
      {"title": "한달 평균 요가/필라테스에 지출하는 비용은?",
      "option" : ["100만원 이상", "70만원 이상~100만원 미만", "70만원 이상~100만원 미만", "70만원 이상~100만원 미만", "20만원 미만"]},
      {"title": "앞으로 요가/필라테스를 시작/지속할 의향은 얼마나 있나요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},
      {"title": "요가/필라테스 학원을 선택하는 기준은?",
      "option" : ["가격", "위치(접근성)", "장소의 질", "트레이너", "기타"]}], 
    "건강식품": [
      {"title": "건강식품을 복용한 경험이 있나요?",
      "option" : ["있음", "없음"]},
      {"title": "건강식품 복용 이유는?",
      "option" : ["건강유지(증진) 목적", "자녀/남편/부모 등 주변의 권유", "선물로 받아서", "현재 질병 개선(치료)", "체중조절(감소/증가) 목적"]},
      {"title": "건강식품을 어디에서 구매하시나요?",
      "option" : ["온라인 쇼핑몰", "약국", "TV홈쇼핑", "해외직구", "기타"]},
      {"title": "복용하는 건강식품 수는?",
      "option" : ["10가지 이상", "7~9가지", "4~6가지", "2~3가지", "1가지"]},
      {"title": "1년 평균 건강식품 구매를 위해 지출하는 비용은??",
      "option" : ["50만원 이상", "30만원 이상~50만원 미만", "20만원 이상~30만원 미만", "10만원 이상~20만원 미만", "10만원 미만"]},
      {"title": "향후 건강식품을 복용할 의향은 얼마나 있나요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},
      {"title": "건강식품을 선택하는 기준은?",
      "option" : ["효과, 효능", "가격", "제조사", "주변의 경험담", "기타"]},
      {"title": "건강식품에 대한 정보를 어디에서 얻나요?",
      "option" : ["인터넷", "TV 교양 프로그램", "인플루언서/지인의 추천", "유튜브, 인스타그램 등 SNS", "TV홈쇼핑"]},], 
    "교육": [
      {"title": "귀하의 자녀는 사교육 경험이 있나요?",
      "option" : ["있음", "없음"]},
      {"title": "자녀에게 사교육을 하는 이유는?",
      "option" : ["특목고, 대입 진학준비 위해", "선행학습을 위해", "다른 학생들이 하니까(성적에 대한 불안)", "부모님 권유", "학교수업만으로 충분하지 않아서"]},
      {"title": "사교육 종류? 과목?",
      "option" : ["종합/단과 학원", "개인/그룹 과외", "인터넷 강의(온라인 학습)", "학습지", "기타"]},
      {"title": "주당 사교육에 참여하는 시간은?",
      "option" : ["10시간 이상", "7~9시간", "5~6시간", "3~4시간", "1~2시간"]},
      {"title": "자녀 1인당 월평균 사교육에 소비하는 비용은?",
      "option" : ["80만원 이상", "60~80만원 미만", "40~60만원 미만", "20~40만원 미만", "20만원 미만"]},
      {"title": "향후 사교육을 신규/추가로 할 계획이 있나요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},
      {"title": "사교육을 선택하는 기준은?",
      "option" : ["강사의 실력", "학원 브랜드", "입소문", "자녀의 선호도", "학생관리능력"]},
      {"title": "사교육에 대한 정보를 어디에서 얻나요?",
      "option" : ["인터넷 카페, 블로그 등 커뮤니티", "자녀 유치원/학교의 학부모", "주변 이웃이나 친구 등 지인", "홍보물이나 학원 간판", "기타"]},

      {"title": "학습지를 구독하고 있거나 구독한 경험이 있나요?",
      "option" : ["있음", "없음"]},
      {"title": "학습지를 구독하는 이유는?",
      "option" : ["공부에 흥미를 느끼게 하고자", "기초학습에 반복학습 효과가 좋아서", "학원 및 기타 활동에 비해 상대적으로 저렴해서", "정기적으로 공부할 수 있어서", "기타"]},
      {"title": "어떤 경로로 학습지를 구독하게 되었나요?",
      "option" : ["학습지 무료체험", "주변지인의 추천", "센터(지부) 상담", "인터넷 카페/커뮤니티의 평", "기타"]},
      {"title": "현재 구독하고 있는 학습지 개수는?",
      "option" : ["5개 이상", "4개", "3개", "2개", "1개"]},
      {"title": "월평균 학습지 구독에 지출하는 비용은?",
      "option" : ["10만원 이상", "7~10만원 미만", "5~7만원 미만", "3~5만원 미만", "3만원 미만"]},
      {"title": "향후 학습지를 신규/추가로 구독할 계획이 있나요?",
      "option" : ["있음", "없음"]},
      {"title": "학습지 선택 기준은?",
      "option" : ["자료의 학습효과", "방문교사의 교육 서비스", "교재구성의 세밀함", "주변인들의 반응/입소문", "학습지 브랜드 신뢰도"]}], 

    "육아용품": [
      {"title": "육아용품을 구매한 경험이 있나요?",
      "option" : ["있음", "없음"]},
      {"title": "육아용품을 어디에서 구매하시나요?",
      "option" : ["온라인 쇼핑몰", "대형 마트", "백화점", "해외직구", "중고거래 사이트/앱"]},
      {"title": "1개월 평균 육아용품 구입에 소요되는 비용은??",
      "option" : ["80만원 이상", "60~80만원 미만", "40~60만원 미만", "20~40만원 미만", "20만원 이하"]},
      {"title": "향후 육아용품을 구매할 의향은 얼마나 있나요?",
      "option" : ["매우 있음", "약간 있음", "보통", "별로 없음", "전혀 없음"]},
      {"title": "육아용품 선택 시 최우선으로 고려하는 요소는?",
      "option" : ["디자인/컬러", "제품의 안전성", "합리적인 가격", "브랜드 인지도", "편리하고 다양한 기능"]},], 
    "자동차": [
      {"title": "현재 보유한 차량 수량?",
      "option": ["4대 이상", "3대", "2대", "1대", "없음"]},
      {"title": "보유중인 차량의 연식은?",
      "option": ["10년 이상", "8~10년", "5~8년", "3~5년", "3년 이하"]},
      {"title": "보유하신 차형은 어떻것인가요?",
      "option": ["전기차", "수소차", "일반 자동차"]},
      {"title": "현재 보유하신 차량 유형은 무엇인가요?",
      "option": ["승용차", "대형차", "스포츠카", "오토바이", "기타"]},
      {"title": "보유한 자동차의 주요 사용 목적은?",
      "option": ["출퇴근", "드라이브", "여행"]},
      {"title": "자동차를 구매한 경로는?",
      "option": ["대리점", "지인 소개", "온라인 커뮤니티 딜러", "중고거래래", "광고"]},
      {"title": "월 평균 주행거리는 얼마나 되나요?",
      "option": ["2000km 이상", "1000~2000km", "500~1000km", "100~500km", "100km 이하"]},
      {"title": "향후 차량을 신규/추가로 구매할 계획이 있나요?",
      "option": ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "자동차 구매 예산을 얼마 정도로 생각하고 있나요?",
      "option": ["1억 이상", "8000만~1억", "5000~8000만", "3000~5000만", "3000만 이하"]},
      {"title": "자동차 구매에 있어 중요시하는 점은?",
      "option": ["가격", "디자인", "성능", "브랜드", "지인 추천"]},
      {"title": "현재 관심있는 분야는?",
      "option": ["중고 판매", "중고 매입", "자동차 동호회", "드라이브 모임/정보", "자동차 면허/연수"]},

      {"title": "렌트카를 이용해본 경험이 있나요?",
      "option": ["있음", "없음"]},
      {"title": "자동차를 렌트한 경로는?",
      "option": ["렌트업체 방문", "렌트업체 홈페이지", "렌트카 플랫폼", "지인 소개", "광고"]},
      {"title": "차량 렌트에서 중요시하는 점은?",
      "option": ["가격", "렌트 및 반납 위치", "렌트카 상태", "회사 이미지", "지인 추천"]},

      {"title": "연간 자동차 정비를 몇번하시나요?",
      "option": ["11회 이상", "6~10회", "2~5회", "1회", "필요 시"]},
      {"title": "연 평균 유지보수비는 얼마나 되나요?",
      "option": ["800만 이상", "400~800만", "200~400만", "100~200만", "100만 이하"]},], 
    "국내여행": [
      {"title": "연간 국내여행을 몆번 하시나요?",
      "option": ["11회 이상", "6~10회", "3~5회", "1~2회", "1회 이하"]},
      {"title": "대부분 여행상품 선택 경로는?",
      "option": ["여행사 예약", "현지 여행사/여행 상품", "맞춤 여행", "가이드 동반 맞춤 여행", "검색 및 자유여행"]},
      {"title": "국내여행 1회 평균적으로 지출되는 비용은?",
      "option": ["250만 이상", "150~250만", "50~150만", "10~50만", "10만 이하"]},
      {"title": "향후 국내여행 계획이 있나요?",
      "option": ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "국내 여행 선택에 중요시하는 점은?",
      "option": ["비용", "먹거리", "관광 및 구경거리", "거리 및 이동 소요시간", "기타"]},], 
    "해외여행": [
      {"title": "연간 해외여행을 몆번 하시나요?",
      "option": ["11회 이상", "6~10회", "3~5회", "1~2회", "1회 이하"]},
      {"title": "대부분 여행상품 선택 경로는?",
      "option": ["여행사 예약", "현지 여행사/여행 상품", "맞춤 여행", "가이드 동반 맞춤 여행", "검색 및 자유여행"]},
      {"title": "해외여행 1회 평균적으로 지출되는 비용은?",
      "option": ["1000만 이상", "500~1000만", "300~500만", "100~300만", "100만 이하"]},
      {"title": "향후 국내여행 계획이 있나요?",
      "option": ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "해외 여행 선택에 중요시하는 점은?",
      "option": ["비용", "먹거리", "관광 및 구경거리", "거리 및 이동 소요시간", "기타"]},], 
    "캠핑": [
      {"title": "캠핑을 즐기기 시작한지 얼마나 되었나요?",
      "option": ["11년 이상", "6~10년", "1~5년", "1년 미만", "없음"]},
      {"title": "캠핑을 즐기는 이유는 무엇인가요?",
      "option": ["취미", "사교", "스트레스 해소", "혼자의 시간"]},
      {"title": "주로 즐기는 캠핑 유형은?",
      "option": ["글램핑 (캠핑장)", "오토캠핑", "자전거/모터 캠핑", "백 캠핑"]},
      {"title": "연간 평균 캠핑 횟수는 어떻게 되나요?",
      "option": ["30회 이상", "20~30회", "10~20회", "10회 이하"]},
      {"title": "캠핑 1회 평균적으로 지출되는 비용은?",
      "option": ["250만 이상", "150~250만", "50~150만", "10~50만", "10만 이하"]},
      {"title": "향후 캠핑 계획이 있나요?",
      "option": ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
      {"title": "캠핑에 중요시하는 점은?",
      "option": ["캠핑장의 가성비", "기타 편리시설 유무", "기타 활동시설", "거리 및 이동 소요시간", "기타"]},], 
    "낚시": [
    {"title": "낚시 경력이 얼마나 되었나요?",
    "option": ["11년 이상", "6~10년", "1~5년", "1년 미만", "없음"]},
    {"title": "낚시를 즐기는 이유는 무엇인가요?",
    "option": ["취미", "사교", "스트레스 해소", "혼자의 시간"]},
    {"title": "주로 즐기는 낚시 유형은?",
    "option": ["바다낚시", "민물낚시", "배스"]},
    {"title": "연 평균 낚시 횟수는 어떻게 되나요?",
    "option": ["30회 이상", "20~30회", "10~20회", "10회 이하"]},
    {"title": "낚시 1회 평균적으로 지출되는 비용은?",
    "option": ["250만 이상", "150~250만", "50~150만", "10~50만", "10만 이하"]},
    {"title": "향후 낚시 계획이 있나요?",
    "option": ["가능한 빨리", "1~3개월 내", "3~6개월", "6개월 ~ 1년", "없음"]},
    {"title": "낚시에 중요시하는 점은?",
    "option": ["낚시장소 소요 비용", "물때 및 대상어", "조과", "거리 및 이동 소요시간", "기타"]},], 

    "반려동물": [
    {"title": "현재 키우고 있는 반려동물의 종류는?",
    "option": ["강아지", "고양이", "기타", "없음"]},
    {"title": "강아지안 경우, 어떤 사이즈인가요?",
    "option": ["소형견 (7kg 이하)", "중형견 (7~15kg)", "대형견 (16kg 이상)"]},
    {"title": "반려동물을 어떻게 입양하게 되셨나요?",
    "option": ["팻숍", "온라인 입양", "지인 입양", "임보", "유기 / 길 입양"]},
    {"title": "연간 반려동물 서비스 이용 빈도는?",
    "option": ["20회 이상", "10~20회", "5~10회", "5회 이하"]},
    {"title": "월 평균 반려동물 양육에 소요되는 비용은?",
    "option": ["50만 이상", "30~50만", "20~30만", "10~20만", "10만 이하"]},
    {"title": "관심 있는 팻 정보는?",
    "option": ["반려동물 동반 여행", "동밥입장 가능 업소", "미용, 촬영", "유치원", "호텔"]},
    {"title": "업소 선정할 때 중요시 하는 점은?",
    "option": ["비용", "온라인 평점", "업소 연식", "거리 편리성", "기타"]},
  ]};
}