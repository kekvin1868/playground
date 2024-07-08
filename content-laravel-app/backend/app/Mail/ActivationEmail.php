<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ActivationEmail extends Mailable
{
    use Queueable, SerializesModels;

    public $uuid;

    /**
     * Create a new message instance.
     *
     * @param  string  $uuid
     * @return void
     */
    public function __construct($uuid)
    {
        $this->uuid = $uuid;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->subject('Activate Your Account')
                    ->view('emails.activation')
                    ->with([
                        'uuid' => $this->uuid,
                    ]);
    }
}
