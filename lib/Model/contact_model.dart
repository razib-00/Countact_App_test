

const String ContactTable='contact_table';
const String tblColId='id';
const String tblColName='name';
const String tblColPhone='phone';
const String tblColEmail='email';
const String tblColAddress='address';
const String tblColGPO='gpo';
const String tblColCompany='company';
const String tblColDesignation='designation';
const String tblColWebsite='website';
const String tblColImage='image';
const String tblColFavorite='favorite';

class ContactModel{
  int id;
  String name;
  String phone;
  String email;
  String address;
  String gpo;
  String company;
  String designation;
  String website;
  String image;
  bool favorite;

  ContactModel(
      {this.id=0,
      required this.name,
      required this.phone,
      this.email='',
      this.address='',
      this.gpo='',
      this.company='',
      this.designation='',
      this.website='',
      this.image='',
        this.favorite=false
      });
  Map<String,dynamic>toMap(){
    var map=<String,dynamic>{
      tblColName:name,
      tblColPhone:phone,
      tblColEmail:email,
      tblColAddress:address,
      tblColGPO:gpo,
      tblColCompany:company,
      tblColDesignation:designation,
      tblColWebsite:website,
      tblColImage:image,
      tblColFavorite:favorite?1:0
    };
    if(id>0){
      map[tblColId]=id;
    }
    return map;
  }
  factory ContactModel.formMap(Map<String,dynamic>map)=>ContactModel(
    id: map[tblColId],
    name: map[tblColName],
    phone: map[tblColPhone],
    email:map [tblColEmail],
    address:map [tblColAddress],
    gpo:map [tblColGPO],
    company: map[tblColCompany],
    designation: map[tblColDesignation],
    website:map [tblColWebsite],
    image:map [tblColImage],
    favorite:map [tblColFavorite]==1 ?true:false,
  );

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, phone: $phone, email: $email, address: $address, gpo: $gpo, company: $company, designation: $designation, website: $website, image: $image}';
  }
}