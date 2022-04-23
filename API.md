<div align="center">

# Gerenciador de Produtos

  <p align="center">
    <a href="#api-grupos-de-produtos">
      Grupo de Produtos
    </a>
    &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
    <a href="#api-períodos">
      Períodos
    </a>
    &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
    <a href="#api-planos">
      Planos
    </a>
    &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
    <a href="#api-consumo-de-preços-de-um-plano">
      Consumo de Preços do Plano
    </a>
    &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
    <a href="#api-consumo-de-planos-e-períodos">
      Planos e Períodos 
    </a>
    &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
    <a href="#api-instalação-do-produto">
      Instalação do Produto
    </a>
    &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
    <a href="#api-desativação-de-produto">
      Desativação do Produto
    </a>
  </p>

</div>
<br />
<br />

## API Grupos de Produtos

Como utilizar a API

### URLs:

```
'/api/v1/product_groups'
'/api/v1/product_groups/:id'
```

### Exemplo de requisição:

```
GET /api/v1/product_groups
```

### RESPOSTA:

Status: 200 (OK)

```json
[
  {
    "id":1,
    "name":"Email",
    "key":"EMAIL",
    "description":"Serviços de Email",
    "icon":"/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--f3e9477d5334f949189a228cba4f21d8b3b4c76b/email.png"
  },
  {
    "id":2,
    "name":"Cloud",
    "key":"CLOUD",
    "description":"Serviços de Armazenamento na Nuvem",
    "icon":"/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--2e4d7ec5738b5aceb79d85cca3f04de892af9958/cloud.png"
  }
]
```

### Exemplo de requisição:

```
GET /api/v1/product_groups/1
```

### RESPOSTA:

Status: 200 (OK)

```json
{
  "id":1,
  "name":"Email",
  "key":"EMAIL",
  "description":"Serviços de Email",
  "icon":"/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--f3e9477d5334f949189a228cba4f21d8b3b4c76b/email.png"
}
```
<div align="right">
	<a href="#gerenciador-de-produtos"> retornar ao topo </a>
</div>
<br />
<br />

## API Períodos

Como utilizar a API

### URL:

```
'/api/v1/periods'
```

### Exemplo de requisição:

```
GET /api/v1/periods
```

### RESPOSTA:

Status: 200 (OK)

```json
[
  {
    "id":1,
    "name":"Semestral",
    "months":6},

  {
    "id":2,
    "name":"Mensal",
    "months":1
  }
]
```
<div align="right">
	<a href="#gerenciador-de-produtos"> retornar ao topo </a>
</div>
<br />
<br />

## API Planos

Como utilizar a API

### URLs:

```
'/api/v1/plans'
'/api/v1/plans/:id'
```

### Exemplo de requisição:

```
GET /api/v1/plans
```

### RESPOSTA:

Status: 200 (OK)

```json
[
  {
    "id": 1,
    "name": "Hospedagem Básica",
    "details": "Hospedagem humilde",
    "product_group": {
      "name":"Hospedagem",
      "key":"HOSP"
    }
  },
  {
    "id": 2,
    "name": "Email Premium",
    "details": "Serviço diferenciado de email",
    "product_group": {
      "name":"Email",
      "key":"EMAIL"
    }
  }
]
```

### Exemplo de requisição:

```
GET /api/v1/plans/1
```

### RESPOSTA:

Status: 200 (OK)

```json
{
  "id": 1,
  "name": "Hospedagem Básica",
  "details": "Hospedagem humilde",
  "status": "available",
  "product_group": {
    "name":"Hospedagem",
    "key":"HOSP"
  }
}
```
<div align="right">
	<a href="#gerenciador-de-produtos"> retornar ao topo </a>
</div>
<br />
<br />

## API Consumo de Preços de um Plano

Como utilizar a API

### URL:

```
'/api/v1/plans/:id/prices'
```

### Exemplo de requisição:

```
GET /api/v1/plans/1/prices
```

### RESPOSTA:

Status: 200 (OK)

```json
[
  {
    "id": 1,
    "plan": "Hospedagem Básica",
    "value": "30.0",
    "period": "Mensal"
  },
  {
    "id": 2,
    "plan": "Hospedagem Básica",
    "value": "100.0",
    "period": "Anual"
  }
]
```
<div align="right">
	<a href="#gerenciador-de-produtos"> retornar ao topo </a>
</div>
<br />
<br />

## API Consumo de Planos e Períodos

Apresenta como resposta da requisição uma lista de planos ativos disponíveis e os períodos relacionados, para ver detalhes de um plano especifico é necessário enviar um id como parâmetro no endpoint.

### URLs:

```
'/api/v1/plans_and_periods'
'/api/v1/plans_and_periods/:id'
```

### Exemplo de requisição:

```
GET /api/v1/plans_and_periods
```

### RESPOSTA:

Status: 200 (OK)

```json
[
  {
    "id": 1,
    "name": "Hospedagem Básica",
    "periods": [
      {
        "period": "Mensal",
        "months": 1
      },
      {
        "period": "Semestral",
        "months": 6
      }
    ]
  },
  {
    "id": 2,
    "name": "Email Avançado",
    "periods": [
      {
        "period": "Semestral",
        "months": 6
      }
    ]
  }
]
```
### Exemplo de requisição:

```
GET /api/v1/plans/1
```

### RESPOSTA:

Status: 200 (OK)

```json
{
  "id": 1,
  "name": "Hospedagem Básica",
  "periods": [
    {
      "period": "Mensal",
      "months": 1
    },
    {
      "period": "Semestral",
      "months": 6
    }
  ]
}
```
<div align="right">
	<a href="#gerenciador-de-produtos"> retornar ao topo </a>
</div>
<br />
<br />

## API Instalação do Produto

Como utilizar a API

### URL:

```
'/api/v1/customer_product/installations'
```

### Exemplo de requisição:

```
POST /api/v1/customer_product/installations
```

### PARÂMETROS:

```json
{
  "customer": "12345678900",
  "product_code": "1234567890",
  "plan_id": 1
}
```

### RESPOSTA:

Status: 201 (CREATED)

```json
{
  "id": 1,
  "customer": "12345678900",
  "plan_id": 1,
  "product_code": "1234567890",
  "server_code": "SRV-1111111111111111",
  "status": "active"
}
```
<div align="right">
	<a href="#gerenciador-de-produtos"> retornar ao topo </a>
</div>
<br />
<br />

## API Desativação de Produto

Como utilizar a API

### URL:

```
'/api/v1/customer_product/installations/:product_code/inactive'
```

### Exemplo de requisição:

```
PATCH /api/v1/customer_product/installations/12345678900/inactive
```

### RESPOSTA:

Status: 201 (CREATED)

```json
{
  "id": 1,
  "customer": "12345678900",
  "plan_id": 1,
  "product_code": "1234567890",
  "server_code": "SRV-1111111111111111",
  "status": "inactive"
}
```
<div align="right">
	<a href="#gerenciador-de-produtos"> retornar ao topo </a>
</div>

## Erros

| Response code |  Motivo                           |
| ------------- | ----------------------------------|
| 404  | O registro não foi encontrado              |
| 422  | A requisição está com parâmetros inválidos |
| 500  | Servidor não consegue processar requisição |
| 410  | Acesso ao recurso não está mais disponível |