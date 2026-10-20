<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Intervention\Image\Facades\Image;
use Intervention\Image\ImageManagerStatic;

class ConvertToWebPJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $imagePath;
    protected $pathWithoutExt;
    protected $disk;

    /**
     * Create a new job instance.
     */
    public function __construct($imagePath, $pathWithoutExt, $disk)
    {
        $this->imagePath = $imagePath;
        $this->pathWithoutExt = $pathWithoutExt;
        $this->disk = $disk;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        $imagePath = $this->imagePath;
        $pathWithoutExt = $this->pathWithoutExt;
        $disk = $this->disk;

        try 
        {
            $extension = pathinfo($imagePath, PATHINFO_EXTENSION);
            if($extension == "gif"){
                $convertToExtension = "avif";
            }
            else{
                $convertToExtension = "webp";   
            }

            $fullPath = Storage::disk($disk)->path($imagePath);
            
            
           
            if (! file_exists($fullPath)) 
            {
                Log::error("❌ File not found: " . $fullPath);
            } 
            elseif (! is_readable($fullPath)) 
            {
                Log::error("❌ File not readable: " . $fullPath);
            } 
            else 
            {
                Log::info("✅ Processing image: " . $fullPath);
            }
            $webpImage = ImageManagerStatic::make($fullPath)->encode($convertToExtension, 100);
            Storage::disk($disk)->put($pathWithoutExt.".".$convertToExtension, $webpImage);

            $fullwebpPath = Storage::disk($disk)->path($pathWithoutExt.".".$convertToExtension);
            list($originalWidth, $originalHeight) = getimagesize($fullwebpPath);


            $responsiveSizes = $this->getResponsiveSizes($originalWidth);

            // Process each size
            foreach ($responsiveSizes as $label => $config)
            {
                $newPath = $pathWithoutExt."-final-final-{$label}.".$convertToExtension;

                if (!Storage::disk($disk)->exists($newPath)) {
                    if ($config['width'] >= $originalWidth) 
                    {
                        Storage::disk($disk)->copy($fullPath, $newPath);
                    } 
                    else
                    {
                        $resizedImage = Image::make($fullPath)
                            ->widen($config['width'], function ($constraint) {
                                $constraint->upsize();
                            })
                            ->encode($convertToExtension, 100) // or 0 for lossless
                            ->stream();
                            
                        Storage::disk($disk)->put($newPath, $resizedImage);
                    }
                }
            }


        } catch (\Exception $e) {
            Log::error("WebP conversion failed: " . $e->getMessage());
        }
    }




    private function getResponsiveSizes($originalWidth) 
    {
        $sizes = [];
        
        // For small images (< 400px), just create one mobile version
        if ($originalWidth <= 400) {
            $sizes['767'] = [
                'width' => min($originalWidth, 384),
            ];
            return $sizes;
        }
        
        // For medium images (400-720px)
        if ($originalWidth <= 720) {
            $sizes['desktop'] = [
                'width' => $originalWidth,
            ];
            $sizes['991'] = [
                'width' => min($originalWidth, 495),
            ];
            $sizes['767'] = [
                'width' => min($originalWidth, 384),
            ];
            return $sizes;
        }
        
        // For large images (> 720px) - create all sizes
        $sizes = [
            'desktop' => [
                'width' => 720,
            ],
            '991' => [
                'width' => 495,
            ],
            '767' => [
                'width' => 384,
            ]
        ];
        
        return $sizes;
    }

}
