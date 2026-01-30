#!/usr/bin/env pwsh
# Infrastructure Deployment Script
# Usage: .\deploy-infrastructure.ps1 [-Environment local|k8s] [-Action up|down|restart]

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('local', 'k8s')]
    [string]$Environment = 'local',
    
    [Parameter(Mandatory=$false)]
    [ValidateSet('up', 'down', 'restart', 'status', 'logs')]
    [string]$Action = 'up',
    
    [Parameter(Mandatory=$false)]
    [switch]$Build
)

$ErrorActionPreference = 'Stop'

# Color functions
function Write-Success { Write-Host "✅ $args" -ForegroundColor Green }
function Write-Info { Write-Host "ℹ️  $args" -ForegroundColor Cyan }
function Write-Warning { Write-Host "⚠️  $args" -ForegroundColor Yellow }
function Write-Error { Write-Host "❌ $args" -ForegroundColor Red }

Write-Info "E-Commerce Platform - Infrastructure Deployment"
Write-Info "Environment: $Environment | Action: $Action"
Write-Host ""

# Navigate to project root
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptPath
Set-Location $projectRoot

if ($Environment -eq 'local') {
    $composeFile = "deployment/local/docker-compose.infrastructure.yml"
    
    if (-not (Test-Path $composeFile)) {
        Write-Error "Compose file not found: $composeFile"
        exit 1
    }
    
    switch ($Action) {
        'up' {
            Write-Info "Starting infrastructure containers..."
            docker-compose -f $composeFile up -d
            
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Infrastructure started successfully!"
                Write-Info "Waiting for services to be healthy..."
                Start-Sleep -Seconds 10
                
                Write-Host ""
                Write-Info "Service Status:"
                docker-compose -f $composeFile ps
                
                Write-Host ""
                Write-Info "Access Points:"
                Write-Host "  PostgreSQL:  localhost:5432  (user: ecommerce, pass: dev123)"
                Write-Host "  MongoDB:     localhost:27017 (user: admin, pass: dev123)"
                Write-Host "  Redis:       localhost:6379  (pass: dev123)"
                Write-Host "  RabbitMQ UI: http://localhost:15672 (admin/dev123)"
            } else {
                Write-Error "Failed to start infrastructure"
                exit 1
            }
        }
        
        'down' {
            Write-Warning "Stopping infrastructure (keeping data)..."
            docker-compose -f $composeFile down
            Write-Success "Infrastructure stopped"
        }
        
        'restart' {
            Write-Info "Restarting infrastructure..."
            docker-compose -f $composeFile restart
            Write-Success "Infrastructure restarted"
        }
        
        'status' {
            Write-Info "Infrastructure Status:"
            docker-compose -f $composeFile ps
        }
        
        'logs' {
            Write-Info "Showing infrastructure logs (Ctrl+C to exit)..."
            docker-compose -f $composeFile logs -f
        }
    }
    
} elseif ($Environment -eq 'k8s') {
    Write-Info "Kubernetes deployment not yet implemented"
    Write-Info "Coming in Phase 7 of the project"
}

Write-Host ""
Write-Success "Done!"
