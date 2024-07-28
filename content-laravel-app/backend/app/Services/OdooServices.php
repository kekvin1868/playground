<?php

namespace App\Services;

use Laminas\XmlRpc\Client;

class OdooService
{
    protected $url;
    protected $db;
    protected $username;
    protected $password;
    protected $uid;
    protected $client;

    public function __construct()
    {
        $this->url = 'https://erp.diawan.id';
        $this->db = 'odoo_diawan';
        $this->username = 'admin';
        $this->password = 'Admin123';
        $this->client = new Client("{$this->url}/xmlrpc/2/common");

        $this->uid = $this->authenticate();

        if (!$this->uid) {
            throw new \Exception('Authentication failed');
        }
    }

    protected function authenticate()
    {
        return $this->client->call('authenticate', [
            $this->db,
            $this->username,
            $this->password,
            []
        ]);
    }

    public function call($model, $method, $args = [], $kwargs = [])
    {
        $client = new Client("{$this->url}/xmlrpc/2/object");

        return $client->call('execute_kw', [
            $this->db,
            $this->uid,
            $this->password,
            $model,
            $method,
            $args,
            $kwargs
        ]);
    }
}
