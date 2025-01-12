<?php

namespace App\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class HelloTest extends WebTestCase
{
    public function testHello(): void
    {
        $client = static::createClient();
        $crawler = $client->request('GET', '/hello');

        $this->assertResponseIsSuccessful();
        $this->assertSelectorTextContains('body', '❤ Marion ❤ & ❤ Damien ❤ ️');
    }
}
