class Peoples {
  int id;
  String name, phone, time, costperhour, paidamount, total, remaining;

  Peoples({this.id, this.name, this.phone, this.time, this.costperhour,
      this.paidamount, this.total, this.remaining});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'time': time,
      'costperhour': costperhour,
      'paidamount': paidamount,
      'total': total,
      'remaining': remaining
    };
    return map;
  }

  Peoples.fromMap(Map<String, dynamic>map){
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    time = map['time'];
    costperhour = map['costperhour'];
    paidamount = map['paidamount'];
    total = map['total'];
    remaining = map['remaining'];
  }

}