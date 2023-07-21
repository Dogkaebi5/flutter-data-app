import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  int _password = 1;
  String? _bank;
  String? _account;
  int _point = 0;

  String? _name = "홍길동";
  String? _mobile = "010-1234-5678";
  String? _sex = "남";
  String? _bitrhY = "2000";

  String? _nickname;
  String? _email;
  String? _agedGroup;
  
  String? _marriedData, _childData, _educationData, _occupationData, _incomeData, _residenceData;
  String? _marriedDataDate, _childDataDate, _educationDataDate, _occupationDataDate, _incomeDataDate, _residenceDataDate;
  bool _marriedIsPermission = false;
  bool _childIsPermission = false;
  bool _educationIsPermission = false;
  bool _occupationIsPermission = false;
  bool _incomeIsPermission = false;
  bool _residenceIsPermission = false;

  String? _insurance, _loan, _deposit, _immovables, _stock, _cryto, _golf, _tennis, _fitness, _yoga, _dietary, _educate, _parental, _automobile, _localTrip, _overseatrip, _camp, _fishing, _pet;
  String? _insuranceDate, _loanDate, _depositDate, _immovablesDate, _stockDate, _crytoDate, _golfDate, _tennisDate, _fitnessDate, _yogaDate, _dietaryDate, _educateDate, _parentalDate, _automobileDate, _localTripDate, _overseatripDate, _campDate, _fishingDate, _petDate;
  bool _isInsurance = false;
  bool _isLoan = false;
  bool _isDeposit = false;
  bool _isImmovables = false;
  bool _isStock = false;
  bool _isCryto = false;
  bool _isGolf = false;
  bool _isTennis = false;
  bool _isFitness = false;
  bool _isYoga = false;
  bool _isDietary = false;
  bool _isEducate = false;
  bool _isParental = false;
  bool _isAutomobile = false;
  bool _isLocalTrip = false;
  bool _isOverseatrip = false;
  bool _isCamp = false;
  bool _isFishing = false;
  bool _isPet = false;
  
  bool _isInsurancePermission = false;
  bool _isLoanPermission = false;
  bool _isDepositPermission = false;
  bool _isImmovablesPermission = false;
  bool _isStockPermission = false;
  bool _isCrytoPermission = false;
  bool _isGolfPermission = false;
  bool _isTennisPermission = false;
  bool _isFitnessPermission = false;
  bool _isYogaPermission = false;
  bool _isDietaryPermission = false;
  bool _isEducatePermission = false;
  bool _isParentalPermission = false;
  bool _isAutomobilePermission = false;
  bool _isLocalTripPermission = false;
  bool _isOverseatripPermission = false;
  bool _isCampPermission = false;
  bool _isFishingPermission = false;
  bool _isPetPermission = false;
}