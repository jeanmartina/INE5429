pragma solidity ^0.4.11;

contract ContratoPrevidenciario {
    
    address owner = msg.sender;
    mapping (address => contribuicoesInvalidez) planoInvalidez;
    mapping (address => contribuicoesEducacionais) planoEducacional;
    mapping (address => contribuicoesNormais) planoNormal;
    Participante participante;
    string statusContrato;
    
    struct Participante{
        uint cpf;
        uint idadeEntrada;
        uint idadeSaida;
        string status;
        address enderecoParticipante;
    }
    
    struct contribuicoesInvalidez {
        address participante;
        uint256 valor;
    }
    
    struct contribuicoesNormais {
        address participante;
        uint256 valor;
    }
    
    struct contribuicoesEducacionais {
        address participante;
        uint256 valor;
    }
    
     modifier onlyOwner(address account) {
        require(msg.sender == account);
        _;
    }
    
    //permite procurar por tal transação no futuro utilizando estes parametros indexados como filtro
     event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
     //função para comparar duas strings pelo hash, retorna true se forem diferentes
     function stringsDiferentes (string a, string b) view returns (bool){
       return keccak256(a) != keccak256(b);
   }
    
    //criação do contrato previdenciario - constructor 
    
     constructor  (uint _cpfParticipante, uint _idadeEntradaParticipante, 
    uint _idadeSaidaParticipante){
        
        participante.cpf = _cpfParticipante;
        participante.idadeEntrada = _idadeSaidaParticipante;
        participante.idadeSaida = _idadeEntradaParticipante;
        
    }
    
}
