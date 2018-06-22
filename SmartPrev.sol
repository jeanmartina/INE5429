pragma solidity ^0.4.0;

contract ContratoPrevidenciario {
    
    
    struct Participante{
        //acusando erros com o "private" nos atributos, por isso tirei
        string nome;
        uint idade;
        //possíveis statusParticipante -> Ativo, Benefício(recebendo), Cancelado
        string statusPrimario;
        //modo de armazenar correto (???)
        mapping (address => uint256) saldoParticipante;
         }
        
    address public planoPrevidenciario;
    mapping (address => Participante) public participantesPlano;
    mapping (address => uint256) public saldoPlano;
    
    //permite procurar por tal transação no futuro utilizando estes parametros indexados como filtro
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
   
   
  //constructor 
    function ContratoPrevidenciario (){
        //planoPrevidenciario é quem cria o ContratoPrevidenciario
        planoPrevidenciario = msg.sender;
    }
    
    //Somente o plano pode matricular um participante... Ou não ? O participante pode se automatricular ? A decidir...
    function MatriculaParticipante (address participante, uint age, string name) {
        if (msg.sender != planoPrevidenciario) return;
        participantesPlano[participante].statusPrimario = "Ativo";
        participantesPlano[participante].idade = age;
        participantesPlano[participante].nome = name;
        //participantesPlano[participante].saldoParticipante = 0; Ver melhor esta linha...
    }
    
    //função para comparar duas strings pelo hash, retorna true se forem diferentes
    function stringsDiferentes (string a, string b) view returns (bool){
       return keccak256(a) != keccak256(b);
   }
    
    //função para realizar contribuição caso o participante tenha saldo e esteja ativo.
    function realizarContribuicao(address plano, uint amount) returns (bool contribuicaoRealizada) {
        if (saldoPlano[msg.sender] < amount || stringsDiferentes(participantesPlano[msg.sender].statusPrimario, "Ativo" )) return false;
        saldoPlano[msg.sender] -= amount;
        saldoPlano[plano] += amount;
        Transfer(msg.sender, plano, amount);
        return true;
    }

    //função teste de setar nome ( orientação a objetos feelings =( )
    function setName (address participante,string newName) {
        participantesPlano[participante].nome = newName;
    }
    
    //função teste de pegar nome ( orientação a objetos feelings =( )
    function getName (address participante) returns (string) {
        return participantesPlano[participante].nome;
    }
    
}


// to do

contract PlanoPrevidenciario {
    
    
    
}
