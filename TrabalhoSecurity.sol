pragma solidity ^0.4.0;

contract ContratoPrevidenciario {
    struct Participante{
        //acusando erros com o "private" nos atributos, por isso tirei
        string nome;
        uint idade;
        //possíveis statusParticipante -> Ativo, Benefício(recebendo), Cancelado
        string statusPrimario;
         }
        
    address public planoPrevidenciario;
    mapping (address => Participante) public participantesPlano;
    
    function ContratoPrevidenciario (){
        //planoPrevidenciario é quem cria o ContratoPrevidenciario
        planoPrevidenciario = msg.sender;
    }
    
    function MatriculaParticipante (address participante, uint age, string name) {
        if (msg.sender != planoPrevidenciario) return;
        participantesPlano[participante].statusPrimario = "Ativo";
        participantesPlano[participante].idade = age;
        participantesPlano[participante].nome = name;
    }
    
    function realizarContribuicao(address plano, uint amount) returns (bool contribuicaoRealizada) {
        if (balances[msg.sender] < amount || participantesPlano[msg.sender].statusPrimario != "Ativo" ) return false;
        balances[msg.sender] -= amount;
        balances[plano] += amount;
        Transfer(msg.sender, receiver, amount);
        return true;
    }

        
    function setName (string newName) {
        name = newName;
    }
    
    function getName () returns (string) {
        return name;
    }
    
}

contract PlanoPrevidenciario {
    
    
    
}
