<?php

namespace App\Http\Controllers;

use App\Models\Location;
use App\Models\Attachment;
use App\Models\Complaint;
use App\Models\Institution;
use App\Models\Officer;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ComplaintController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $officers = null;
        $authUser = auth()->user();
        if ($authUser->hasRole('User')) {
            $complaints = Complaint::where('user_id', $authUser->id)->get();
        } elseif ($authUser->hasRole('Officer')) {
            $officer = Officer::where('user_id', $authUser->id)->first();
            $complaints = Complaint::where('assigned_officer_id', $officer->id)->get();
        } elseif ($authUser->hasRole('Super-Admin')) {
            $complaints = Complaint::all();
        } elseif ($authUser->hasRole('Admin')) {
            $complaints = Complaint::where('institution_id', optional(Institution::where('user_id', $authUser->id))->value('id'))->get();
            $officers = Officer::where('institution_id', optional(Institution::where('user_id', $authUser->id))->value('id'))->get();
        } else {
            dd('Access denied!');
        }
        return view('complaints.view-complaints', compact('complaints', 'officers'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('complaints.create-complaints');
    }

    public function store(Request $request)
    {
        try {
            $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'required|string',
                'address' => 'required|string|max:255',
                'images.*' => 'image|mimes:jpeg,png,jpg,gif'
            ]);

            // Start a database transaction
            DB::beginTransaction();

            $userId = auth()->user()->id;

            $complaint = Complaint::create([
                'user_id' => $userId,
                'institution_id' => $request['institution_id'],
                'subject' => $request['title'],
                'description' => $request['description'],
            ]);

            Location::create([
                'complaint_id' => $complaint->id,
                'latitude' => '6.9271',
                'longitude' => '79.8612',
                'address' => $request['address'],
            ]);

            $images = $request->file('images');

            foreach ($images as $image) {
                $timestamp = now()->timestamp;
                $originalName = $image->getClientOriginalName();
                $cleanedName = str_replace(' ', '_', $originalName);
                $path = $image->storeAs(
                    'public/attachment',
                    $timestamp . '_' . $cleanedName
                );
                Attachment::create([
                    'complaint_id' => $complaint->id,
                    'file_path' => 'storage/attachment/' . $timestamp . '_' . $cleanedName,
                ]);
            }

            // Commit the transaction
            DB::commit();

            return redirect()->route('complaint.index')->with('success', 'Complaint submitted successfully!');
        } catch (Exception $e) {
            // Rollback the transaction in case of an exception
            DB::rollBack();

            //// Log the exception for debugging
            // Log::error($e);
            // dd($e->getMessage());
            return redirect()->back()->with('error', 'Error: ' . $e->getMessage());
        }
    }

    public function show(Complaint $complaint)
    {
        $complaint->load('attachments');
        return view('complaints.show-complaints', compact('complaint'));
    }

    public function edit(Complaint $complaint)
    {

        return view('complaints.edit-complaints', compact('complaint'));
    }

    public function update(Request $request, Complaint $complaint)
    {
        try {
            $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'required|string',
                'address' => 'required|string|max:255',
                'images.*' => 'image|mimes:jpeg,png,jpg,gif',
            ]);

            // Start a database transaction
            DB::beginTransaction();

            // Update complaint details
            $complaint->update([
                'subject' => $request['title'],
                'description' => $request['description'],
                'institution_id' => $request['institution_id']
            ]);

            // Update or create location details
            $complaint->location()->updateOrCreate([], [
                'latitude' => '6.9271',
                'longitude' => '79.8612',
                'address' => $request['address'],
            ]);

            // Handle image updates or additions
            $images = $request->file('images');
            if ($images) {
                foreach ($images as $image) {
                    $timestamp = now()->timestamp;
                    $originalName = $image->getClientOriginalName();
                    $cleanedName = str_replace(' ', '_', $originalName);
                    $path = $image->storeAs(
                        'public/attachment',
                        $timestamp . '_' . $cleanedName
                    );

                    Attachment::updateOrCreate(
                        ['complaint_id' => $complaint->id, 'file_path' => 'storage/attachment/' . $timestamp . '_' . $cleanedName],
                        ['file_path' => 'storage/attachment/' . $timestamp . '_' . $cleanedName]
                    );
                }
            }

            // Commit the transaction
            DB::commit();

            return redirect()->route('complaint.index')->with('success', 'Complaint updated successfully!');
        } catch (\Exception $e) {
            // Rollback the transaction in case of an exception
            DB::rollBack();

            // Log the exception for debugging
            Log::error($e);

            return redirect()->back()->with('error', 'Failed to update complaint. Please try again.');
        }
    }
}
