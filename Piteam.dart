class Piteam
{
  static var _d;
  Map map={};
  List list=[];


  void add(String name,int i)
  {
    name=name+"%"+i.toString();
    map.putIfAbsent(name, (){
      list.add(name);
      return 0;
    });
    map[name]++;
  }


  void remove(String name,int i)
  {
    name=name+"%"+i.toString();
    map.putIfAbsent(name, (){
      list.add(name);
      return 0;
    });
    map[name]--;
  }


  int get(String name,int i)
  {
    name=name+"%"+i.toString();
    if(map.containsKey(name))
    {
      return map[name];
    }
    else
    {
      return 0;
    }
  }


  num getn(String name)
  {
    num ret=0;
    for(var n in list)
    {
      if(n.split("%")[0]==name)
      {
        ret=ret+map[n];
      }
    }
    return ret;
  }

  num total()
  {
    num ret=0;
    for(var n in list)
    {
      ret=ret+map[n];
    }
    return ret;
  }


  void clean()
  {
    map.clear();
    list.clear();
  }


  _Piteam(){
    clean();
  }


  static Piteam getinstance()
  {
    if(_d!=null)
    {
      return _d;
    }
    else
    {
      _d= new Piteam();
      return _d;
    }
  }
}