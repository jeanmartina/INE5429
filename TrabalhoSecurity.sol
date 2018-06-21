pragma solidity ^0.4.0;

contract ContratoPrevidenciario {
    struct Participante{
        string private nome;
        uint private idade;
        //possíveis statusParticipante -> Ativo, Benefício(recebendo), Cancelado
        string private status;
         }
        
    address public planoPrevidenciario;
    mapping (address => Participante) public participantesPlano;
    
    function ContratoPrevidenciario {
        //planoPrevidenciario é quem cria o ContratoPrevidenciario
        planoPrevidenciario = msg.sender;
    }
    
    function MatriculaParticipante (adress participante) {
        if msg.sender != planoPrevidenciario return;
        
        
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
