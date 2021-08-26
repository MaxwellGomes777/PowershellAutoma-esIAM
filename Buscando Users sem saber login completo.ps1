<#Autor: Maxwell Gomes da Silva
Github: https://github.com/MaxwellGomes777

Descrição: esse script busca no AD todos os usuários com a parte do nome definida no {samAccountName -like "*partedonome*"} e exporta
para um CSV no diretório "C:\temp\" com o nome "terceiroslogi.csv"

OBS: Usar o * no começo caso não saiba o início do login, usar no final caso não saiba o final do login, usar nas duas pontas caso só
tenha conhecimento do meio.

////////////////////////////////////////////////////////////////////

Caso: Ess script foi criado para auxiliar a liderança no levantamento dos funcionários terceirizados de uma empresa específica. Devida
a organização da empresa os funcionários terceirizados possuem o nome+sobrenome+.+nomedaempresaterceira. Exemplo: caso a Contoso
preste serviço para a nossa empresa a Maria Silva seria mariasilva.contoso e editando o script para "*contoso" iria buscar todos
os funcionários dessa empresa parceira.
#>
Get-ADUser -Filter {samAccountName -like "*partedonome*"} | select name, SamAccountName, UserPrincipalName, Enabled | Export-Csv C:\temp\terceiroslogi.csv -Delimiter ";" -Encoding UTF8

