class Data
{
  static var _d;
  String name="";
  var obj;
  int index=0;
  setData(String n,var o,int i)
  {
    index=i;
    name=n;
    obj=o;
  }
  getIndex()
  {
    return index;
  }
  getName()
  {
    return name;
  }
  getObj()
  {
    return obj;
  }
  _Data()
  {

  }
  static Data getinstance()
  {
    if(_d!=null)
    {
      return _d;
    }
    else
    {
      _d=new Data();
      return _d;
    }
  }
}