import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Debug "mo:base/Debug";
import Resultmodulo "mo:base/Result";

actor {
  //definir columnas sus tipos de una tabla
    type User={
    nombre:Text;
    edad:Nat;
  };
  //se crea la tabla con los registros
  stable var user:[User]=[{
    nombre="Sandra";
    edad=12;
  },{
    nombre="Carlos";
    edad=18;
  }];
  //caller es donde se ve si el internet identity  fue verificado por el usuario
  public shared  query ({caller})func quienes():async Principal{
    return caller;
  };
  //esto es para almacenar reslutados de cuando esta bien y luego cuando no se cumpla
  type Consegurusuarios=Resultmodulo.Result<[User],Text>;
//evalua si el usuario esta autenticado y si es asi deja realizar la funcion de ver los usuarios (regresa el Consegurusuarios con el resultado dependiendo si se cumple o no)
  public shared query ({caller}) func verusuarios():async Consegurusuarios{
    Debug.print(Principal.toText(caller));
    if(Principal.isAnonymous(caller)){
      //para añadir otro variable o cadena se usa # y no +
       Debug.print("El usuario no esta autenticado"#Principal.toText(caller));
       //le dice a Consegurusuarios que de el resultado de que no se cumplio lo pedido lo cual es un texto
       return #err("Error el usuario aun no se autentico");
    }
    else{
       Debug.print("El usuario esta autenticado");
       // el #ok le dice a Consegurusuarios que de el resultado de que si se cumplio lo pedido lo cual es el array user con los datos dentro del tipo definidos en User
       return #ok(user);};
    
  };
};
