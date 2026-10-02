<?php

namespace App\Entity;

use App\Repository\ProductRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ProductRepository::class)]
class Product
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $Name = null;

    #[ORM\Column]
    private ?int $Price = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $category = null;

    #[ORM\Column]
    private int $stock = 0;

    public function getId(): ?int { return $this->id; }

    public function getName(): ?string { return $this->Name; }
    public function setName(string $Name): static { $this->Name = $Name; return $this; }

    public function getPrice(): ?int { return $this->Price; }
    public function setPrice(int $Price): static { $this->Price = $Price; return $this; }

    public function getCategory(): ?string { return $this->category; }
    public function setCategory(?string $category): static { $this->category = $category; return $this; }

    public function getStock(): int { return $this->stock; }
    public function setStock(int $stock): static { $this->stock = $stock; return $this; }
}